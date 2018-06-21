
% Open a window for the user to label either positive or negative
% rectangles for an image. The first two clicks define the endpoint
% of a line PARALLEL to the gripper plate. The third click point is
% projected onto the perpendicular line coming from the second click 
% point
function finish = DrawRect_vector(dir, num)
finish = true;

img= imread([dir, sprintf('pcd%05dr.png', num)]);

imshow(img);

hold on

width = 20;

[xreal,yreal]= ginput(1);
x_center= floor(xreal); % get rid of decimal place
y_center= floor(yreal);

plot(x_center, y_center, 'o', 'MarkerFaceColor',[1 1 1], 'MarkerEdgeColor', 'red')

[xreal,yreal]= ginput(1);
x_end= floor(xreal); % get rid of decimal place
y_end= floor(yreal);

base_line = x_end - x_center;
height = y_end - y_center;
hypo = sqrt(base_line^2 + height^2);

center_coord = [1  0  0  x_center;
                0  1  0  y_center;
                0  0  1  0       ;
                0  0  0  1       ];
trans_coord_1 = [ base_line/hypo -height/hypo    0    0;
                  height/hypo     base_line/hypo 0    0;
                  0               0              1    0;
                  0               0              0    1];
trans_coord_2 = [ 0   1  0  0;
                 -1   0  0  0;
                  0   0  1  0;
                  0   0  0  1]; %rotate -90 degree
trans_coord_3 = [ 1   0  0  width;
                  0   1  0  0;
                  0   0  1  0;
                  0   0  0  1];
trans_coord_4 = [ 1   0  0 -width;
                  0   1  0  0;
                  0   0  1  0;
                  0   0  0  1];
trans_coord_5 = [ 1   0  0  hypo;
                  0   1  0  0;
                  0   0  1  0;
                  0   0  0  1];  
trans_coord_6 = [ 1   0  0  -hypo;
                   0   1  0   0;
                   0   0  1   0;
                   0   0  0   1];  

point1 = center_coord * trans_coord_1 * trans_coord_5 * trans_coord_2 * trans_coord_3;
point2 = center_coord * trans_coord_1 * trans_coord_5 * trans_coord_2 * trans_coord_4;
point3 = center_coord * trans_coord_1 * trans_coord_6 * trans_coord_2 * trans_coord_3;
point4 = center_coord * trans_coord_1 * trans_coord_6 * trans_coord_2 * trans_coord_4;

points = floor([point1(1:2,4) point2(1:2,4) point3(1:2,4) point4(1:2,4)])

plot([points(1,1) points(1,2)], [points(2,1) points(2,2)], '-r',...
     [points(1,1) points(1,3)], [points(2,1) points(2,3)], '-r',...
     [points(1,2) points(1,4)], [points(2,2) points(2,4)], '-r',...
     [points(1,3) points(1,4)], [points(2,3) points(2,4)], '-r')
 
x_vector = base_line / hypo;
y_vector = height / hypo;
height_final = 2 * hypo;
 
keep = 'x';
while keep ~= 'p' && keep ~= 'r' && keep ~= 'q'
    keep= input('\n------------------------------------------------\n Save and go to next image : press P\n Do not save and retry : press R\n Do not save and quit : press Q\n------------------------------------------------\n','s');
    if isempty(keep) || (keep ~= 'p' && keep ~= 'r' && keep ~= 'q')
        fprintf('##please press one of the above keys##');
        keep = 'x';
    elseif keep == 'p'
        f= fopen([dir, sprintf('pcd%05dcpos.txt', num)],'wt');
        fprintf(f, '%f %f %f %f %f', ... 
            x_center, y_center, x_vector, y_vector, height_final);
        fprintf('%s saved\n',sprintf('pcd%05dcpos.txt', num))
        finish = false;
    elseif keep == 'r'
        finish = 2;
    elseif keep == 'q'
        finish = true;
        fprintf('program finished by user\n')
    end
end


close all









% finish = false;
% size = 224;
% % if pos
% %     last= 'cpos.txt';
% % else 
% %     last= 'cneg.txt';
% % end
% 
% img= imread([dir, str, '.png']);
% 
% imshow(img);
% 
% hold on
% 
% % first line is parallel to gripper plate
% 
% repeat= true;
% 
% 
% [xreal,yreal]= ginput(1);
% x= floor(xreal); % first corner
% y= floor(yreal);
% %img(x,y,:)= [255 255 255];
% x1 = x + size/2;
% x2 = x - size/2;
% y1 = y + size/2;
% y2 = y - size/2;
% 
% plot([x1 x2], [y1 y1], 'b');
% 
% plot([x1 x1], [y1 y2], 'b');
% 
% plot([x2 x2], [y1 y2], 'b');
% 
% plot([x1 x2], [y2 y2], 'b');
% 
% keep = 'x';
% while keep ~= 'p' && keep ~= 'd' && keep ~= 'q'
%     keep = input('\n------------------------------------------------\n Save image : press P\n Do not save and crop again : press D \n Do not save and quit : press Q \n------------------------------------------------\n ','s');
%     if isempty(keep) || (keep ~= 'p' && keep ~= 'd' && keep ~= 'q')
%         fprintf('\n##please press one of the above keys##');
%         keep = 'x';
%     end
% end
% 
% 
% if keep == 'p'
%     x1 = round(x1);
%     x2 = round(x2);
%     y1 = round(y1);
%     y2 = round(y2);
%     
%     if num < 100000
%         file = strcat('pcd', sprintf('%05d', num), 'r');
%     else
%         error('File number exceed the limit 100000 please quit the program and make it right')
%     end
%     
%     cropped_img = imcrop(img,[x2 y2 size-1 size-1]); %%%%%
%     imwrite(cropped_img, [dir,file,'.png']);
%     fprintf('\nimage %s saved\n', [file,'.png']);
%   
% %     another= input('Crop another one with this image : press P\n Go to next image : press N\n quit : press Q\n','s');
% %     if another== 'p'
% %         finish = 0;
% %     elseif another == 'o'
% %         finish = 3;
% %     else
% %         finish = 1;
% %     end
%     
%     keep = 'x';
%     while keep ~= 'p' && keep ~= 'n' && keep ~= 'q'
%         keep= input('\n------------------------------------------------\n Crop another one with this image : press P\n Go to next image : press N\n quit : press Q\n------------------------------------------------\n','s');
%         if isempty(keep) || (keep ~= 'p' && keep ~= 'n' && keep ~= 'q')
%             fprintf('##please press one of the above keys##');
%             keep = 'x';
%         elseif keep == 'p'
%             finish = 3;
%         elseif keep == 'n'
%             finish = 0;
%         elseif keep == 'q'
%             finish = 1;
%             fprintf('program finished by user\n')
%         end
%     end
%     
%     
%     
% elseif keep == 'd'
%     finish = 2;
% elseif keep == 'q'
%     finish = 1;
%     fprintf('program finished by user\n')
% end
% 
% hold off
% close all











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
