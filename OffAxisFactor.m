function [O] = OffAxisFactor(psi)

M = readmatrix('OffAxisData.txt');

num_cols = length(psi);

psi = reshape(psi,[],1); %Reshape with 1 column to act as array

%Interpolate with sample x being first column of data, sample y is second 
%column, and the points we want to interpolate are in the psi array. This
%uses MATLABS linear spline interpolation. Values outside of min and max
%are extrapolated.
O = interp1(M(:,1),M(:,2),psi,'linear','extrap'); 

%Reshape back into original matrix shape.
O = reshape(O,[],num_cols);

end

