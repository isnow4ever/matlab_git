function fitness = corr(x)
    global data
    scan_data = data.normals_data;
    %rotate scan_data
    R = angle2dcm(x(1),x(2),x(3));
    rot_data = R * scan_data;
%     rot_data = rotation(scan_data,angle);
    %map to ico
    EGI_model = data.EGI_intensity2_model;
    EGI_scan = map_to_ico(rot_data',2);
%     EGI_scan = gpuArray(EGI_scan);
    fitness = 1-dot(EGI_model,EGI_scan)/(norm(EGI_model)*norm(EGI_scan));
%     fitness = gather(fitness);
end