function SimScore = PDBID_StructureSimilarity(s1, s2)
%% if s1 == s2 
% SimScore = 1 

%first, split the s1 and s2 into pdb ids 
slist1 = buildkeyset(cellstr(s1))
slist2 = buildkeyset(cellstr(s2))
%function [ keywords ] = buildkeyset( colcell )
% build a keywords set from the column value of uniprot


l1 = length(slist1);
l2 = length(slist2); 
d = ones(l1, l2);

for i = 1:1:l1
    for j = 1:1:l2
        p1 = slist1{i};
        p2 = slist2{j};
        
        [d(i,j), rmsd(i,j) ] = pdbsuperpose(p1, p2);
    end
end
Score = min(min(d)); 

SimScore = 1./Score; 
%