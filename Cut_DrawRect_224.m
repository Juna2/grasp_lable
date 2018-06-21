
% Open a window for the user to label either positive or negative
% rectangles for an image. The first two clicks define the endpoint
% of a line PARALLEL to the gripper plate. The third click point is
% projected onto the perpendicular line coming from the second click 
% point
function [finish, memory] = Cut_DrawRect_224(dir, str, num, memory)

finish = 0;
size = 224;
% if pos
%     last= 'cpos.txt';
% else 
%     last= 'cneg.txt';
% end

img= imread([dir, str, '.png']);

imshow(img);

hold on

% first line is parallel to gripper plate

repeat= true;


[xreal,yreal]= ginput(1);
x= floor(xreal); % first corner
y= floor(yreal);
%img(x,y,:)= [255 255 255];
x1 = x + size/2;
x2 = x - size/2;
y1 = y + size/2;
y2 = y - size/2;

plot([x1 x2], [y1 y1], 'b');

plot([x1 x1], [y1 y2], 'b');

plot([x2 x2], [y1 y2], 'b');

plot([x1 x2], [y2 y2], 'b');

keep = 'x';
while keep ~= 'p' && keep ~= 'd' && keep ~= 'q' && keep ~= 'n'
    keep = input('\n------------------------------------------------\n Save image : press P\n Do not save and crop again : press D \n Do not save and go to next image : press N\n Do not save and quit : press Q \n------------------------------------------------\n ','s');
    if isempty(keep) || (keep ~= 'p' && keep ~= 'd' && keep ~= 'q' && keep ~= 'n')
        fprintf('\n##please press one of the above keys##');
        keep = 'x';
    end
end


if keep == 'p'
    x1 = round(x1);
    x2 = round(x2);
    y1 = round(y1);
    y2 = round(y2);
    
    if num < 100000
        file = strcat('pcd', sprintf('%05d', num), 'r');
    else
        error('File number exceed the limit 100000 please quit the program and make it right')
    end
    
    cropped_img = imcrop(img,[x2 y2 size-1 size-1]); %%%%%
    imwrite(cropped_img, [dir,file,'.png']);
    memory = [memory string([file, '.png'])];
    fprintf('\nimage %s saved\n', [file,'.png']);
  
%     another= input('Crop another one with this image : press P\n Go to next image : press N\n quit : press Q\n','s');
%     if another== 'p'
%         finish = 0;
%     elseif another == 'o'
%         finish = 3;
%     else
%         finish = 1;
%     end
    
    keep = 'x';
    while keep ~= 'p' && keep ~= 'n' && keep ~= 'q' && keep ~= 'r'
        keep= input('\n------------------------------------------------\n Crop another one with this image : press P\n Go to next image : press N\n Recrop the image just saved : press R\n quit : press Q\n------------------------------------------------\n','s');
        if isempty(keep) || (keep ~= 'p' && keep ~= 'n' && keep ~= 'q' && keep ~= 'r')
            fprintf('##please press one of the above keys##');
            keep = 'x';
        elseif keep == 'p'
            finish = 3;
        elseif keep == 'n'
            seperate_img = zeros(224, 224, 3);
            imwrite(seperate_img, [dir,file,'.png']);
            finish = 0;
        elseif keep == 'r'
            finish = 5;
        elseif keep == 'q'
            finish = 1;
            fprintf('program finished by user\n')
        end
    end
    
    
elseif keep == 'n'
    file = strcat('pcd', sprintf('%05d', num), 'r');
    seperate_img = zeros(224, 224, 3);
    imwrite(seperate_img, [dir,file,'.png~']);
    finish = 4;    
elseif keep == 'd'
    finish = 2;
elseif keep == 'q'
    finish = 1;
    fprintf('program finished by user\n')
end

hold off
close all











% 
% if num<10
%     file= strcat('pcd000',int2str(num),'r');
% elseif num<100
%     file= strcat('pcd00',int2str(num),'r');
% else
%     file= strcat('pcd0',int2str(num),'r');
% end
% 
% 
% 
% 
% imwrite(img, sprintf('Dataset/Images/%.8i.jpg',index));
