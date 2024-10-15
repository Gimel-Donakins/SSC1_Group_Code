format compact
format shortG

height = 0.22; % meters
width = (1.2 - height)/2; % meters
length = (1.2 - height)/2; % meters
thicc = 0.00635; % meters (1/4 inch)
[GM, percentSubmerged, Awet, HeelAngle, C, GradedValue] = metacentricHeight(width, height, length, thicc, 900);

function [GM, percentSubmerged, Awet, HeelAngle, C, GradedValue] = metacentricHeight(width, height, length, thicc, materialDensity)
    airDensity = 1.293; % kg/m^3
    freshWaterDensity = 1000; % kg/m^3 
    saltWaterDensity = 1024; % kg/m^3
    EVAFoamDensity = 35; % kg/m^3
    PVCMaterialDensity = 1350; % kg/m^3
    PLAMaterialDensity = 1240; % kg/m^3
    gravelDensity = 1680; % kg/m^3
    gravity = 9.81; % m*s^-2

    GM = [];
    Awet = [];
    HeelAngle = [];
    GradedValue = [];

    oneBagVolume = 0.000946353; % m^3
    oneBagMass = gravelDensity * oneBagVolume;

    Volume = width * height * length; % whole enclosure m^3
    VolumeHull = width * height * length - ((width - thicc) * (height - thicc) * (length - thicc)); % m^3
    massHull = VolumeHull * materialDensity + (Volume - VolumeHull)*airDensity;

    disp(VolumeHull*900)

    CG = [0, 0, 0];
    G = CG + [width/2, length/2, height/2];

    for numberOfBags = 0:1:100
        C = numberOfBags*oneBagMass;
        weightedMass = massHull + C;
        percentSubmerged = (weightedMass/Volume)/freshWaterDensity;
        submergedVolume = percentSubmerged*VolumeHull;

        if percentSubmerged < 1
            T = percentSubmerged*height;
            KB = T/2;
            KG = G(3);
            IT = (2/3) * integral(@(x) (width/2).^3, -length/2, length/2, 'ArrayValued', true); % tranverse second moment of area
            BM = IT/submergedVolume; % metacentric radius
            GM = [GM, KB + BM - KG];
            GM0 = GM(1);
            Awet = [Awet, length*width + percentSubmerged*(2*height*width + 2*height*length)];
            HeelAngle = [HeelAngle, atan((height - T)/(width/2))];
            GradedValue = [GradedValue, (C*HeelAngle(numberOfBags+1)*GM(numberOfBags+1)*GM0)/Awet(numberOfBags+1)];
        else
            return;
        end
    end
end

maxGradedValue = max(GradedValue)