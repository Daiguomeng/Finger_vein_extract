function corr_value = Same_match_patterns(file_path,parameters)
Image = uint8(zeros(parameters.Window_size(1,2)-parameters.Window_size(1,1)+1,parameters.Window_size(1,4)-parameters.Window_size(1,3)+1,9));
Image_Skeleton = zeros(parameters.Window_size(1,2)-parameters.Window_size(1,1)+1,parameters.Window_size(1,4)-parameters.Window_size(1,3)+1,9);
for i = 1:9
    Image_file = [file_path,'\',num2str(i),'.bmp'];
    [Image(:,:,i),Image_Skeleton(:,:,i)] = Mean_curvature(Image_file,parameters);
end
corr_value = zeros(9,9);
[sel, ok]=listdlg('ListString',{'整体相关系数','MPR','加权MPR'},...
    'Name','请选择匹配度评价类型','OKString','确定','CancelString','取消','SelectionMode','single','ListSize',[180 80]);
if ok == 1
    switch sel
        case 1
            for i = 1:9
                for j = 1:9
                    corr_value(i,j) = corr2(Image_Skeleton(:,:,i),Image_Skeleton(:,:,j));
                end
            end
        case 2
            for i = 1:9
                for j = 1:9
                    corr_value(i,j) = Match_index(Image_Skeleton(:,:,i),Image_Skeleton(:,:,j));
                end
            end
        case 3
            for i = 1:9
                for j = 1:9
                    corr_value(i,j) = Match_index_weight(Image_Skeleton(:,:,i),Image_Skeleton(:,:,j));
                end
            end
    end
else
    exit(0);
end
%配准
% [optimizer, metric] = imregconfig('multimodal');
% optimizer.GrowthFactor = 1.01;
% optimizer.Epsilon = 1.5e-6;
% optimizer.InitialRadius = 0.001;
% optimizer.MaximumIterations = 500;
% if ok == 1
%     for i = 1:9
%         for j = 1:9
%             %corr_value(i,j)=corr2(Image_Skeleton(:,:,i),Image_Skeleton(:,:,j));
%             img_A = Image(:,:,i);
%             img_B = Image(:,:,j);
%             %[moving,info] = imregister(img_B, img_A, 'affine', optimizer, metric);
%             tformSimilarity = imregtform(img_B,img_A,'similarity',optimizer,metric);
%             Rfixed = imref2d(size(img_A));
%             %依据tformSimilarity变换
%             moving = imwarp(Image_Skeleton(:,:,j),tformSimilarity,'OutputView',Rfixed);
%             for s = 1:9
%                 for t = 1:9
%                     switch sel
%                         case 1
%                             corr_value(i,j) = corr2(Image_Skeleton(:,:,i),moving);
%                         case 2
%                             corr_value(i,j) = Match_index(Image_Skeleton(:,:,i),moving);
%                         case 3
%                             corr_value(i,j) = Match_index_weight(Image_Skeleton(:,:,i),moving);
%                     end
%                 end
%             end
%         end
%     end
% else
%     exit(0);
% end
end
