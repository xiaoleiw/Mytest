function NormM = SimMatNormDiag1(M) 
%normalize the similarity matrix with diagonal value = 1
e = 0.001; 
%% Normalization section 
I = M; 
ln = length(M) 
scaledI = eye(ln,ln); 
for i = 1:1:ln
    scaledI(i,:) =( (I(i,:)-min(I(i,:))) + e)./ (max(I(i,:)-min(I(i,:)))) + e;
end

min(scaledI(:)) % the min is 0
max(scaledI(:)) % the max 1
NormM = scaledI; 
