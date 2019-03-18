function shuchu= Valley_Search_Gradient(tuxiang)
    [m,n]=size(tuxiang);
    H = zeros(m,n);
    for i = 2:m-1
        for j = 2:n-1
            fx = tuxiang(i+1,j)-tuxiang(i,j);
            fy = tuxiang(i,j+1)-tuxiang(i,j);
            fxx = tuxiang(i+1,j)+tuxiang(i-1,j)-2*tuxiang(i,j);
            fyy = tuxiang(i,j+1)+tuxiang(i,j-1)-2*tuxiang(i,j);
            fxy = tuxiang(i+1,j+1)+tuxiang(i,j)-tuxiang(i,j+1)-tuxiang(i+1,j);
            if fx==0&&fy==0
                H(i,j) = 0;
            else
                H(i,j) = 0.5*(fxx*fy^2-2*fxy*fx*fy+fyy*fx^2)/(fx^2+fy^2)^1.5;
            end
            if abs(H(i,j))>=1
                H(i,j) = 0;
            end
            if H(i,j)<0
                H(i,j)=0;
            end
        end
    end
    shuchu = H;
end