function out = workspaceOut(params, state)

xidx = round(state(1)/params.widthStep)+1;
yidx = round(state(2)/params.heightStep)+1;
out = (xidx>params.nGridPoints) || (xidx<1) || (yidx>params.nGridPoints) || (yidx<1);