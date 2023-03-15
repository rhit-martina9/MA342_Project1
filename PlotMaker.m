function []=PlotMaker()
R=5;
x = -4.9:.1:4.9;
y = -.5:.05:.5;
[X,Y] = meshgrid(x,y);
Z = DoseCoefficient(X,Y,0,0,R);
contourf(X,Y,Z)
