function aR = aRight(state, params, value)

if intersect(state, 1:params.nGridPoints)
    aR = value(state);
else
    aR = value(state-params.nGridPoints);
end