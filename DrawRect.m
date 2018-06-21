
% Open a window for the user to label either positive or negative
% rectangles for an image. The first two clicks define the endpoint
% of a line PARALLEL to the gripper plate. The third click point is
% projected onto the perpendicular line coming from the second click 
% point
function DrawRect(dir,str, pos)
img= imread(strcat(dir, str, '.png'));

if pos
    last= 'cpos.txt';
else 
    last= 'cneg.txt';
end

FID= fopen(strcat(dir, str(1:length(str)-1),last),'wt');

imshow(img);

hold on

% first line is parallel to gripper plate

repeat= true;

while(repeat)
    [xreal,yreal]= ginput(1);
    x= floor(xreal); % first corner
    y= floor(yreal);
    %img(x,y,:)= [255 255 255];

    [xreal,yreal]= ginput(1);
    x1= floor(xreal); %second corner
    y1= floor(yreal);

    plot([x x1], [y y1], 'b');

    [xr, yr]= ginput(1);
    
    m= (y1-y)/(x1-x);
 
    mPerp= -1/m;
        
    if m==0
        x2= x1;
        y2= yr;
        
        x3= x;
        y3= yr;
        
    elseif mPerp==0
        x2= xr;
        y2= y1;
        
        x3= xr;
        y3= y;
        
    else

       x2= (yr-y1+mPerp*x1-m*xr)/ (mPerp-m);
       y2= y1+mPerp*(x2-x1);
        
       l= sqrt((x1-x)^2+(y1-y)^2);

       if(y1>y)
           y3= y2-sqrt((m^2*l^2)/(1+m^2));
       else
           y3= y2+sqrt((m^2*l^2)/(1+m^2));
       end

       x3= x2+ (y3-y2)/m;

    end
   


    
    plot([x1 x2], [y1 y2], 'r');

    plot([x2 x3], [y2 y3], 'b');

    plot([x x3], [y y3], 'r');

    
    keep= input('keep? p for yes\n','s');
    x3 = round(x3);
    x2 = round(x2);
    
    if keep=='p'
        fprintf(FID, '%g %g \n%g %g \n%g %g \n%g %g\n', ... 
            x2,y2,x1,y1,x,y,x3,y3);
    end
    another= input('add another? p for yes\n','s');
    if another== 'p'
        repeat= true;
    else
        repeat= false;
    end
end

hold off
close all
fclose(FID);

