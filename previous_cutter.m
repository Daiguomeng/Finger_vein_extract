%clc;clear;close all;
function [Image_Skeleton_cut,flag] = previous_cutter(filepath)
field1 = 'Window_size';
value1 = [40 225 15 270];
field2 = 'Image_show_flag';
value2 = 0;
field3 = 'offset';
value3 = 0;
parameters = struct(field1,value1,field2,value2,field3,value3);
%filepath = 'C:\Users\daiguomeng\Desktop\Finger\Finger Vein Database\Finger Vein Database\Finger Vein Database\065\left\middle_5.bmp';
Image = imread(filepath);
Image = Image(parameters.Window_size(1,1):parameters.Window_size(1,2),parameters.Window_size(1,3):parameters.Window_size(1,4),1);
if parameters.Image_show_flag
    figure;
    subplot(2,1,1);
    imshow(Image);
    title('Ô­Ê¼Í¼Ïñ');
end
[~,n]=size(Image);
[BW2,~]=edge(Image,'canny');
% figure
% imshow(BW2);
[g,num]=bwlabel(BW2,8);
max_line =[];
min_line =[];
for i=1:num
    [r,c] = find(g==i);
    a = [r c];
    if length(a(:,1))>=n-6 && a(1,1)<n/2
        if isempty(min_line)
            min_line = a;
        else
            if a(1,1)>min_line(1,1)
                min_line = a;
            end
        end
    else
        if length(a(:,1))>=n-6 && a(1,1)>n/2
            if isempty(max_line)
                max_line = a;
            else
                if a(1,1)<max_line(1,1)
                    max_line = a;
                end
            end
        end
    end
end
if isempty(min_line)
    flag = 0;
    Image_Skeleton_cut = 0;
    return;
end
if isempty(max_line)
    flag = 0;
    Image_Skeleton_cut = 0;
    return;
end
[~,Index] = unique(min_line(:,2),'rows');
min_line= min_line(Index,:);
[~,Index] = unique(max_line(:,2),'rows');
max_line= max_line(Index,:);
if size(min_line,1)~=size(max_line,1)
    flag = 0;
    Image_Skeleton_cut =0;
    return;
end
flag = 1;
line = (max_line+min_line)/2;
Image_Skeleton_cut = zeros(91,size(line,1));
[~,Image_Skeleton] = Mean_curvature(filepath,parameters);
for i = 1:size(line,1)
    if line(i,1) == floor(line(i,1))
        Image_Skeleton_cut(:,i) = Image_Skeleton((line(i,1)-45):(line(i,1)+45),i+1);
    else
        Image_Skeleton_cut(:,i) = (Image_Skeleton(floor(line(i,1)-45):floor(line(i,1)+45),i+1)+Image_Skeleton(floor(line(i,1)-45)+1:floor(line(i,1)+45)+1,i+1))/2;
    end
end
if parameters.Image_show_flag
    %figure;
    subplot(2,1,2);
    imshow(uint8(Image_Skeleton_cut));
    title('²Ã¼ôÍ¼');
end
%disp(corr2(Image_Skeleton_cut1,Image_Skeleton_cut));