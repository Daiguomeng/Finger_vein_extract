clc;clear;close all;
field1 = 'Window_size';
value1 = [61 180 1 320];
field2 = 'Image_show_flag';
value2 = 0;
field3 = 'offset';
value3 = 0;
parameters = struct(field1,value1,field2,value2,field3,value3);
[sel, ok]=listdlg('ListString',{'��ͬ��ָƥ��','��ͬ��ָƥ��'},...
    'Name','��ѡ��ƥ����ʽ','OKString','ȷ��','CancelString','ȡ��','SelectionMode','single','ListSize',[180 80]);
if ok == 1
    if sel == 1
        file_path = uigetdir(matlabroot,'ѡ��ͼƬ·��');
        corr_value = Same_match_patterns(file_path,parameters);
        disp(corr_value);
    else
        if sel == 2
            [filename,pathname] = uigetfile({'*.bmp;*.jpg;*.tif;*.png','All Image Files';...
          '*.*','All Files' },'ѡ����ͼƬ');
            corr_value = Different_match_patterns(filename,pathname,parameters);
            figure
            plot(1:512,corr_value);
        end
    end
else
    exit(0);
end

