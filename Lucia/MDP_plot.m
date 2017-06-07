clear; close all;

params = initParams();
load('value.mat');
x = linspace(1,params.gridWidth,params.nGridPoints);
y = linspace(1,params.gridWidth,params.nGridPoints);
z = reshape(value, [params.nGridPoints^2 params.nRadPoints]);
z_sum = sum(z,2);
z_max = max(z_sum);
P_z = z_sum/z_max;
surf(x,y,reshape(P_z, [params.nGridPoints params.nGridPoints]));
axis tight