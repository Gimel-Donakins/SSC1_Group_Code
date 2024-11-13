format compact
format longG

height = 0.08; % meters
width = (1.2 - height - 0.0635)/2; % meters
length = (1.2 - height - 0.0635)/2; % meters
thicc = 0.00635; % meters (1/4 inch)
% thicc = 0.005;

function [GM, Awet, HeelAngle, C, GradedValue, Tfinal] = metacentricHeight(width, height, length, thicc, materialDensity)
    airDensity = 1.293; % kg/m^3
    freshWaterDensity = 1000; % kg/m^3 
    saltWaterDensity = 1024; % kg/m^3
    EVAFoamDensity = 64; % kg/m^3
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
    oneBagHeight = oneBagVolume/(0.177*0.188);

    Volume = width * height * length; % whole enclosure m^3
    VolumeHull = width * height * length - ((width - 2*thicc) * (height - 2*thicc) * (length - 2*thicc)); % m^3
    massHull = VolumeHull * materialDensity + (Volume - VolumeHull)*airDensity;

    VolumeBoard = (18.5/39.37 * 11.4/39.37 * 0.04/39.37);
    kgMassForce = -freshWaterDensity*VolumeBoard;

    CG = [0, 0, 0];
    persistent G;
    G = CG + [width/2, length/2, (VolumeHull*(4*(height+thicc)/2 + thicc/2)/5)];
    for numberOfBags = 0:1:100
        C = numberOfBags*oneBagMass;
        weightedMass = massHull + C + 0.8119303 + 2*kgMassForce;
        areaBase = length*width;
        SG_water = 1.000;
        % SG_boat = (weightedMass/Volume)/freshWaterDensity;
        T = (weightedMass/freshWaterDensity)/(areaBase * SG_water);
         submergedVolume = T*length*width;
        G(3) = ((massHull *(4*(height+thicc)/2 + thicc/2 + (height+thicc/2)))/6 + 0.8119303*(height + 0.0635) + (C*(thicc + oneBagHeight/2)))/weightedMass;

        % if numberOfBags == 10
        % disp(C)
        % end
        if T < height
            KB = T/2;
            KG = G(3);
            IT = (2/3) * integral(@(x) (width/2).^3, -length/2, length/2, 'ArrayValued', true); % tranverse second moment of area
            BM = IT/submergedVolume; % metacentric radius
            GM = [GM, KB + BM - KG];
            GM0 = GM(1);
            Awet = [Awet, areaBase + T*(2*width + 2*length)];
            % HeelAngle = [HeelAngle, atan((height - T)/(width/2))];

            maxGZ = -inf;
            maxHeelAngle_temp = 0;
            for angle = -pi/2:0.05:3*pi/2
                GZ = GM(numberOfBags + 1) * sin(angle); % Righting arm based on heel angle
                if GZ > 0 && angle < pi/2
                    % GZ is positive and within stable range (-pi/2 to pi/2)
                    if GZ > maxGZ
                        maxGZ = GZ;
                        maxHeelAngle_temp = angle;
                    end
                elseif GZ <= 0 && (angle >= pi/2 && angle < 3*pi/2)
                    % GZ is negative and within unstable range (pi/2 to 3pi/2)
                    maxHeelAngle = angle;
                    HeelAngle = [HeelAngle, maxHeelAngle];
                    GradedValue = [GradedValue, (C*HeelAngle(numberOfBags+1)*GM(numberOfBags+1)*GM0)/Awet(numberOfBags+1)];
                    break;
                end
            end
            if maxHeelAngle_temp > maxHeelAngle
                maxHeelAngle = maxHeelAngle_temp;
            end
        else
            Tfinal = T;
            return;
        end
    end
end

    % [GM, Awet, HeelAngle, C, GradedValue, Tfinal] = metacentricHeight(width, height, length, thicc, 560);
    % maxGradedValue = max(GradedValue)

maxGradedValue = [];
for height = 0:0.001:0.8

width = (1.2 - height - 0.0635)/2; % meters
length = (1.2 - height - 0.0635)/2; % meters
thicc = 0.00635*2; % meters (1/4 inch)
    densityOfBuildingMaterial = 560; % kg/m^3

    [GM, Awet, HeelAngle, C, GradedValue, Tfinal] = metacentricHeight(width, height, length, thicc, densityOfBuildingMaterial);

    maxGradedValue = [maxGradedValue, max(GradedValue)];
end
max(maxGradedValue)