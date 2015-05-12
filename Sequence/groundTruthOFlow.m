function groundTruthOFlowStruct = groundTruthOFlow (groundTruthMap, oFlowMap)

oFlowMap = UVFlowCell(1).cdata;
% groundTruthMap = ?;


 if (groundTruthMap ~= oFlowMap)
            error('map size is different');
    end
 

for groundTruthOFlowRow = groundTruthOFlow(1:1:end,1); 
    
    for groundTruthOFlowColumn = groundTruthOFlow(1:1:end,:);  
        
        for oFlowMapRow = oFlowMap(1:1:end,1); 
            
            for oFlowMapColumn = oFlowMap(1:1:end,:);      
                
    groundTruthOFlowStruct = groundTruthMap - oFlowMap;
    
    end
    
        end
    end
end




