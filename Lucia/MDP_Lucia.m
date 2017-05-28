clear; close all;

%% INITIALIZATIONS

params = initParams();
NUM_STATES = params.nGridPoints^2; % discretized by x,y coordinates
TOLERANCE = 0.01;
pause_time = 0.1;
display_started = 1;

%% DESTINATION - desired final state

x_f = 9.0; y_f = 8.0; r_f = 0.0;
destination = StateToLinear_edit(params, [x_f,y_f,r_f]);

%% INITIAL POSITION

x = 5.0; y = 0.0; r = pi/2;
% state is the number given to this state
state = StateToLinear_edit(params, [x,y,r]);

%% INITIALIZE DISPLAY **************************************** FIX THIS

if display_started==1
    vine([x_f,y_f,r_f], [x,y,r], params, pause_time);
end

%% INITIALIZE MDP VARIABLES

value = zeros(NUM_STATES,1);
value_prime = zeros(NUM_STATES,1);
reward = -3*ones(NUM_STATES,1);
policy = ones(NUM_STATES,1);
reward(destination) = 100;
policy(destination) = '*';

N = 10000;
n = 0;

%% FIND OPTIMAL POLICY

while 1
    
    value = value_prime;
    n = n+1;
    delta = 0;
    
    for i=1:NUM_STATES
        [value_prime, policy] = value_update(i, params, reward, value, value_prime, policy);
        diff = abs(value_prime(i)-value(i));
        if diff > delta
            delta = diff;
        end
    end
    
    if (delta < TOLERANCE || n > N)
        break;
    end
    
end

%% DISPLAY ********************************** FIX THIS
charPolicy = char(policy);