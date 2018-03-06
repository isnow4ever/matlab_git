function data = init
% global Triangles Triangles_L1 Triangles_L2 Triangles_L3 Triangles_L4 Triangles_L5;
% Triangles = ones(1, 9);
%二十面体12个顶点坐标
ICO_X=0.525731112119133606;
ICO_Z=0.850650808352039932;
vertex_indices = [ 
    -ICO_X,  0.0,  ICO_Z ;
     ICO_X,  0.0 , ICO_Z ;
    -ICO_X,  0.0 ,-ICO_Z ;
     ICO_X,  0.0 ,-ICO_Z ;
      0.0 , ICO_Z, ICO_X ;
      0.0 , ICO_Z,-ICO_X ;
      0.0 ,-ICO_Z, ICO_X ;
      0.0 ,-ICO_Z,-ICO_X ;
     ICO_Z, ICO_X,  0.0  ;
    -ICO_Z, ICO_X,  0.0  ;
     ICO_Z,-ICO_X,  0.0  ;
    -ICO_Z,-ICO_X,  0.0  
    ];
%二十面体20个面的顶点序号
face_indices = [
		 2,5,1 ; 5,10,1 ; 5,6,10 ; 9,6,5 ; 2,9,5 ;
         2,11,9 ; 11,4,9 ; 9,4,6 ; 4,3,6 ; 4,8,3 ;
         9,11,8 ; 11,7,8 ; 7,12,8 ; 7,1,12 ; 7,2,1 ;
         11,2,7 ; 12,1,10 ; 3,12,10 ; 6,3,10 ; 12,3,8];
%二十面体三角形矩阵：1~3列每个三角形第一个顶点坐标，4~6列第二个顶点，7~9列第三个顶点
Triangles_L1 = zeros(20, 9);
for i = 1:20
    for j = 1:3
    Triangles_L1(i,j) = vertex_indices(face_indices(i,1),j);
    Triangles_L1(i,j+3) = vertex_indices(face_indices(i,2),j);
    Triangles_L1(i,j+6) = vertex_indices(face_indices(i,3),j);
    end
end

Triangles_L2 = zeros(80, 9);
for i = 1:20
    Triangles_L2(((i-1)*4+1):i*4,:) = subdivide(Triangles_L1(i,:));
end
Triangles_L3 = zeros(320, 9);

for i = 1:80
    Triangles_L3(((i-1)*4+1):i*4,:) = subdivide(Triangles_L2(i,:));
end
Triangles_L4 = zeros(1280, 9);
for i = 1:320
    Triangles_L4(((i-1)*4+1):i*4,:) = subdivide(Triangles_L3(i,:));
end
Triangles_L5 = zeros(5120, 9);
for i = 1:1280
    Triangles_L5(((i-1)*4+1):i*4,:) = subdivide(Triangles_L4(i,:));
end

normals_data = importdata('normals_data.txt');
normals_model = importdata('normals_model.txt');
%normals_data = gpuArray(normals_data);
%normals_model = gpuArray(normals_model);

% EGI_intensity1_model = zeros(20,1);
% parfor i = 1:20
%     indice_matrix = reshape(Triangles_L1(i,:), 3, 3);
%     for j = 1:size(normals_model,1)
%         normal_vector = normals_model(j,[1 2 3]);
%         lamda = indice_matrix \ normal_vector';
%         if lamda(:)>0
%             EGI_intensity1_model(i) = EGI_intensity1_model(i) + 1;
%         end
%     end
% end

% EGI_intensity2_model = zeros(80,1);
% parfor i = 1:80
%     indice_matrix =  reshape(Triangles_L2(i,:), 3, 3);
%     for j = 1:size(normals_model,1)
%         normal_vector = normals_model(j,[1 2 3]);
%         lamda = indice_matrix \ normal_vector';
%         %lamda = gather(lamda);
%         if lamda(:)>0
%             EGI_intensity2_model(i) = EGI_intensity2_model(i) + 1;
%         end
%     end
% end

EGI_intensity2_model = zeros(80,1);
% for i = 1:320
%     indice_matrix =  reshape(Triangles_L3(i,:), 3, 3);
%     for j = 1:size(normals_model,1)
%         normal_vector = normals_model(j,[1 2 3]);
%         lamda = indice_matrix \ normal_vector';
%         if lamda(:)>0
%             EGI_intensity3_model(i) = EGI_intensity3_model(i) + 1;
%         end
%     end
% end

        s = size(normals_model,1);
        normal_flags = zeros(s,1);
        T = Triangles_L2;
        parfor i = 1:s
            normal_vector = normals_model(i,:);
            for j = 1:80
                indice_matrix = reshape(T(j,:),3,3);
                lamda = indice_matrix \ normal_vector';
                if lamda(:) > 0
                    normal_flags(i) = j;
                    break;
                end                
            end
        end
        parfor m = 1:80
            EGI_intensity2_model(m) = numel(find(normal_flags(:)==m));
        end

% EGI_intensity4_model = zeros(1280,1);
% parfor i = 1:1280
%     indice_matrix =  reshape(Triangles_L4(i,:), 3, 3);
%     for j = 1:size(normals_model,1)
%         normal_vector = normals_model(j,[1 2 3]);
%         lamda = indice_matrix \ normal_vector';
%         %lamda = gather(lamda);
%         if lamda(:)>0
%             EGI_intensity4_model(i) = EGI_intensity4_model(i) + 1;
%         end
%     end
% end

% EGI_intensity5_model = zeros(5120,1);
% parfor i = 1:5120
%     indice_matrix =  reshape(Triangles_L5(i,:), 3, 3);
%     for j = 1:size(normals_model,1)
%         normal_vector = normals_model(j,[1 2 3]);
%         lamda = indice_matrix \ normal_vector';
%         %lamda = gather(lamda);
%         if lamda(:)>0
%             EGI_intensity5_model(i) = EGI_intensity5_model(i) + 1;
%         end
%     end
% end
data = struct('normals_data',normals_data',...
    'normals_model',normals_model',...
    'Triangles_L1',Triangles_L1,...
    'Triangles_L2',Triangles_L2,...
    'Triangles_L3',Triangles_L3,...
    'EGI_intensity2_model',EGI_intensity2_model);
end