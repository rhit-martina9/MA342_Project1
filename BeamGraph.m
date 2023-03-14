function []=BeamGraph(R,n)
R=2;
n=8;

step=R/1000;
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x,y] = meshgrid(X,Y);
Z=0;
for i=1:n
    Z = Z + DoseCoefficient(x,y,2*pi*(i-1)/n,0);
end
for i=1:2*(R-step)/step+1
    for j=1:2*(R-step)/step+1
        if x(i,j)^2+y(i,j)^2 > R
            Z(i,j)=sqrt(-100);
        end
    end
end
[M,c]=contour(x,y,real(Z),20);
c.LineWidth = 2;