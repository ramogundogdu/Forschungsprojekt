function [ VertsOut_xyz, WM ] = laplaceDeformGeometric( ConnectivityList, VertsT0_xyz, VertsFixedT1_xyz )
% Coordinate deformation / smoothing through laplacian operation

% ConnectivityList: -
% VertsT0_xyz: 3xN Matrix with Vertex positions at t0
% VertsFixedT1_xyz: 3xN Matrix with fixed/know Vertex positions at t1. Same
% dimensions as VertsT0_xyz; if Position of certain Verticies is unknown,
% inf/nan/0 should be placed at this row index

disp('-------- starting: laplaceDeformGeometric');

    numVerts = size(VertsT0_xyz, 2);
    
    numVertsFixed = size(VertsFixedT1_xyz, 2);
    AM = zeros(numVerts, numVerts);
    
disp('-------- building laplace');

    % === adjacency matrix
    for vI=1:numVerts

        % get all neighbours (indizies) of vI, excluding vI itself 
        % - adjacency matrix
        vINeighbours = ConnectivityList(:, any(ConnectivityList == vI));
        vINeighbours = unique(vINeighbours,'sorted')';
        vINeighbours = vINeighbours(:,~(vINeighbours == vI));

        vINumNeighbours = size(vINeighbours, 2);

        % set neighbour cols to 1
        % only process upper half of symetrical matrix
        AM(vI, vINeighbours) = -1;

        % set adjM(vI, vI) to number of neighbours
        AM(vI,vI) = vINumNeighbours;
    end
    
    
    % ================= weight matrix
    WM = AM;

    disp('-------- building weight matrix');
    
    % for each vertex vI
    for i=1:numVerts
        
        % ????
        weightSum = 0;
        
        % vertex coords of vI
        vI = VertsT0_xyz(:, i);
        
        
        % OLD
        %
        % build weight for every neighbour vJ
        % for j=1:numVerts
        
        % PERFORMANCE improve, loop just over neede indizies
        adjIndx = find(ismember(AM(i,:),[-1]));
        
        for j = adjIndx
            
            % OLD
            %
            % if vJ is neighbour of vI
            %if( AM(i,j) == -1 )
                
                % vertex coords of vI
                vJ = VertsT0_xyz(:, j);
        
                commonFaces = ConnectivityList(:,any(ConnectivityList == i) & any( ConnectivityList == j));
                commonNeighbourInd = unique(commonFaces(:));
                commonNeighbourInd = commonNeighbourInd(commonNeighbourInd ~= i & commonNeighbourInd ~= j, 1);
                
                % number of common neighbours
                numCommonNeighbours = size(commonNeighbourInd,1);
 
                % angle alpha
                vAlpha = VertsT0_xyz(:, commonNeighbourInd(1,1));
                
                v1 = vI-vAlpha;
                v2 = vJ-vAlpha;
                
                alpha = dot(v1, v2) / (norm(v1) * norm(v2));
                alpha = acosd(alpha);
                
                % if we found 2 neighbours
                if (numCommonNeighbours == 2)
                    
                    % angle beta
                    vBeta = VertsT0_xyz(:, commonNeighbourInd(2,1));

                    v3 = vI-vBeta;
                    v4 = vJ-vBeta;

                    beta = dot(v3, v4) / (norm(v3) * norm(v4));
                    beta = acosd(beta);

                    weight = (cotd(alpha) + cotd(beta))/2;
                
                % edge case - only 1 common neighbour
                elseif (numCommonNeighbours == 1)
                        
                    weight = cotd(alpha);  
                    
                end
                
                WM(i,j) = -weight; %  negative weight
                
                % ???
                weightSum = weightSum + weight;
                
            %end
            
        end
        
        % ???
        WM(i,i) = weightSum;
        
    end
    
% ================= differential coords 

% NEW: get differential coords by martix-vector multiplication!
    disp('-------- computing differential coordinats');

    dX = WM * VertsT0_xyz(1,:)';
    dY = WM * VertsT0_xyz(2,:)';
    dZ = WM * VertsT0_xyz(3,:)';

% OLD:
%     dX = zeros(numVerts,1);
%     dY = zeros(numVerts,1);
%     dZ = zeros(numVerts,1);
%     
%     % for every vertex vI
%     for i=1:numVerts
%         
%         % vertex coords of vI
%         vI = VertsT0_xyz(:, i);
%         
%         %neighbourInd = AM(1,:) == -1;
%         
%         dXSum = 0;
%         dYSum = 0;
%         dZSum = 0;
%         dWSum = 0;
%         
%         % for each neighbour
%         for j=1:numVerts
%             if(AM(i,j) == -1) 
%                 
%                 vJ = VertsT0_xyz(:, j);
%                 weightJ = WM(i,j);
%                 
%                 dXSum = dXSum + weightJ * vJ(1,1);
%                 dYSum = dYSum + weightJ * vJ(2,1);
%                 dZSum = dZSum + weightJ * vJ(3,1);
%                 dWSum = dWSum + weightJ;
%                 
%             end
%         end
%         
%         dX(i,1) = vI(1,1) - dXSum/dWSum;
%         dY(i,1) = vI(2,1) - dYSum/dWSum;
%         dZ(i,1) = vI(3,1) - dZSum/dWSum;
%         
%     end
    
    
% ================= RECONSTRUCTION of absolute coordinates

% !!! don't alter WM from here on. It must be exported in this form
M = WM;

% add constraints

disp('-------- adding constraints');

% FOR PERFORMANCE REASONS:
% get number of constraints (non nan cols), assuming nan in all rows!
numConstraints = size( VertsFixedT1_xyz(1, ~isnan(VertsFixedT1_xyz(1,:))),2 );

% initialize rows, that have to be appended to diff-coords and M
MConst = zeros(numConstraints, numVerts);
dXConst = zeros(numConstraints, 1);
dYConst = zeros(numConstraints, 1);
dZConst = zeros(numConstraints, 1);

% separate loop counter for constraint indizies
constItCount = 1;

% compute them and append them after the loop!
for vI=1:numVertsFixed
       
    currVFixed = VertsFixedT1_xyz(:,vI);
    
    % continue if no constraint is given
    isInvalid = any( isnan( currVFixed ) );
    if(isInvalid) 
        continue;
    end
    
    % insert values indexed - much faster!
    MConst(constItCount, vI) = 1;
    
    dXConst(constItCount,1) = currVFixed(1,1);
    dYConst(constItCount,1) = currVFixed(2,1);
    dZConst(constItCount,1) = currVFixed(3,1);
    
    % increase counter for inserted constraints
    constItCount = constItCount + 1;
    
    % OLD:
    %
    % constRow = zeros(1,numVerts);
    % constRow(1, vI) = 1;
    % M = [M; constRow];
    % 
    % dX = [dX; currVFixed(1,1)];
    % dY = [dY; currVFixed(2,1)];
    % dZ = [dZ; currVFixed(3,1)];
    
end

% append constraints in one step!

M = [M; MConst];
dX = [dX; dXConst];
dY = [dY; dYConst];
dZ = [dZ; dZConst];

% resolve  LGS

disp('-------- start solving 1st LGS');
recX = M\dX;
disp('-------- start solving 2nd LGS');
recY = M\dY;
disp('-------- start solving 3rd LGS');
recZ = M\dZ;

% new Vertex position format

VertsOut_xyz = [ recX'; recY'; recZ'];

% TODO - restore positions of known fixed points!!!
disp('-------- done: laplaceDeformGeometric');    

end

    
    
    