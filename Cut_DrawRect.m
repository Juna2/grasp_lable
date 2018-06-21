
% Open a window for the user to label either positive or negative
% rectangles for an image. The first two clicks define the endpoint
% of a line PARALLEL to the gripper plate. The third click point is
% projected onto the perpendicular line coming from the second click 
% point
function finish = Cut_DrawRect(dir, str, num)

finish = 0;

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

[xreal,yreal]= ginput(1);
x1= floor(xreal); %second corner
y1= floor(yreal);

plot([x x1], [y y], 'b');

plot([x x], [y y1], 'b');

plot([x1 x1], [y y1], 'b');

plot([x x1], [y1 y1], 'b');


keep= input('keep? p for yes\n','s');
x = round(x);
x1 = round(x1);
y = round(y);
y1 = round(y1);

if num<10
    file= strcat('pcd010',int2str(num),'r');
elseif num<100
    file= strcat('pcd01',int2str(num),'r');
elseif num<1000
    file= strcat('pcd0',int2str(num+100),'r');
elseif num<10000
    file= strcat('pcd',int2str(num+100),'r');
else
    fprintf("file name is bigger than 10000\n")
end

if keep=='p'
    cropped_img = imcrop(img,[x y x1-x y1-y]); %%%%%
    imwrite(cropped_img, [dir,file,'.png']);
else
   finish = 1;
end

if finish == 0
    another= input('add another? p for yes\n','s');
    if another== 'p'
        finish = 0;
    else
        finish = 1;
    end
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
