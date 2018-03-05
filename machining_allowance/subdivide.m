function OUTPUT = subdivide(INPUT)
    %input is a nine units vector, contains indices of three vertexs
    %output is a four by nine matrix
    OUTPUT = zeros(4, 9);
    point = zeros(3, 3);
    point(1,:) = sum([INPUT(1:3);INPUT(4:6)])./2;
    point(2,:) = sum([INPUT(4:6);INPUT(7:9)])./2;
    point(3,:) = sum([INPUT(1:3);INPUT(7:9)])./2;
    for i = 1:3
        INPUT(((i-1)*3+1):i*3) = normalization(((i-1)*3+1):i*3);
    end
    for i = 1:3
        point(i,:) = normalization(point(i,:));
    end
    OUTPUT(1,:) = reshape([INPUT(1:3);point(1,:);point(3,:)]',[1,9]);
    OUTPUT(2,:) = reshape([point(1,:);point(2,:);point(3,:)]',[1,9]);
    OUTPUT(3,:) = reshape([point(1,:);INPUT(4:6);point(2,:)]',[1,9]);
    OUTPUT(4,:) = reshape([point(3,:);point(2,:);INPUT(7:9)]',[1,9]);
    
end