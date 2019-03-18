function corr_value = Different_match_patterns(filename,pathname,parameters)
%配准
%此处的Image_file 为匹配主影像
Image_file = [pathname,filename];
[~,img_A_Skeletion] = Mean_curvature(Image_file,parameters);
% [optimizer, metric] = imregconfig('multimodal');
% optimizer.GrowthFactor = 1.01;
% optimizer.Epsilon = 1.5e-6;
% optimizer.InitialRadius = 0.001;
% optimizer.MaximumIterations = 500;
% Rfixed = imref2d(size(img_A));
% Index = zeros(512,1);
[sel, ok]=listdlg('ListString',{'整体相关系数','MPR','加权MPR'},...
    'Name','请选择匹配度评价类型','OKString','确定','CancelString','取消','SelectionMode','single','ListSize',[180 80]);
corr_value = zeros(512,1);
for i = 1:512
    %此处的Image_file为匹配的辅影像
    if i<10
        Image_file = pathname(1:end-2);
    else
        if i<100
            Image_file = pathname(1:end-3);
        else
            Image_file = pathname(1:end-4);
        end
    end
    Image_file1 = [Image_file,num2str(i),'\',filename];
    if exist(Image_file1,'file')
        [~,img_B_Skeleton] = Mean_curvature(Image_file1,parameters);
        if ok == 1
            switch sel
                case 1
                    corr_value(i,1) = corr2(img_B_Skeleton,img_A_Skeletion);
                case 2
                    corr_value(i,1) = Match_index(img_B_Skeleton,img_A_Skeletion);
                case 3
                    corr_value(i,1) = Match_index_weight(img_B_Skeleton,img_A_Skeletion);
            end
        else
            exit(0);
        end
    end
%     tformSimilarity = imregtform(img_B,img_A,'similarity',optimizer,metric);
%     moving = imwarp(img_B_Skeleton,tformSimilarity,'OutputView',Rfixed);
%     corr_value(i,1) = corr2(img_A_Skeletion,moving);
%     Index(i,1) = Match_index(img_A_Skeletion,moving);
end
end
        
