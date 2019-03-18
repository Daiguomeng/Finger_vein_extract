function index = Match_index(master,slave)
    [m,n] = size(master);
    ssum = 0;
    tsum = 0;
    for i = 1:m
        for j =1:n
            if master(i,j)>0
                s = 1;
            else
                s=0;
            end
            if slave(i,j)>0
                t = 1;
            else
                t = 0;
            end
            ssum = ssum+s*t;
            tsum = tsum+(s+t);
        end
    end
    index = 2*ssum/tsum;
end