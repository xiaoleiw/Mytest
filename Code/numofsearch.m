function [ num ] = numofsearch( keyword )
num = 0;

% search keywork on google and return the estimated number of results
try
    url = 'https://www.google.com/search';
    str = urlread(url,'Get',{'q',keyword,'num','1'}, 'Timeout', 60, 'Charset','UTF-8', 'UserAgent','Google Chrome/36');
    pat = 'About\s([\d,]+)\sresults';
    countstr = regexp(str,pat,'tokens','once','ignorecase');
    num = str2double(countstr);
catch ME
    logme(ME, keyword);
end
end