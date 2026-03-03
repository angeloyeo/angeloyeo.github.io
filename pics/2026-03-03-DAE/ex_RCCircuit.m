clear; close all; clc;

%% --- 공통 파라미터 ---
R = 100;      % 저항 (Ohm)
C = 10e-6;    % 커패시터 (Farad)
Vin = 5;      % 입력 전압 (V)
tspan = [0 0.01]; % 0.01초까지 시뮬레이션

%% --- [Case 1] ODE 방식 (커패시터 전압 Vc 기반) ---
% C * dVc/dt = I = (Vin - Vc) / R
% dVc/dt = (Vin - Vc) / (R*C)
f_ode = @(t, Vc) (Vin - Vc) / (R * C);
[t_ode, V_ode] = ode45(f_ode, tspan, 0); % 초기 전압 0V

%% --- [Case 2] DAE 방식 (소자 식 나열: 비인과적 모델링) ---
% 상태 변수 Y = [Vr; Vc; I]
% 1. Vr - I*R = 0          (저항의 법칙 - 대수)
% 2. C * Vc' = I           (커패시터의 법칙 - 미분)
% 3. Vin - Vr - Vc = 0     (KVL 연결 법칙 - 대수)

% Mass Matrix: 미분항이 있는 Vc(2번 변수)만 1, 나머지는 0
M = [0 0 0; 
     0 C 0; 
     0 0 0];

f_dae = @(t, Y) [
    Y(1) - Y(3)*R;         % 식 1: Vr = I * R
    Y(3);                  % 식 2: C*Vc' = I (M 행렬에 의해 C가 곱해짐)
    Vin - Y(1) - Y(2)      % 식 3: Vin - Vr - Vc = 0
];

opts = odeset('Mass', M, 'MassSingular', 'yes');
% 초기값: [Vr; Vc; I] = [5; 0; 5/100]
y0 = [Vin; 0; Vin/R];

[t_dae, y_dae] = ode15s(f_dae, tspan, y0, opts);

%% --- 결과 시각화 ---
figure('Color', 'w');
plot(t_ode, V_ode, 'b-', 'LineWidth', 2); hold on;
plot(t_dae, y_dae(:,2), 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)'); ylabel('Voltage (V)');
title('RC 회로 시뮬레이션: ODE vs DAE');
legend('ODE (Integrated Equation)', 'DAE (Component-wise Equations)');

% % 전류 확인 (DAE의 장점: 중간 변수를 바로 확인 가능)
% figure('Color', 'w');
% plot(t_dae, y_dae(:,3), 'k', 'LineWidth', 1.5);
% title('DAE로 계산된 회로 내 전류(I)');
% xlabel('Time (s)'); ylabel('Current (A)');
% grid on;