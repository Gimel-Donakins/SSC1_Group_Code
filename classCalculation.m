% % % L = 80; % m
% % % B = 12; % m
% % % T = 3; % m
% % % mass = 800*1005; % kg
% % % densitySaltwater = 1020; % kg/m^3
% % % densityTankOil = 800; % kg/m^3
% % % l = 40; % m
% % % iT = (l*B^3)/12;
% % % specificVolume = mass/densitySaltwater;
% % % GGprime = (iT/specificVolume)*(densityTankOil/densitySaltwater)

% % L = 120; % m
% % B = 15; % m
% % T = 8; % m
% % mass = 10000*1000; % kg
% % densitySaltwater = 1020; % kg/m^3
% % l = 80; % m
% % d = 4; % m
% % densityTank = 800; % kg/m^3

% % iT = (l*B^3)/12;
% % specificVolume = mass/densitySaltwater;
% % GGprime = (iT/specificVolume)*(densityTank/densitySaltwater)


% % KG = 5; % m
% % KB = T/2;
% % BM = iT/Volume;

% f = round(365*1.5*4, 0);
% i = 81*1.5/4;
% total_caffeine = 0;  % Initialize the cumulative caffeine in the body
% for a = 1:f
%     dose = i;  % The new caffeine dose
%     % Add current dose and decay all previous doses
%     total_caffeine = total_caffeine + dose / (2^((a-1)/2));
% end
% disp(total_caffeine)


% syms x1
% x0=1
% eq1 = x1^2+3*x1
% h1 = subs(eq1,x0)
% h2 = double(h1)
% class(h1)
% class(h2)

% syms x1
% eq1 = x1^3-0.5;
% k = solve(eq1)
% vpa(k, 3)

% syms x;
% expression1 = sin(2*x) + x^4;

% function [y,dy,ddy]=myfunc_syms(expression1)
%     y=expression1;
%     dy=diff(y);
%     ddy=diff(y,2);
% end

% [y,dy,ddy]=myfunc_syms(expression1)


% syms p1 p2
% eqns = [2*p1 + 4*p2 == 0, p1 - p2/2 == 3];
% S = solve(eqns,[p1 p2])


% syms p1 p2
% eqns = [2*p1 + 4*p2 == 0, p1 - p2/2 == 3];
% S = solve(eqns,[0,0])