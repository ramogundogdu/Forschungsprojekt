function groundTruthOFlowStruct = groundTruthOFlow (groundTruthMap, oFlowMap)


% 
%  if (groundTruthMap ~= oFlowMap)
%             error('map size is different');
%     end
%  

for groundTruthOFlowRow = groundTruthMap(1:1:end,1); 
    
    for groundTruthOFlowColumn = groundTruthMap(1:1:end,:);  
        
        for oFlowMapRow = oFlowMap(1:1:end,1); 
            
            for oFlowMapColumn = oFlowMap(1:1:end,:);      
                
    groundTruthOFlowStruct = groundTruthMap - oFlowMap;
    
    end
    
        end
    end
end




