    function EGI_intensity = map_to_ico(normal_sphere,level)
    %MAP_TO_ICO 此处显示有关此函数的摘要
    %   此处显示详细说明
    global data;
    
    EGI_intensity = zeros(20*4^(level-1),1);
    s = size(normal_sphere,1);
    normal_flags = zeros(s,1);
    if level == 1
        T = data.Triangles_L1;
    elseif level == 2
        T = data.Triangles_L2; 
    elseif level == 3
        T = data.Triangles_L3;
    end
    parfor i = 1:s
        normal_vector = normal_sphere(i,:);
        for j = 1:20*4^(level-1)
            indice_matrix = reshape(T(j,:),3,3);
            lamda = indice_matrix \ normal_vector';
            if lamda(:) > 0
                normal_flags(i) = j;
                break;
            end
        end
    end
    parfor m = 1:20*4^(level-1)
        EGI_intensity(m) = numel(find(normal_flags(:)==m));
    end
end
    

%     if level == 1
%         EGI_intensity = zeros(20,1);
%         normal_matrix = normal_sphere(:,[1 2 3]);
%         indice_matrix =  reshape(data.Triangles_L1',[3,3,20]);
%         parfor i = 1:20
%             lamda = indice_matrix(:,:,i) \ normal_matrix';
%             for j = 1:size(lamda,2)
%                 if lamda(:,j) > 0
%                 EGI_intensity(i) = EGI_intensity(i) + 1;
%                 end
%             end
%         end 
%     end
% 
%     if level == 2
%         EGI_intensity = zeros(80,1);
%         s = size(normal_sphere,1);
%         normal_flags = zeros(s,1);
%         T = data.Triangles_L2;
%         for i = 1:s
%             normal_vector = normal_sphere(i,:);
%             for j = 1:80
%                 indice_matrix = reshape(T(j,:),3,3);
%                 lamda = indice_matrix \ normal_vector';
%                 if lamda(:) > 0
%                     normal_flags(i) = j;
%                 break;
%                 end
%             end
%         end
%         for m = 1:80
%             EGI_intensity(m) = numel(find(normal_flags(:)==m));
%         end
%     end
% % 
% %     if level == 3
% %         EGI_intensity = zeros(320,1);
% %         normal_matrix = normal_sphere;
% %         for i = 1:320
% %             indice_matrix =  reshape(data.Triangles_L3(i,:),3,3);
% %             for j = 1:size(normal_matrix,1)
% %                 normal_vector = normal_matrix(j,[1 2 3]);
% %                 lamda = indice_matrix \ normal_vector';
% %                 if lamda(:) > 0
% %                     EGI_intensity(i) = EGI_intensity(i) + 1;
% %                 end
% %             end
% %         end 
% %     end
%     
%     if level == 3
%         EGI_intensity = zeros(320,1);
%         s = size(normal_sphere,1);
%         normal_flags = zeros(s,1);
%         T = data.Triangles_L3;
%         for i = 1:s
%             normal_vector = normal_sphere(i,:);
%             for j = 1:320
%                 indice_matrix = reshape(T(j,:),3,3);
%                 lamda = indice_matrix \ normal_vector';
%                 if lamda(:) > 0
%                     normal_flags(i) = j;
%                 break;
%                 end
%             end
%         end
%         for m = 1:320
%             EGI_intensity(m) = numel(find(normal_flags(:)==m));
%         end
%     end
% end

