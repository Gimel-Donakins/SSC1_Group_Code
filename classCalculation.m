% % L = 80; % m
% % B = 12; % m
% % T = 3; % m
% % mass = 800*1005; % kg
% % densitySaltwater = 1020; % kg/m^3
% % densityTankOil = 800; % kg/m^3
% % l = 40; % m
% % iT = (l*B^3)/12;
% % specificVolume = mass/densitySaltwater;
% % GGprime = (iT/specificVolume)*(densityTankOil/densitySaltwater)

% L = 120; % m
% B = 15; % m
% T = 8; % m
% mass = 10000*1000; % kg
% densitySaltwater = 1020; % kg/m^3
% l = 80; % m
% d = 4; % m
% densityTank = 800; % kg/m^3

% iT = (l*B^3)/12;
% specificVolume = mass/densitySaltwater;
% GGprime = (iT/specificVolume)*(densityTank/densitySaltwater)


% KG = 5; % m
% KB = T/2;
% BM = iT/Volume;

f = round(365*1.5*4, 0);
i = 81*1.5/4;
total_caffeine = 0;  % Initialize the cumulative caffeine in the body
for a = 1:f
    dose = i;  % The new caffeine dose
    % Add current dose and decay all previous doses
    total_caffeine = total_caffeine + dose / (2^((a-1)/2));
end
disp(total_caffeine)

