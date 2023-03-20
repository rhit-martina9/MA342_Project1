function [x,beam,origbeam,x1,y1,p,optVal] = Optimizer(o,fig)

a = 8;
pencils = 15;
R = 5;
m=.5;

[D,x1,y1]=CreateDMatrix(R,a,pencils,m,o);
[Dt] = PatientMatrix1(R,m);

D = real(D);

D = reshape(D,length(D),[],1);

pencils = pencils*a;

Ti = find(Dt==1);
T = length(Ti);
Tnum = length(Ti);
DT = D(Ti,:);

Ci = find(Dt==2);
C = length(Ci);
Cnum = length(Ci);
DC = D(Ci,:);

Ni = find(Dt==3);
N = length(Ni);
Nnum = length(Ni);
DN = D(Ni,:);

rows = Tnum*2 + Cnum + Nnum;
cols = pencils + Tnum + Cnum + Nnum;

A = zeros(rows,cols);

A(Tnum+1:rows,pencils+1:cols) = -eye(cols-pencils);

A(1:Tnum,1:pencils) = -DT;
A(Tnum+1:Tnum*2,1:pencils) = DT;
A(Tnum*2+1:Tnum*2 + Cnum,1:pencils) = DC;
A(Tnum*2 + Cnum+1:rows,1:pencils) = DN;

%LT 70, UT 95, UC 45, UN 100

LT = ones(Tnum,1)*70;
PT = ones(Tnum,1)*95;
PC = ones(Cnum,1)*45;
PN = ones(Nnum,1)*100;

b = zeros(rows,1);
b(1:Tnum) = -LT;
b(Tnum+1:Tnum*2) = PT;
b(Tnum*2+1:Tnum*2+Cnum) = PC;
b(Tnum*2 + Cnum+1:rows) = PN;

yt = 2000/T;
yc = 1800/C;
yn = 200/N;

c = zeros(cols,1);
c(pencils+1:pencils+Tnum) = yt*ones(Tnum,1);
c(pencils+Tnum+1:pencils+Tnum+Cnum) = yc*ones(Cnum,1);
c(pencils+Tnum+Cnum+1:cols) = yc*ones(Nnum,1);

u = 25/45;
UC = -u.*PC;

lb = zeros(cols,1);
lb(pencils+Tnum+1:pencils+Tnum+Cnum) = UC;

[x,optVal] = linprog(c,A,b,[],[],lb,[]);

p = reshape(x(1:pencils),1,[]);

origbeam = D(:,:);
origbeam(origbeam == 0) = NaN;
beam = origbeam .* p;

origbeam = sum(origbeam,2);
origbeam = reshape(origbeam,[],length(x1));

beam = sum(beam,2);
beam = reshape(beam,[],length(x1));

DVH(Ti,Ci,Ni,LT,beam);

if(fig == 1)
    contourf(x1,y1,origbeam);
    colormap(hot);

    figure;

    [c,h] = contourf(x1,y1,beam);
    colormap(hot);

    figure;

    contourf(x1,y1,Dt);
    colormap(hot);
end

end

