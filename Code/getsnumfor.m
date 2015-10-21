function [ numdict ] = getsnumfor( keywords )
% get numofsearch for each keyword, and setup a dict for result

%numdict = containers.Map;
len = length(keywords);
parfor i = 1:len
    nums(i) = numofsearch(keywords(i));
end
numdict = containers.Map(keywords,nums);
end