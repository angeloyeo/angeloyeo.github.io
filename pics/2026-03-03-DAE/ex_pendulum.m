clear; close all; clc;

L = 1; g = 9.81; my_tspan = [0, 10];
f_ode = @(t, y) [y(2); -(g/L)*sin(y(1))]; % y(1)=theta, y(2)=dot_theta

opts_ode= odeset('RelTol', 1e-5, 'AbsTol', 1e-10);
[t_ode, y_ode] = ode45(f_ode, my_tspan, [pi/4; 0], opts_ode); % 45도에서 시작

plot(t_ode, y_ode(:,1));
title('ODE: 각도 \theta의 변화');
xlabel('Time (s)'); ylabel('Angle (rad)');

%%
m = 1; L = 1; g = 9.81;

% Mass Matrix
M = diag([1 1 1 1 0]); 

f_dae = @(t, Y) [
    Y(3);                               % x' = u
    Y(4);                               % y' = v
    Y(5)*Y(1)/m;                        % u' = (lambda * x)/m
    (Y(5)*Y(2) - m*g)/m;                % v' = (lambda * y - mg)/m
    % Index-1 제약 조건: 가속도 수준 (x*u' + y*v' + u^2 + v^2 = 0)
    % 여기에 u'과 v' 자리에 위의 식들을 대입하여 정리한 형태입니다.
    Y(3)^2 + (Y(1)*(Y(5)*Y(1)/m)+ Y(4)^2 + Y(2)*((Y(5)*Y(2) - m*g)/m) )
];

% f_dae의 마지막 행은 x^2+y^2=L^2라는 물리적 제약을 가속도 수준까지 미분하여 작성한 것임.
% ode15s는 Index-1 제약 조건까지만 풀 수 있기 때문임.
% Index는 대수 방정식(제약 조건)을 미분방정식으로 바꾸기 위해 최소 몇 번 미분해야하는지를 나타내는 척도.
% --- 제약 조건의 Index Reduction 유도 과정 (Index 3 -> Index 1) ---
% 목표: 위치 제약식(Index 3)을 가속도 수준(Index 1)으로 변환하여 ode15s가 풀 수 있게 함.
%
% [1단계] 위치 제약 (Position Constraint): 진자의 길이는 L로 일정하다.
% 식: x^2 + y^2 - L^2 = 0
%
% [2단계] 속도 제약 (Velocity Constraint): 위치식을 시간 t에 대해 1차 미분.
% d/dt (x^2 + y^2 - L^2) = 2*x*x' + 2*y*y' = 0
% x*u + y*v = 0  (여기서 x'=u, y'=v) -> [Index 2]
%
% [3단계] 가속도 제약 (Acceleration Constraint): 속도식을 시간 t에 대해 2차 미분.
% d/dt (x*u + y*v) = (x'*u + x*u') + (y'*v + y*v') = 0
% x*u' + y*v' + u^2 + v^2 = 0  (x'=u, y'=v 대입) -> [Index 1]
%
% [4단계] 시스템 방정식 대입 (Final Substitution): 
% 물리 법칙(F=ma)에서 유도된 가속도 항(u', v')을 3단계 식에 대입.
% u' = (lambda * x) / m
% v' = (lambda * y - m*g) / m
% 최종식: x * [(lambda * x) / m] + y * [(lambda * y - m*g) / m] + u^2 + v^2 = 0
%
% 아래 Y(5)는 lambda(장력/제약력)를 의미하며, 위 최종식을 코드로 구현한 것임:
% (Y(1)*(Y(5)*Y(1)/m) + Y(2)*((Y(5)*Y(2) - m*g)/m) + Y(3)^2 + Y(4)^2)

opts_dae = odeset('Mass', M, 'MassSingular', 'yes');
y0 = [sin(pi/4); -cos(pi/4); 0; 0; 0]; 

[t_dae, y_dae] = ode15s(f_dae, my_tspan, y0, opts_dae);

%%
figure;
% 1. ODE 결과 변환: x = L * sin(theta)
plot(t_ode, L * sin(y_ode(:,1)), 'b-', 'LineWidth', 2); 
hold on;

% 2. DAE 결과: 이미 x 좌표임 (Y(1))
plot(t_dae, y_dae(:,1), 'r--', 'LineWidth', 1.5); 

legend('ODE (L sin \theta)', 'DAE (x)');
xlabel('Time (s)'); ylabel('Horizontal Position x (m)');
title('ODE vs DAE: 물리적 일관성 확인');
grid on;

%% 라그랑주 승수의 의미

figure;
tiledlayout(3, 1)
nexttile;
plot(t_dae, y_dae(:,1));
hold on;
plot(t_dae, y_dae(:,2));
nexttile;
plot(t_dae, y_dae(:,3));
hold on;
plot(t_dae, y_dae(:,4));
nexttile;
plot(t_dae, y_dae(:,5));

figure;
plot(t_dae, y_dae(:,1).*y_dae(:,5));
hold on;
plot(t_dae, y_dae(:,2).*y_dae(:,5));