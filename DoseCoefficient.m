function [dose] = DoseCoefficient(p,a,i)

p_angle = 5;

%Given values for 6MV machine, 3mm square pencil
P0 = 0.873;
u = 0.0469;
r = .0016830;
gam = 5.2586;

%Adjusted values
cr = .05; %Circle radius.
lgc = 1;

%Calculated values
s = lgc - cr;
gx = cos(a);
gy = sin(a);

lgp = sqrt((x-gx)^2 + (y-gy)^2);

d = lgp*cos(p_angle) - s;
o = lgp*sin(p_angle);

ad = 0.1299 - 0.0306*ln(d);
ISF = (lgc/lgp)^2;

psi = (o*lgc)/(s+d);

if(d > .015)
    dose = P0*exp(-u*(d-.015))*(1 - exp(-gam*r)) + ((r*d*ad)/(r+1.5));
else
    dose = (0.4*(d/1.5) + 0.6)*(P0*(1-exp(-gam*r))) + ((1.5*r*ad)/(r+1.5));
end

end

