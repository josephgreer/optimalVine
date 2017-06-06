clear; close all;

params = initParams();
load('value.mat');
x = linspace(1,params.gridWidth,params.nGridPoints);
y = linspace(1,params.gridWidth,params.nGridPoints);
z = reshape(value, [params.nGridPoints^2 params.nRadPoints]);
for i=1:params.nRadPoints
    figure(i)
    surf(x,y,z(:,:,i));
    axis tight;
end