function aL = aLeft(state, params, value)

% can't go left if x = 0
if intersect(state, params.nGridPoints^2-params.nGridPoints+1:params.nGridPoints^2)
    aL = value(state);
else
    aL = value(state+params.nGridPoints);
end