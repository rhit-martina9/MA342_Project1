function [] = DVH(Ti,Ci,Ni,LT,beam)

L = LT(1);
%Normalize dose matrix on PT (lower bound for tumors).
beam = beam./L;

T = length(Ti);
DT = beam(Ti);

C = length(Ci);
DC = beam(Ci);

N = length(Ni);
DN = beam(Ni);

PTD = 0:.05:1.4;
n = length(PTD);

TPV = zeros(n,1);
CPV = zeros(n,1);
NPV = zeros(n,1);

for i = 1:n
    dP = PTD(i);
    
    TPV(i) = length(find(DT>dP))/T;
    CPV(i) = length(find(DC>dP))/C;
    NPV(i) = length(find(DN>dP))/N;
end


figure;
plot(PTD,TPV,'r');

hold on
plot(PTD,CPV,'g');
plot(PTD,NPV,'b');
plot([1,1],[0,1],'--');
hold off

title("Dose-volume Histogram");
legend('Target', 'OAR', 'Normal','Location','Southwest');
xlabel("Percent Target Dose");
ylabel("Percent Volume");

end