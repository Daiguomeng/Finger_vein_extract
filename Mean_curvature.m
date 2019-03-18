function [Image,I] = Mean_curvature(filepath,parameters)
%手指区域
    Image = imread(filepath);
    Image = Image(parameters.Window_size(1,1):parameters.Window_size(1,2),parameters.Window_size(1,3):parameters.Window_size(1,4),1);
    if parameters.Image_show_flag
        figure;
        subplot(2,2,1);
        imshow(Image);
        title('原始图像');
    end
    Image1 = Image;
    max2 = max(max(Image));
    min2 = min(min(Image));
    %尺度归一化和灰度归一化，尺度归一化pass
    Image_nor_double =(255*(double(Image1)-double(min2)))/(double(max2)-double(min2));
    %中值滤波
    Image_med = medfilt2(Image_nor_double);
    %高斯滤波
    sigma=3;%标准差大小??
    window=7;%窗口大小一半为3*sigma ?
    H=fspecial('gaussian',window, sigma);%fspecial('gaussian',hsize, sigma)产生滤波模板? ?
    Image_nor_double=imfilter(Image_med,H,'replicate');%为了不出现黑边，使用参数'replicate'（输入图像的外部边界通过复制内部边界的值来扩展）
    %均值滤波
    %Image_nor_double = conv2(double(Image_Gauss),double(0.5),'same');
    if parameters.Image_show_flag
        subplot(2,2,2);
        imshow(uint8(Image_nor_double));
        title('灰度归一化及滤波以后');
    end
    Image_Skeleton = Valley_Search_Gradient(Image_nor_double);
    I = 255*Image_Skeleton;
    if parameters.Image_show_flag
        subplot(2,2,3);
        imshow(uint8(I));
        title('静脉区域');
    end
    level = graythresh(uint8(I));    %也就是原理中循环查找使得类间方差最大化的阈值步骤
    BW = im2bw(uint8(I),level);        %找到阈值二值化即可
    if parameters.Image_show_flag
        subplot(2,2,4);
        imshow(BW);
        title('二值化');
    end
end