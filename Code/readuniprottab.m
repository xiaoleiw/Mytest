function S = readuniprottab(filename, valid_ratio)
if nargin<3
    valid_ratio = 0.8;
end

disp('start reading file');
T = readtable(filename,'Delimiter','\t','ReadVariableNames',true);
S = table2struct(T,'ToScalar',true);
disp('finish reading file');

maxlen = length(S.Entry);
lengths = structfun(@valid_length, S);
names = fieldnames(S);

disp('start filtering');
for i=1:length(lengths)
    if lengths(i) < valid_ratio*maxlen
        disp(names(i));
        S = rmfield(S,names(i));
    end
end
disp('finish filtering');

disp('start creating entry-index dict');
keys = S.Entry;
values = num2cell((1:maxlen)');
S.EntryIndexDict = containers.Map(keys,values);
disp('finish creating dict');
end

function len = valid_length(field)
len = 0;
if iscell(field)
    nex = find(~cellfun(@isempty,field));
    if isempty(nex)
        return
    else
        len = length(nex);
    end
else
    if isnumeric(field)
        if isnan(field)
            return
        else
            len = length(field);
        end
    end
end
end