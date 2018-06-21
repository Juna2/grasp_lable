
% Opens each image in the range of the for loop one at a time for labeling
%%%% Enter the range of image numbers you want to label here %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you can also hardcode the directory name here
directory= input('Full path to directory where data is located:\n','s');

directory= strcat(directory,'/');

list = dir([directory, '*cpos.txt']);
n = length(list);
if n ~= 0
    i = str2num(list(n).name(4:8));
    fprintf('%f', i)
    fprintf("Let's start from %s", list(n).name);
else
    list = dir([directory, '*r.png']);
    n = length(list);
    if n ~= 0
        i = str2num(list(1).name(4:8));
        fprintf('%f', i)
        fprintf("Let's start from %s", list(n).name);
    else
        i = 1;
    end
end

finish = 0;

while finish ~= true
    fprintf('\n\nread pcd%05dr.png\n', i);
    finish = DrawRect_vector(directory, i);
    if finish == false
        i = i + 1;
    end
end
