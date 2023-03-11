function [dose] = DoseCoefficient(p,a,i)

%Given values for 6MV machine, 3mm square pencil
P0 = 0.873;
u = 0.0469;
r = .0016830; %Pencil radius
gam = 5.2586;

%Adjusted values
Rc = .05; %Circle radius.
lgc = 1; %Length of gantry to center

%Calculated values
gx = cos(a); %X-coord of gantry
gy = sin(a);%Y-coord of gantry

lgp = sqrt((p(1)-gx)^2 + (p(2)-gy)^2);

f = atan(r/lgc); %Angle of center pencil line to pencil edge
theta = 2*i*f; %Angle from center pencile line to center line

ISF = (lgc/lgp)^2;

fs = @(s) lgc^2 + s^2 -2*lgc*s*cos(theta) - Rc^2;
s = fsolve(fs,0);

a2 = a + theta; %Angle between pencil center line and horizontal line
o = abs(-(p(1)-gx)*sin(a2) + (p(2)-gy)*cos(a2));

d = -s + sqrt(lgp^2-o^2);
ad = (0.1299 - 0.0306*log(d));

psi = (o*lgc)/(s+d);
O = OffAxisFactor(psi);

if(d >= .015)
    dose = P0*exp(-u*(d-.015))*(1 - exp(-gam*r)) + ((r*d*ad)/(r+1.5))*O*ISF;
else
    dose = (0.4*(d/1.5) + 0.6)*(P0*(1-exp(-gam*r))) + ((1.5*r*ad)/(r+1.5))*O*ISF;
end

end

