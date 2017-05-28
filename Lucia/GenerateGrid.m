function [XX YY] = GenerateGrid(params)
[XX YY] = meshgrid(linspace(0,params.gridWidth, params.nGridPoints),linspace(0,params.gridHeight, params.nGridPoints));
end