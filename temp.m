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

% function BuoyantForce = BuoyantForce(density, gravity, volume)
%     BuoyantForce =  density * gravity * volume;
% end

% avgMaterialDensity = (PVCMaterialDensity * 0.7) + (EVAFoamDensity * 0.3);
% percentSubmerged = (avgMaterialDensity/freshWaterDensity);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Buoyancy Calculations for 32 oz. Quart size bag

oneBagVolume = 0.000946353; % m^3
oneBagMass = gravelDensity * oneBagVolume;
disp("One bag weighs " + oneBagMass + "kg")

width = 0.221; % meters
height = 0.209; % meters
% length = 0.6*(1.2 - (width + height));
length = 0.5; % meters
thicc = 0.01; % meters
Volume = width * height * length % whole enclosure m^3
VolumeHull = width * height * length - ((width - thicc) * (height - thicc) * (length - thicc)) % m^3
massHull = VolumeHull * 2300 + (Volume - VolumeHull)*airDensity

CG = [0, 0, 0];
G = CG + [width/2, length/2, height/2];

numberOfBags = 0
weightedMass = massHull + numberOfBags*oneBagMass
artificialDensity = weightedMass/Volume;

percentSubmerged = (weightedMass/Volume)/freshWaterDensity
submergedVolume = percentSubmerged*VolumeHull;

T = percentSubmerged*height;
KB = T/2;
KG = G(3);
IT = (2/3) * integral(@(x) (width/2).^3, -length/2, length/2, 'ArrayValued', true); % tranverse second moment of area
BM = IT/submergedVolume; % metacentric radius
GM = KB + BM - KG;

disp("the value calculated for GM is " + GM + " meters")