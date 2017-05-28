function [value_prime, policy] = value_update(state, params, reward, value, value_prime, policy)

GAMMA = 0.995; % discount factor

if reward(state) ~= -3
    value_prime(state) = reward(state);
else % use Bellman equation
    % **************************************
    % FIX BECAUSE THE FRAME OF REFERENCE CHANGES SO STRAIGHT MIGHT BE ANGLE
    % DON'T FORGET ABOUT BEING BOUNDED BY OUTSIDE OF GRID
    aL = aLeft(state, params, value);
    aS = aStraight(state, params, value);
    aR = aRight(state, params, value);
    
    actions = params.Pturns*[aL; aS; aR];
    
    [~, max_idx] = max(actions);
    
    value_prime(state)= reward(state) + GAMMA*actions(max_idx);
    
    if max_idx==1
        policy(state)='L';
    elseif max_idx==2
        policy(state)='S';
    else
        policy(state)='R';
    end
    
end