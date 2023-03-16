function [D]=Optimization(R,n)
R=5;
n=5;
pencils=1;

step=R/10;
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x,y] = meshgrid(X,Y);
x = reshape(x,[],1);
y = reshape(y,[],1);

D=zeros(2*R/step-1,n,pencils-1);
for alpha=1:n
    for pencil=(1-pencils)/2:(pencils-1)/2
        D([],alpha,pencil+(pencils+1)/2) = DoseCoefficient(x,y,2*pi*(alpha-1)/n,pencil,R);
    end
end

