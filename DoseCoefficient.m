function [dose] = DoseCoefficient(x,y,a,i)

%Given values for 6MV machine, 3mm square pencil
P0 = 0.873;
u = 0.0469;
r = .16830; %Pencil radius
gam = 5.2586;

%Adjusted values
Rc = 5; %Circle radius.
lgc = 100; %Length of gantry to center

%Calculated values
gx = lgc*cos(a); %X-coord of gantry
gy = lgc*sin(a);%Y-coord of gantry

lgp = sqrt((x-gx).^2 + (y-gy).^2);

f = atan(r/lgc); %Angle of center pencil line to pencil edge
theta = 2*i*f; %Angle from center pencile line to center line

ISF = (lgc./lgp).^2;

fs = @(s) lgc^2 + s^2 -2*lgc*s*cos(theta) - Rc^2;
s = fsolve(fs,0);

a2 = a + theta; %Angle between pencil center line and horizontal line
o = abs(-(x-gx)*sin(a2) + (y-gy)*cos(a2));

d = -s + sqrt(lgp.^2.-o.^2);
ad = (0.1299 - 0.0306*log(d));

psi = (o.*lgc)./(s+d);
O = OffAxisFactor(psi);

%Calculate dosage when d >= 1.5
dose1 = (P0*exp(-u*(d-1.5)).*(1 - exp(-gam*r)) + ((r*d.*ad)./(r+1.5))).*O.*ISF;
dose1 = dose1.*(d >= 1.5);

%Calculate dosage when d < 1.5.
dose2 = (0.4.*(d./1.5) + 0.6).*(P0*(1-exp(-gam*r)) + ((1.5*r.*ad)./(r+1.5))).*O.*ISF;
dose2 = dose2.*(d < 1.5);

%Combine to get full dosage matrix
dose = dose1 + dose2;

%Put 0's in for values that are outside of circle anatomy.
distances = sqrt(x.^2+y.^2);
circle = (distances < Rc);
dose = dose.*circle;

end

