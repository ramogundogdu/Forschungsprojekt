function groundTruthOFlowStruct = groundTruthOFlow2 (groundTruthMap, oFlowMap)

% 
%  if (groundTruthMap ~= oFlowMap)
%             error('map size is different');
%     end
%  

for groundTruthOFlowRow2 = groundTruthMap(1:1:end,1); 
    
    for groundTruthOFlowColumn2 = groundTruthMap(1:1:end,:);  
        
        for oFlowMapRow2 = oFlowMap(1:1:end,1); 
            
            for oFlowMapColumn2 = oFlowMap(1:1:end,:);      
                
%     groundTruthOFlowStructBetrag = abs(groundTruthMap) - abs(oFlowMap);

    groundTruthOFlowStruct = abs(groundTruthMap - oFlowMap)^2;
    
%     groundTruthOFlowANgle
    
    end
    
        end
    end
end




