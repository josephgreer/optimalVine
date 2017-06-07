function coordinate = LinearToState(params, state)

[i,j,k] = ind2sub([params.nGridPoints params.nGridPoints params.nRadPoints], state);
coordinate = [(j-1)*params.widthStep,(i-1)*params.heightStep,(k-1)*params.radStep];