clc;clear;close all;
field1 = 'Window_size';
value1 = [61 180 1 320];
field2 = 'Image_show_flag';
value2 = 0;
field3 = 'offset';
value3 = 0;
parameters = struct(field1,value1,field2,value2,field3,value3);
[sel, ok]=listdlg('ListString',{'相同手指匹配','不同手指匹配'},...
    'Name','请选择匹配形式','OKString','确定','CancelString','取消','SelectionMode','single','ListSize',[180 80]);
if ok == 1
    if sel == 1
        file_path = uigetdir(matlabroot,'选择图片路径');
        corr_value = Same_match_patterns(file_path,parameters);
        disp(corr_value);
    else
        if sel == 2
            [filename,pathname] = uigetfile({'*.bmp;*.jpg;*.tif;*.png','All Image Files';...
          '*.*','All Files' },'选择主图片');
            corr_value = Different_match_patterns(filename,pathname,parameters);
            figure
            plot(1:512,corr_value);
        end
    end
else
    exit(0);
end

