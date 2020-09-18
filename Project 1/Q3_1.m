clear all;
clc;

load('velocity_response_2_1.mat')

t = velocity_response_4_1_data(:, 1);
u = velocity_response_4_1_data(:, 2);
v = velocity_response_4_1_data(:, 3);

input = u;
output = v;
sampleTime = t(2) - t(1);   % Assume sample time is constant throughout the entire t vector

% data = iddata(output, input, sampleTime);
% tf = tfest(data, 1)

A = mean(abs(u(mod(t,0.5)==0)));

Kv = mean(abs(v(mod(t,0.5)==0)))/A;

% tau_v1 = mod(t(abs(v) > 0.61 * Kv & abs(v) < 0.65 * Kv), 0.5) / 1;
% tau_v2 = mod(t(abs(v) > 0.84 * Kv & abs(v) < 0.88 * Kv), 0.5) / 2;
% tau_v3 = mod(t(abs(v) > 0.93 * Kv & abs(v) < 0.97 * Kv), 0.5) / 3;
% tau_v4 = mod(t(abs(v) > 0.96 * Kv & abs(v) < 1.00 * Kv), 0.5) / 4;
% 
% tau_v = mean([tau_v1; tau_v2; tau_v3; tau_v4]);

figure(1)
plot(t, v)
hold on
plot(t, 0.6321*Kv*A*ones(size(t)), t, -0.6321*Kv*A*ones(size(t)))
plot(t, 0.8647*Kv*A*ones(size(t)), t, -0.8647*Kv*A*ones(size(t)))
plot(t, 0.9502*Kv*A*ones(size(t)), t, -0.9502*Kv*A*ones(size(t)))
plot(t, 0.9817*Kv*A*ones(size(t)), t, -0.9817*Kv*A*ones(size(t)))

%look at the intersection in the plot
t1 = [0.61 1.12 1.61 2.12 2.62 3.13 3.61];
t2 = [0.66 1.2 1.68 2.23  2.67 3.2 3.78];
t3 = [0.71 1.31 1.7 2.3 2.73 3.32 3.73];
t4 = [0.72 1.43 1.73 2.37 2.76 3.4 3.76];
tau_v1 = mod(t1, 0.5) / 1;
tau_v2 = mod(t2, 0.5) / 2;
tau_v3 = mod(t3, 0.5) / 3;
tau_v4 = mod(t4, 0.5) / 4;
tau_v = mean([tau_v1 tau_v2 tau_v3 tau_v4]);

open('Q3_1b.slx');
sim('Q3_1b.slx');

figure(2)
plot(t, v, v_theo.time, v_theo.signals.values)
