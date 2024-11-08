format compact
format longG

height = 0.08; % meters
width = (1.2 - height)/2; % meters
length = (1.2 - height)/2; % meters
thicc = 0.00635*2; % meters (1/4 inch)

function [GM, Awet, HeelAngle, C, GradedValue, Tfinal, flipAngle] = metacentricHeight(width, height, length, thicc, materialDensity)
    airDensity = 1.293; % kg/m^3
    freshWaterDensity = 1000; % kg/m^3 
    saltWaterDensity = 1024; % kg/m^3
    EVAFoamDensity = 35; % kg/m^3
    PVCMaterialDensity = 1350; % kg/m^3
    PLAMaterialDensity = 1240; % kg/m^3
    gravelDensity = 1680; % kg/m^3
    gravity = 9.81; % m/s^2

    GM = [];
    Awet = [];
    HeelAngle = [];
    GradedValue = [];
    flipAngle = NaN; % Track angle where boat flips over
    
    oneBagVolume = 0.000946353; % m^3
    oneBagMass = gravelDensity * oneBagVolume;
    oneBagHeight = oneBagVolume / (0.177 * 0.188);

    Volume = width * height * length; % Whole enclosure m^3
    VolumeHull = width * height * length - ((width - thicc) * (height - thicc) * (length - thicc)); % m^3
    massHull = VolumeHull * materialDensity + (Volume - VolumeHull) * airDensity;

    CG = [0, 0, 0];
    persistent G;
    G = CG + [width/2, length/2, (VolumeHull * (4*(height + thicc)/2 + thicc/2) / 5)];

    for numberOfBags = 0:1:100
        C = numberOfBags * oneBagMass;
        weightedMass = massHull + C;
        areaBase = length * width;
        SG_water = 1.000;
        T = (weightedMass / freshWaterDensity) / (areaBase * SG_water);
        submergedVolume = submergedVolumeFunction(T, thicc, height, width, length);
        
        % Center of gravity (G) calculation
        G(3) = ((massHull * 4 * (height + thicc) / 2 + thicc / 2) / 5 + (C * (thicc + oneBagHeight / 2))) / weightedMass;

        if T < height
            KB = T / 2;
            KG = G(3);
            IT = (2/3) * integral(@(x) (width/2).^3, -length/2, length/2, 'ArrayValued', true); % transverse moment of area
            BM = IT / submergedVolume; % metacentric radius
            GM_current = KB + BM - KG;
            GM = [GM, GM_current];
            
            Awet = [Awet, areaBase + T * (2 * width + 2 * length)];
            HeelAngle_current = atan((height - T) / (width / 2));
            HeelAngle = [HeelAngle, HeelAngle_current];

            GradedValue = [GradedValue, (C * HeelAngle_current * GM_current) / Awet(end)];
            Tfinal = T;

            if GM_current < 0 && isnan(flipAngle)
                flipAngle = rad2deg(HeelAngle_current); % Record flip angle in degrees
            end

            % Exit condition if flipped
            if GM_current < 0
                break;
            end
        else
            return;
        end
    end
end

function submergedVolume = submergedVolumeFunction(T, thickness, height, width, length)
    submergedVolume = T * length * width;
end

[GM, Awet, HeelAngle, C, GradedValue, Tfinal, flipAngle] = metacentricHeight(width, height, length, thicc, 560);
maxGradedValue = max(GradedValue);
disp(['Maximum Graded Value: ', num2str(maxGradedValue)]);
disp(['Flip Angle (degrees): ', num2str(flipAngle)]);
