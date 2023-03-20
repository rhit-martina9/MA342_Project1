function [Dt,x,y] = PatientMatrix1(R,m)

step=R/(100*m);
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x,y] = meshgrid(X,Y);
distances = x.^2+y.^2;
circle = (distances <= R^2);

D = zeros(length(X),length(Y));
Dt = D + circle.*3;

Dt(100*m:120*m,120*m:130*m) = 1;
Dt(110*m:120*m,80*m:90*m) = 2;

end

