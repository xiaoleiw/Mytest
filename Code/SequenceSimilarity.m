function SimScore = SequenceSimilarity(s1, s2)
%% if s1 == s2 
% SimScore = 1 
[Score, Alignment] = nwalign(s1, s2); 
SimScore = Score; 

%