function mainsimtest() 

N = 10; 
% the max number of test cases running. 

%% similiarity  main function test 
load SCross_Keywords.mat
%size(S.Sequence)
% ans =
% 
%        35660           1
% 
SsimScoreMat = eye(N, N); 
StructureScoreMat = eye(N, N); 
for i = 1:1:N
    for j = 1:1:N
        s1 = S.Sequence{i};
        s2 = S.Sequence{j};
        SimScore = SequenceSimilarity(s1, s2);
        SsimScoreMat(i,j) = SimScore;
        
        stru1 = S.Cross_reference_PDB_{i};
        stru2 = S.Cross_reference_PDB_{j};
        structureScore = PDBID_StructureSimilarity(stru1, stru2); 
        
        StructureScoreMat(i,j) = structureScore; 
    end
end
SsimScoreMat 
NormSsimScoreMat = SimMatNormDiag1(SsimScoreMat) 
NormStructureScoreMat = SimMatNormDiag1(StructureScoreMat)

%SimScore = PDBID_StructureSimilarity(s1, s2)
