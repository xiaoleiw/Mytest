function [ keywords ] = buildkeyset( colcell )
% build a keywords set from the column value of uniprot
if iscell(colcell)
    unirows = unique(colcell);
    keywords = strsplit(unirows{1,1},';');
    for i = 2:length(unirows)
        keywords = [keywords, strsplit(unirows{i,1},';')];
    end
    keywords = unique(keywords);
end
keywords(~cellfun('isempty',keywords));
keywords(strcmp('',keywords)) = [];
end  