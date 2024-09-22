format compact
format shortG
airDensity = 1.293; % kg/m^3
freshWaterDensity = 1000; % kg/m^3 
saltWaterDensity = 1024; % kg/m^3
EVAFoamDensity = 35; % kg/m^3
PVCMaterialDensity = 1350; % kg/m^3
PLAMaterialDensity = 1240; % kg/m^3
gravelDensity = 1680; % kg/m^3
gravity = 9.81; % m*s^-2

CG = [0; 0; 0];

function BuoyantForce = BuoyantForce(density, gravity, volume)
    BuoyantForce =  density * gravity * volume;
end

% avgMaterialDensity = (PVCMaterialDensity * 0.7) + (EVAFoamDensity * 0.3);
% percentSubmerged = (avgMaterialDensity/freshWaterDensity);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Buoyancy Calculations for 32 oz. Quart size bag

oneBagVolume = 0.000946353; % m^3
oneBagMass = gravelDensity * oneBagVolume;
disp("One bag weighs " + oneBagMass + "kg")

width = 0.165; % meters
height = 0.178; % meters
% length = 0.6*(1.2 - (width + height));
length = 0.5; % meters
thicc = 0.01; % meters
Volume = width * height * length % whole enclosure m^3
VolumeHull = width * height * length - ((width - thicc) * (height - thicc) * (length - thicc)) % m^3
massHull = VolumeHull * 2300 + (Volume - VolumeHull)*airDensity

% VolumeHull = 3276.746*(1/100)^3; % m^3
% massHull = 3.473351; % kg

numberOfBags = 7
weightedMass = massHull + numberOfBags*oneBagMass

percentSubmerged = (weightedMass/Volume)/freshWaterDensity

% FB = BuoyantForce(freshWaterDensity, gravity, volume);

% heelAngle = (10*2*pi)/180; % degrees, then B' and B'' make a circle with M as the metacenter

% syms B BM Bprime specificVolume

% BM == (B*Bprime)/tan(heelAngle)

% deltaMoment = specificVolume * B*Bprime