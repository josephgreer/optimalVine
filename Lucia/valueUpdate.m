function [value_prime, policy] = valueUpdate(params, state, reward, value, value_prime, policy, obstacle)

GAMMA = 0.995; % discount factor

if reward(state) ~= 0
    value_prime(state) = reward(state);
else % use Bellman equation
    coordinate = LinearToState(params, state);
    % is robot at edge of workspace?
    edge = workspaceEdge(params, coordinate);
    % update values
    aL = aLeft(params, state, coordinate, edge, obstacle, value);
    aR = aRight(params, state, coordinate, edge, obstacle, value);
    aS = aStraight(params, state, coordinate, edge, obstacle, value);
    % expected reward in future states - P = 0 everywhere except 3 states
    actions = params.Pturns*[aS; aL; aR];
    % find optimal action for state
    [~, max_idx] = max(actions);
    % reward is independent of action - maximize total expected reward
    value_prime(state)= reward(state) + GAMMA*actions(max_idx);
    
    if max_idx==1
        policy(state)='S';
    elseif max_idx==2
        policy(state)='L';
    else
        policy(state)='R';
    end
    
end