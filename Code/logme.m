function [ ] = logme( err, txt)
% log exception information to file


if nargin < 2
    txt = ''
end
%txt = char(txt);
%open file
fid = fopen('logFile','a+');
% write the error to file
% first line: message
fprintf(fid,'%s\n',err.message);

% following lines: stack
for e=1:length(err.stack)
    fprintf(fid,'%sin %s at %i\n',char(txt),err.stack(e).name,err.stack(e).line);
end

% close file
fclose(fid);
end

