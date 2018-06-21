
% Opens each image in the range of the for loop one at a time for labeling

%%%% Enter the range of image numbers you want to label here %%%%%

from = 1; % image number to start labeling from
to = 100; % image number to label to

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% you can also hardcode the directory name here
directory= input('Full path to directory where data is located:\n','s');

directory= strcat(directory,'/');

for i= from:to
   
    if i<10
        file= strcat('pcd010',int2str(i),'r');
    elseif i<100
        file= strcat('pcd01',int2str(i),'r');
    elseif i<1000
        file= strcat('pcd0',int2str(i),'r');
    elseif i<10000
        file= strcat('pcd',int2str(i),'r');
    else 
        fprintf("Finished or file name is bigger than 10000\n")
    end
    
    try
        DrawRect_vector(directory, file);
    catch error 
        if (strcmp(error.identifier,'MATLAB:imread:fileOpen'))
            fprintf('\nError loading file %s from directory %s\nPlease try again',file,directory)
        end
    end
end