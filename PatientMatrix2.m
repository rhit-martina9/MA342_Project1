function [Dt,x,y] = PatientMatrix2(R,m)

step=R/(100*m);
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x,y] = meshgrid(X,Y);

distances = x.^2+y.^2;
circle = (distances <= R^2);

D = zeros(length(X),length(Y));
Dt = D + circle.*3;

Dt(70*m:140*m,70*m:130*m) = 1;
Dt(90*m:120*m,90*m:110*m) = 2;

end

