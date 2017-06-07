clear; close all;

%% INITIALIZATIONS

params = initParams();
% discretized by x, y, theta
NUM_STATES = params.nGridPoints^2*params.nRadPoints;
TOLERANCE = 0.01;

%% DESTINATION - desired final state

% changed definition of r = 0 to mean advancing in the positive y direction
x_f = 5.0; y_f = 10.0; r_f = 0.0;
destination = StateToLinear(params, [x_f,y_f,r_f]);

%% OBSTACLE

% define obstacle boundary
x_o = [4 5 6 7 4]; y_o = [4 6 5 4 4];
obstacle = [x_o' y_o'];

%% INITIAL POSITION

x = 5.0; y = 0.0; r = 0.0;
% state is the number given to this state
state = StateToLinear(params, [x,y,r]);
save states.mat state destination obstacle

%% INITIALIZE MDP VARIABLES

% initialized with no transitions/rewards observed
value = zeros(NUM_STATES,1);
value_prime = zeros(NUM_STATES,1);
reward = zeros(NUM_STATES,1);
policy = ones(NUM_STATES,1);
% if position of state is inside target, probability = 1
for i=1:params.nRadPoints
    reward(destination+(i-1)*params.nGridPoints^2) = 1;
    policy(destination+(i-1)*params.nGridPoints^2) = '*';
end

N = 10000;
n = 0;

%% FIND OPTIMAL POLICY

while true
    
    value = value_prime;
    n = n+1;
    delta = 0;
    
    for i=1:NUM_STATES
        [value_prime, policy] = valueUpdate(params, i, reward, value, value_prime, policy, obstacle);
        diff = abs(value_prime(i)-value(i));
        if diff > delta
            delta = diff;
        end
    end
    
    if (delta < TOLERANCE || n > N)
        break;
    end
    
end
% optimal policy for each state saved into DP table
charPolicy = char(policy);
save charPolicy.mat charPolicy
save value.mat value