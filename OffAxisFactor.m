function [mult] = OffAxisFactor(psi)

M = readmatrix('OffAxisData.txt');

len = length(M);
index = 2;

if(psi < .044270)
    mult = 1;
    return;
end

if(psi > M(340,1))
   mult = M(340,2);
   return;
end

%Find indexes psi lies between. Lower is index - 1, upper is index.
while(~(psi < M(index) && psi > M(index-1)) && index < len)
    index = index + 1;
end

%Linear interpolation
x1 = M(index-1,1);
x2 = M(index,1);
y1 = M(index-1,2);
y2 = M(index,2);

mult = ((y2-y1)/(x2-x1))*(psi-x1) + y1;

end

