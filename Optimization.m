function [D,x1,y1,Z]=Optimization(R,n)
pencils=21;

step=R/100;
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x1,y1] = meshgrid(X,Y);
x = reshape(x1,[],1);
y = reshape(y1,[],1);

D=zeros(size(x,1),n,pencils);
Z=zeros(size(x,1),1);

for alpha=1:n
    for pencil=(1-pencils)/2:(pencils-1)/2
        D(1:1:size(x,1),alpha,pencil+(pencils+1)/2) = DoseCoefficient(x,y,2*pi*(alpha-1)/n,pencil,R);
    end
end

for pencil = 1:pencils
    Z = Z + sum(D(1:size(x,1),:,pencil),2);
end

Z = real(reshape(Z,[],size(X,2)));

