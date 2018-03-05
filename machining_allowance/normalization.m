function OUTPUT = normalization(INPUT)
    %input is a three units vector
    %output is a three units vector, whose norm is 1
    NORM = norm(INPUT);
    OUTPUT = INPUT./NORM;
end