oFlowMap = [UVFlowCell{1,1}];
% oFlowMap = UVFlowCell(1).cdata;

groundTruthMap = groundTruth;
Testing = groundTruthOFlow (groundTruthMap, oFlowMap);
