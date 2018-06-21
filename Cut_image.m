
% Opens each image in the range of the for loop one at a time for labeling

%%%% Enter the range of image numbers you want to label here %%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you can also hardcode the directory name here
directory= input('Full path to directory where data is located:\n','s');

directory= strcat(directory,'/');
finish = 0;
i = 1;
while finish ~= 1
    file= int2str(i);
    finish = Cut_DrawRect(directory, file, i);
    fprintf("%d\n", i);
    i = i + 1;
end
