function aS = aStraight(state, params, value)

if intersect(state, params.nGridPoints*(1:params.nGridPoints))
    aS = value(state);
else
    aS = value(state+1);
end