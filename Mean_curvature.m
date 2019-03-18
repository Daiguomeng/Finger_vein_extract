function [Image,I] = Mean_curvature(filepath,parameters)
%��ָ����
    Image = imread(filepath);
    Image = Image(parameters.Window_size(1,1):parameters.Window_size(1,2),parameters.Window_size(1,3):parameters.Window_size(1,4),1);
    if parameters.Image_show_flag
        figure;
        subplot(2,2,1);
        imshow(Image);
        title('ԭʼͼ��');
    end
    Image1 = Image;
    max2 = max(max(Image));
    min2 = min(min(Image));
    %�߶ȹ�һ���ͻҶȹ�һ�����߶ȹ�һ��pass
    Image_nor_double =(255*(double(Image1)-double(min2)))/(double(max2)-double(min2));
    %��ֵ�˲�
    Image_med = medfilt2(Image_nor_double);
    %��˹�˲�
    sigma=3;%��׼���С??
    window=7;%���ڴ�Сһ��Ϊ3*sigma ?
    H=fspecial('gaussian',window, sigma);%fspecial('gaussian',hsize, sigma)�����˲�ģ��? ?
    Image_nor_double=imfilter(Image_med,H,'replicate');%Ϊ�˲����ֺڱߣ�ʹ�ò���'replicate'������ͼ����ⲿ�߽�ͨ�������ڲ��߽��ֵ����չ��
    %��ֵ�˲�
    %Image_nor_double = conv2(double(Image_Gauss),double(0.5),'same');
    if parameters.Image_show_flag
        subplot(2,2,2);
        imshow(uint8(Image_nor_double));
        title('�Ҷȹ�һ�����˲��Ժ�');
    end
    Image_Skeleton = Valley_Search_Gradient(Image_nor_double);
    I = 255*Image_Skeleton;
    if parameters.Image_show_flag
        subplot(2,2,3);
        imshow(uint8(I));
        title('��������');
    end
    level = graythresh(uint8(I));    %Ҳ����ԭ����ѭ������ʹ����䷽����󻯵���ֵ����
    BW = im2bw(uint8(I),level);        %�ҵ���ֵ��ֵ������
    if parameters.Image_show_flag
        subplot(2,2,4);
        imshow(BW);
        title('��ֵ��');
    end
end