---
title: ODE 암시적 솔버 (implicit solvers)
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20260310
tags: 미분방정식
lang: ko
---

# Prerequisites

본 포스트를 잘 이해하기 위해선 아래의 내용에 대해 알고 오는 것이 좋습니다. 

* [방향장과 오일러 방법](https://angeloyeo.github.io/2021/04/30/direction_fields.html)

물리 시뮬레이션의 성능을 결정짓는 핵심 엔진인 Implicit Solver(암시적 솔버)와 Newton-Raphson(NR) 방법의 관계를 정리해 본다. Simscape나 `ode15s`가 왜 Stiff한 문제에서 강력한지, 그 내부 수학적 원리를 코드로 풀어서 설명한다.

# 솔버의 두 얼굴: Forward Euler vs. Backward Euler

미분 방정식 $\dot{x} = f(x)$를 컴퓨터로 풀기 위해서는 연속적인 시간을 잘게 쪼개는 '이산화(Discretization)' 과정이 필요하다. 이때 기울기를 어디서 가져오느냐에 따라 솔버의 운명이 갈린다.

## 1. Forward Euler (전방 오일러: Explicit)

가장 직관적인 방법이다. 현재 지점($x_n$)에서의 기울기를 보고 다음 지점($x_{n+1}$)을 결정한다.

$$x_{n+1} = x_n + h \cdot f(x_n)$$

* 장점: 계산이 매우 빠르고 단순하다. 우변에 모르는 값($x_{n+1}$)이 없기 때문에 바로 답이 나온다.
* 단점: 시스템이 급격히 변하는(Stiff) 구간에서 보폭($h$)을 조금만 크게 가져가도 궤도를 이탈하며 결과가 폭발(발산)한다. 소위 '눈 감고 뛰는 것'과 비슷하다.

## 2. Backward Euler (후방 오일러: Implicit)

반면, 후방 오일러는 내가 도착할 미래 지점($x_{n+1}$)에서의 기울기를 미리 참조한다.

$$x_{n+1} = x_n + h \cdot f(x_{n+1})$$

* 특징: 식의 양변에 모두 $x_{n+1}$이 들어있다. 즉, $x_{n+1}$을 구하기 위해선 방정식을 다시 풀어야 하는 '암시적(Implicit)' 구조다.
* 장점: 수학적으로 매우 안정적이다. 미래의 기울기를 미리 반영하기 때문에 보폭을 크게 가져가도 궤도를 크게 벗어나지 않는다.

# 왜 Explicit 솔버는 한계가 있는가?

우리가 흔히 쓰는 `ode45` 같은 현시적(Explicit) 솔버는 현재 위치의 기울기만 보고 다음 발걸음을 뗀다. 하지만 시스템이 급격하게 변하는 'Stiff'한 구간에 들어서면, 조금만 보폭($h$)을 크게 가져가도 궤도를 이탈하여 결과값이 발산해버린다.

이를 해결하기 위해 등장한 것이 암시적(Implicit) 솔버다. 이 솔버는 단순히 현재를 보는 게 아니라, "내가 도착할 다음 지점에서도 물리 법칙이 성립하는가?"를 확인하며 나아간다.

---

## 1. 암시적 솔버의 핵심: 잔차 식(G)

미분 방정식 $\dot{x} = f(x)$를 풀 때, 후방 오일러(Backward Euler) 방식은 다음과 같은 식을 세운다.

$$x_{n+1} = x_n + h \cdot f(x_{n+1})$$

여기서 우변에 우리가 구하려는 미래의 값 $x_{n+1}$이 들어있다는 점이 핵심이다. 이 식을 만족하는 $x_{n+1}$을 찾기 위해 모든 항을 한쪽으로 몰아 잔차 식(Residual) $G$를 정의한다.

$$G(x_{n+1}) = (x_{n+1} - x_n) - h \cdot f(x_{n+1}) = 0$$

여기서 $(x_{n+1} - x_n)$ 은 현재 상황, 즉 실제 변화량을 나타내고, $h \cdot f(x_{n+1})$ 은 이상적인 상황, 즉, 물리 법칙이 요구한 변화량이다.

### '물리 법칙 위반 성적표'란 무엇인가?

이 잔차 식 $G$는 현재 우리가 추측한 $x_{n+1}$이 자연의 법칙을 얼마나 잘 따르고 있는지를 보여주는 성적표와 같다. 식의 의미를 공학적으로 뜯어보면 다음과 같다.

* 현실 (Left): 내가 계산기로 두드려보니 전압이 $x_n$에서 $x_{n+1}$로 변했다. 즉, $(x_{n+1} - x_n)$만큼 실제로 이동했다는 뜻이다.
* 이상 (Right): 물리 법칙($f$)에 $x_{n+1}$을 대입해 보니 "이 지점에선 이 정도 속도로 움직여야 해"라고 명령한다. 여기에 시간 $h$를 곱한 $h \cdot f(x_{n+1})$은 물리 법칙이 정해준 '규정 이동 거리'가 된다.

만약 우리가 찾은 $x_{n+1}$이 정답이라면, [내가 실제로 이동한 거리]와 [물리가 가라고 명령한 거리]가 정확히 일치해야 한다.

* $G = 0$ 이면: "성적표 만점!" 자연의 법칙과 완벽하게 일치하는 다음 상태를 찾은 것이다.
* $G \neq 0$ 이면: "규정 위반!" 물리는 이만큼 가라고 했는데, 내 계산 값은 저만큼 가 버렸다. 그 차이($G$)가 바로 오차이며, 솔버는 이 위반 점수를 0점으로 만들기 위해 값을 끊임없이 수정한다.

결국, Simscape가 시뮬레이션 중에 "수렴(Convergence)에 실패했다"는 메시지를 띄우는 것은, 이 성적표의 오차 $G$를 도저히 0으로 만들 수 없는 물리적 모순이 모델 안에 있다는 뜻이다.

## 2. 수학적 지우개: Newton-Raphson (NR)

잔차 $G$를 0으로 만들기 위해 사용하는 가장 강력한 도구가 바로 Newton-Raphson(NR) 반복법이다. 단순히 무작위로 값을 대입하며 정답을 찍는 게 아니라, 현재 위치에서 자코비안(Jacobian, $J$)이라는 수학적 나침반을 보고 정답($G=0$)을 향해 최단 거리로 전진한다.

### 자코비안(J): 정답을 향한 내비게이션

자코비안은 "내가 추측값($x$)을 아주 살짝 바꿨을 때, 물리 위반 성적표($G$)가 얼마나 예민하게 변하는가?"를 나타내는 지표다.

* 수학적 정의: $J = \frac{dG}{dx_{n+1}} = 1 - h \cdot \frac{df}{dx_{n+1}}$
* 공학적 의미: 현재 안갯속(비선형 시스템)에 갇혀 있을 때, 발밑의 경사도(기울기)를 확인하여 "어느 방향으로 얼마만큼 가야 평지(정답)에 도달할지"를 알려주는 가이드라인이다.

### 업데이트

$$x_{new} = x_{old} - \frac{G}{J}$$

이 식은 NR의 핵심 알고리즘으로, 다음과 같은 논리 구조를 가진다.

1. 위반 점수($G$)가 크면: "정답에서 멀리 떨어져 있구나!" $\rightarrow$ 더 많이 이동한다.
2. 기울기($J$)가 가파르면: "조금만 움직여도 점수가 팍팍 변하네?" $\rightarrow$ 신중하게 조금만 이동한다.

이 두 값을 조합한 `step = G / J`만큼 현재 값을 수정해 나가면, 놀랍게도 단 몇 번의 반복(Iteration)만으로 오차 $G$는 순식간에 0에 수렴하게 된다.

### Implicit 솔버가 '보폭(h)'을 키울 수 있는 비결

Explicit 솔버(Forward Euler)가 한 번의 계산으로 끝내는 '단거리 달리기'라면, NR을 사용하는 Implicit 솔버는 "예측하고, 검토하고, 수정하는" 과정을 거치는 '정밀 타격'과 같다.

* Self-Correction: 설령 보폭($h$)을 크게 가져가서 첫 추측이 빗나가더라도, NR 루프가 잔차($G$)를 확인하며 정답 궤도로 끊임없이 수정해 준다.
* Numerical Stability: 이 '자기 수정 능력' 덕분에 시스템이 딱딱하게(Stiff) 굳어 있는 구간에서도 수치적 폭주 없이 안정적으로 해를 찾아낼 수 있는 것이다.

## 3. MATLAB으로 구현하는 Implicit Solver

다음은 $f(x) = x^2 - x^3$라는 Stiff한 시스템을 직접 구현한 코드이다. Newton-Raphson 루프가 어떻게 작동하는지 주목해 보자.

```
clear; clc; close all;

%% 1. 파라미터 및 시스템 설정
% f(x) = x^2 - x^3
% dx/dt가 x=1 부근에서 매우 민감하게 변하는 Stiff 특성
t_end = 200; 
x0 = 0.01; % 초기값 (0.01에서 시작해 1로 수렴하는 과정 관찰)

f = @(t, x) x^2 - x^3; % dx/dt = f 임. 
% 자코비안 (NR을 위한 미분값): df/dx = 2*x - 3*x^2
dfdx = @(x) 2*x - 3*x^2;

%% 2. MATLAB 내장 솔버 (Variable-step)
% ode45: Explicit (이 문제에서 스텝을 아주 잘게 쪼개야 함)
[t45, x45] = ode45(f, [0 t_end], x0);

% ode15s: Implicit (Stiff한 구간을 성큼성큼 넘어감)
[t15s, x15s] = ode15s(f, [0 t_end], x0);

%% 3. 수동 구현: Implicit Euler (Fixed-step, Newton-Raphson)
h = 0.5; % 매우 큰 고정 스텝 (Explicit였다면 수치 오류가 날 수 있는 크기)
t_manual = 0:h:t_end;
x_manual = zeros(size(t_manual));
x_manual(1) = x0;

for n = 1:length(t_manual)-1
    xc_now = x_manual(n);
    xc_next = xc_now; % 초기 추정값
    
    % Newton-Raphson Iteration
    for iter = 1:20
        % 잔차 G(x_next) = x_next - x_now - h * f(x_next) = 0
        G = xc_next - xc_now - h * (xc_next^2 - xc_next^3);
        
        % 자코비안 J = dG/dx_next = 1 - h * df/dx
        J = 1 - h * dfdx(xc_next);
        
        step = G / J;
        xc_next = xc_next - step;
        
        if abs(step) < 1e-8, break; end
    end
    x_manual(n+1) = xc_next;
end

%% 4. 결과 비교 시각화
figure('Color', 'w', 'Position', [100, 100, 900, 550]);

subplot(2,1,1);
plot(t45, x45, 'g-', 'LineWidth', 2); hold on;
plot(t15s, x15s, 'b--', 'LineWidth', 2);
plot(t_manual, x_manual, 'ro', 'MarkerSize', 4);
grid on;
ylabel('x', 'FontSize', 11);
title(['Solver Comparison: f(x) = x^2 - x^3 (x_0 = ', num2str(x0), ')'], 'FontSize', 13);
legend({'ode45 (Explicit)', 'ode15s (Implicit)', 'Manual Implicit (NR)'}, 'Location', 'southeast');

% 스텝 사이즈 비교 (솔버가 얼마나 고생하는지 시각화)
subplot(2,1,2);
stem(t45(1:end-1), diff(t45), 'g', 'Marker', 'none'); hold on;
stem(t15s(1:end-1), diff(t15s), 'b', 'Marker', 'none');
set(gca, 'YScale', 'log'); % 로그 스케일로 스텝 크기 차이 강조
grid on;
ylabel('Step Size (log scale)', 'FontSize', 11);
xlabel('Time (s)', 'FontSize', 11);
legend({'ode45 steps', 'ode15s steps'});

fprintf('--- Solver Statistics ---\n');
fprintf('ode45  Total Steps: %d\n', length(t45));
fprintf('ode15s Total Steps: %d\n', length(t15s));
fprintf('Manual (h=%g) Steps: %d\n', h, length(t_manual));
```

결과적으로 step의 개수는 아래와 같다.

```
--- Solver Statistics ---
ode45  Total Steps: 157
ode15s Total Steps: 50
Manual (h=0.5) Steps: 401
```

<p align = "center">
  <img width = "100%" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-10-ODE_implicit_solvers/pic1.png">
  <br>
  그림 1. ode45, ode15s와 함께 수동으로 구현한 implicit solver의 결과 비교
</p>


## 결론: 왜 우리는 이 원리를 알아야 하는가?

Simscape나 Simulink의 `ode15s` 솔버를 쓸 때 내부적으로 일어나는 일이 바로 이 '예측과 수정'의 반복이다.

1. 시스템이 Stiff(강성)해지면 일반 솔버는 보폭을 줄이느라 느려지지만, Implicit 솔버는 NR 덕분에 큰 보폭으로도 정확한 정답을 찾아간다.
2. 시뮬레이션 중 'Convergence Error'가 발생한다면, 위 코드의 NR 루프에서 잔차 $G$를 0으로 만드는 데 실패했다는 뜻이다.
3. 이 원리를 이해하면 모델링 단계에서 불필요한 불연속성을 제거하거나 솔버 설정을 튜닝하는 데 엄청난 통찰을 얻을 수 있다.

결국 고성능 시뮬레이션은 수학적 신뢰와 계산 효율성 사이의 줄타기이며, 그 중심에는 Newton-Raphson이라는 견고한 다리가 놓여 있다.

이 블로그 포스팅이 엔지니어들에게 도움이 되길 바란다.