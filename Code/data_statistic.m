function stat = data_statistic(matfilename)
matfilename = 'uniprot.mat';
load(matfilename); 
whosname = whos('-file','uniprot.mat');
for i = 1:1:length(whosname)
    varname = whosname(i).name;
    eval( strcat('A{i} = stat_var(', varname, '); ')) ;
    A{i}.name = varname; 
    lenlist(i) = A{i}.len; 
    namelist{i} = varname; 
end
hist(lenlist) 
colormap summer

% Add a legend
%legend('A', 'C', 'G', 'T')

% Add title and axis labels
title('Histogram of non-empty elements')
xlabel('Occurrences')
ylabel('Number of non-empty elements'); 

[B,I] = sort(lenlist); 
sortedName = namelist(I)

boundp = 0.8;
bdlen = boundp * max(lenlist);
k = 1; 

% C = {namelist', num2cell(lenlist)'}
% T = cell2table(C,...
%     'VariableNames',{'Name' 'Len'})

for i = 1:1:length(whosname)
    if A{i}.len >= bdlen
        AvailA{k}.name = A{i}.name;
        AvailA{k}.len = A{i}.len;
        k = k+1;
    end
    
end
cell2csv('a.csv', [namelist', (num2cell(lenlist) )']); 

% END
save
%temp_table = struct2table(AvailA);
%writetable(temp_table,'data.csv')
% T = table(namelist,lenlist); 
% writetable(T);
save 
save test.mat AvailA A

end 


function A = stat_var(x)
%clear; 
%x = Bindingsite
%first: find non empty 
%A.name = 
%x = num2cell(x); 
if iscell(x)
nex = find(~cellfun(@isempty,x)); 

    if isempty(nex) 
        A.len = 0;

        return
    else
        A.len = length(nex);
    end
else
    if isnumeric(x)
        A.len = length(x);
        %A.maxv = max(x);
        %A.min = min(x)
        %A.avr = mean(x); 
    end 
    
end 

A.len

end

        
        
        

    