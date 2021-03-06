
% Opens each image in the range of the for loop one at a time for labeling

%%%% Enter the range of image numbers you want to label here %%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you can also hardcode the directory name here
directory= input('Full path to directory where data is located:\n','s');

directory= strcat(directory,'/');
finish = 0;

i = input('Which image number you want start from? : ');

list = dir([directory, '*r.png']);
n = length(list);

if n ~= 0
    [list] = sort({list.name});
    last_one = char(list(n));
    j = str2num(last_one(4:8))+1;
    fprintf("Start saving from pcd%05dr.png", j);
else
    j = 1;
    fprintf("Start saving from pcd%05dr.png", j);
end

memory = [];

while finish ~= 1
%     file= int2str(i);
    fprintf('\n\nread %05d.png\n',i);
    [finish, memory] = Cut_DrawRect_224(directory, sprintf('%05d',i), j, memory);
    if finish == 0
        i = i + 1;
        j = j + 1;
        memory
        memory = [];
        fprintf('Go to next image');
    elseif finish == 4
        i = i + 1;
        memory
        memory = [];
        fprintf('Go to next image');
    elseif finish == 3        
        j = j + 1;
        fprintf('Stick to this image');
    elseif finish == 2
        fprintf('Recrop the image');
    elseif finish == 5
%         number = length(memory);
%         memory = memory(1:number-1);
        fprintf('Recrop the image');
    end
end

memory

