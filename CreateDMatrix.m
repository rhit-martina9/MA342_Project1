function [D,x1,y1,Z]=CreateDMatrix(R,n,pencils,m,o)

step=R/(100*m);
X = step-R:step:R-step;
Y = step-R:step:R-step;
[x1,y1] = meshgrid(X,Y);
x = reshape(x1,[],1);
y = reshape(y1,[],1);

D=zeros(size(x,1),pencils,n);
Z=zeros(size(x,1),1);

M = readmatrix('OffAxisData.txt');

for alpha=1:n
    for pencil=(1-pencils)/2:(pencils-1)/2
        D(1:1:size(x,1),pencil+(pencils+1)/2,alpha) = DoseCoefficient(x,y,o+(2*pi*(alpha-1)/n),pencil,R,M);
    end
end


for a = 1:n
    Z = Z + sum(D(1:size(x,1),:,a),2);
end


distances = x1.^2+y1.^2;
circle = (distances <= R^2);


Z = real(reshape(Z,[],size(X,2)));

Z = Z.*circle;
Z(Z==0) = NaN;

