function []=BeamGraph(R,n)
R=5;
n=8;
pencils=5;

step=R/1000;
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x,y] = meshgrid(X,Y);
Z=0;
for i=1:n
    for j=(1-pencils)/2:(pencils-1)/2
        Z = Z + DoseCoefficient(x,y,2*pi*(i-1)/n,j);
    end
end
contourf(x,y,real(Z),.01:n*.1:n*.6);
%[M,c]=contour(x,y,real(Z),20);
%c.LineWidth = 2;