---
title: 극점 배치법을 활용한 선형 제어기 설계
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20260308
tags: 미분방정식 선형대수학 제어이론
lang: ko
---

<p align = "center">
  <video width = "100%" height = "auto" loop autoplay muted>
    <source src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-08-Pole_Placing/InvertedDoublePendulum.mp4">
  </video>
  <br>
  극점 배치법을 이용한 이중도립진자의 제어. <br> 모델 소스: <a href = "https://kr.mathworks.com/help/sm/ug/inverted-double-pendulum-on-a-sliding-cart.html"> MathWorks Simscape Multibody 문서 </a>
</p>

# Prerequisites

본 포스트를 잘 이해하기 위해선 아래의 내용에 대해 알고 오는 것이 좋습니다.

* [자연상수 e와 제차 미분방정식](https://angeloyeo.github.io/2021/05/05/ODE_and_natural_number_e.html)
* [비제차 미분방정식의 의미](https://angeloyeo.github.io/2021/05/25/nonhomogeneous_equation.html)
* [고윳값과 고유벡터](https://angeloyeo.github.io/2019/07/17/eigen_vector.html)
* [자코비안(Jacobian) 행렬의 기하학적 의미](https://angeloyeo.github.io/2020/07/24/Jacobian.html)
* [라플라스 변환(Laplace transform)](https://angeloyeo.github.io/2019/08/12/Laplace_transform.html)

제어의 뿌리가 선형대수학과 미분방정식이라는걸 알 수 있는 prerequisite 이네요. 선형대수학과 미분방정식이 제어 공학과 어떻게 완벽하게 맞물려 돌아가는지, 그 아름다운 연결고리를 듬뿍 담아 블로그 포스팅을 작성해 보았습니다. 

# 미분방정식과 선형대수학으로 '거꾸로 선 진자' 세우기: 극점 배치(Pole Placement)의 마법

학부 시절, 우리는 미분방정식을 풀고 행렬의 고유값(Eigenvalue)을 계산하며 이런 의문을 품곤 했을 것이다. *"도대체 이 복잡한 수학을 현실 어디에 써먹는 걸까?"*

오늘은 그 질문에 대한 가장 짜릿한 대답 중 하나를 소개하려고 한다. 바로 **제어 공학(Control Engineering)**이다. 카트 위에 위태롭게 서 있는 막대기를 쓰러지지 않게 세우는 **'도립 진자(Inverted Pendulum)'** 시스템을 통해, 우리가 배운 수학이 어떻게 물리적 세상을 지배하는지 알아보자.

이번 파트에서는 제어에 대한 지식보다는 우리가 잘 아는 선형대수학과 미분방정식의 기초에 기반하여 "극점 배치" 제어 기법에 대해서 알아볼 것이다.

---

## 1. 물리 현상을 수학의 언어로: 미분방정식과 상태(State)

<p align = "center">
  <img width = "50%" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-08-Pole_Placing/pic1.png">
  <br>
  그림 1. 카트 + 도립 진자 문제. 그림 출처: 참고 문헌 [1]의 Figure 8.12
</p>

우리의 목표는 카트(Cart)를 좌우로 움직여서 그 위에 얹혀 있는 진자(Pendulum)가 쓰러지지 않게 수직($\theta = \pi$)으로 세우는 것이다.

먼저 이 시스템을 뉴턴의 역학 법칙으로 풀어내면, 위치와 각도의 2계 미분(가속도)이 포함된 복잡한 **비선형 연립 미분방정식**이 등장한다.

여기서 제어공학은 첫 번째 수학적 기교를 부린다. 고계 미분방정식을 다루기 쉽게 만들기 위해, 변수들을 1차 미분 형태로 쪼개어 하나의 **벡터(Vector)**로 묶을 수 있다.

카트의 위치($x$), 속도($\dot{x}$), 진자의 각도($\theta$), 각속도($\dot{\theta}$)를 원소로 하는 4차원 벡터 $\mathbf{x}$를 정의하고 이를 **상태 벡터(State Vector)**라고 부르자.

$$\mathbf{x} = \begin{bmatrix} x \\ \dot{x} \\ \theta \\ \dot{\theta} \end{bmatrix} % 식(1)$$

**"제어(control)"** 의 이름에서 알 수 있듯이 우리는 외부 입력을 통해서 시스템의 상태를 조정할 수 있다. [비제차 미분방정식의 의미](https://angeloyeo.github.io/2021/05/25/nonhomogeneous_equation.html) 편에서 본 것 처럼, 외부 입력 $u$가 포함된 비제차 미분방정식을 아래와 같이 표현할 수 있을 것이다.

$$\dot{\mathbf{x}} = f(\mathbf{x}, u) % 식 (2)$$

*(여기서 $u$가 우리가 카트에 가하는 '힘', 즉 제어 입력이며, 함수 $f$는 비선형 함수일 수 있다.)*

이제 시스템의 움직임은 4차원 공간 안에서 점이 이동하는 궤적으로 추상화되었다고 수학적으로 이해할 수 있다. 참고로 식 (2)에 대한 구체적인 nonlinear dynamics는 아래와 같다.

$$\dot{x} = v % 식 (3)$$

$$\dot{v} = \frac{-m^2L^2g\cos\theta + mL^2(mL\omega^2\sin\theta-\delta v)+mL^2u}{mL^2\left(M+m(1-\cos^2\theta\right))} % 식 (4)$$

$$\dot{\theta} = \omega % 식 (5)$$

$$\dot{\omega} = \frac{(m+M)mgL\sin\theta-mL\cos\theta(mL\omega^2\sin\theta-\delta v)+mL(\cos\theta) u}{mL^2(M+m(1-\cos^2\theta))} % 식 (6)$$

여기서 $x$는 카트의 위치, $v$는 카트의 속도, $\theta$는 진자의 각도, $\omega$는 진자의 각속도, $m$은 진자의 무게, $M$은 카트의 무게, $L$은 진자의 팔 길이, $g$는 중력 가속도, $\delta$는 friction damping 계수, 그리고 $u$는 카트에 작용하는 제어 힘이다.

MATLAB으로 이 nonlinear dynamics를 쓰면 아래와 같다.

```
function dx=pendcart(x,m,M,L,g,d,u)
Sx= sin(x(3));
Cx= cos(x(3));
D =m*L*L*(M+m*(1-Cxˆ2));
dx(1,1)=x(2);
dx(2,1)=(1/D)*(-mˆ2*Lˆ2*g*Cx*Sx+m*Lˆ2*(m*L*x(4)ˆ2*Sx-d*x(2)))+m*L*L*(1/D)*u;
dx(3,1)=x(4);
dx(4,1)=(1/D)*((m+M)*m*g*L*Sx-m*L*Cx*(m*L*x(4)ˆ2*Sx-d*x(2)))-m*L*Cx*(1/D)*u;
```

이 시스템을 아무런 입력 없이 ode45로 풀면 아래와 같이 진자가 흔들리면서 마찰 계수 $\delta$에 의해 서서히 멈추는 결과를 확인할 수 있다.

```
m = 1;
M = 5;
L = 2;
g = -10;
d = 1;
tspan = 0:.001:30;
y0 = [0; 0; 0; 0];
[t, y] = ode45(@(t,y) pendcart(y, m, M, L, g, d, 0), tspan, y0);
```

<p align = "center">
  <video width = "100%" height = "auto" loop autoplay controls muted>
    <source src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-08-Pole_Placing/pendCartNoInpupt.mp4">
  </video>
</p>


## 2. 비선형의 벽을 넘다: Jacobian과 선형화

하지만 $f(\mathbf{x}, u)$는 삼각함수($\sin\theta, \cos\theta$)가 난무하는 비선형 함수이다. 지금까지의 논의처럼 선형 시스템에 비해 비선형 시스템(혹은 미분방정식)은 해석적인 해를 구하기도, 다루기도 너무 어렵다.

여기서 **선형대수학의 다변수 미분, 즉 [자코비안(Jacobian)](https://angeloyeo.github.io/2020/07/24/Jacobian.html)** 이 구원투수로 등장한다. 우리는 진자가 꼿꼿이 서 있는 목표 상태(Fixed Point) 근처에서 이 비선형 방정식을 테일러 전개하여 **선형화(Linearization)** 할 수 있다. 그 결과, 다음과 같은 아름다운 **상태 공간 방정식(State-Space Equation)** 을 얻게 된다.

$$\dot{\mathbf{x}} = \mathbf{A}\mathbf{x} + \mathbf{B}u % 식 (7)$$

* **$\mathbf{A}$ (4x4 시스템 행렬):** 시스템 자체의 물리적 특성(질량, 길이, 마찰 등)을 담고 있는 행렬
* **$\mathbf{B}$ (4x1 입력 행렬):** 우리가 가하는 힘 $u$가 4개의 상태 변수에 각각 얼마나 영향을 미치는지를 나타내는 벡터

Fixed Point는 진자가 완전 내려가 있거나 ($\theta = 0$) 혹은 똑바로 서 있는 경우($\theta = \pi$)이며, 이때 카트의 속도와 진자의 각속도는 모두 0인 상태($v=\omega=0$)이다. 카트의 위치는 어디에 있던지 상관 없으므로 $x$는 free variable이다. 구체적으로 선형화된 식인 식 (7)을 써보자면 아래와 같다.

$$\frac{d}{dt}\begin{bmatrix}x_1\\x_2\\x_3\\x_4\end{bmatrix}
= \begin{bmatrix}
   0 && 1 && 0 && 0 
\\ 0 && \frac{-\delta}{M} && b\frac{mg}{M} && 0 
\\ 0 && 0 && 0 && 1
\\ 0 && -b\frac{\delta}{ML} && -b\frac{(m+M)g}{ML} && 0 \end{bmatrix}\begin{bmatrix}x_1\\x_2\\x_3\\x_4\end{bmatrix}+\begin{bmatrix}0\\\frac{1}{M}\\0\\b\frac{1}{ML}\end{bmatrix}u\text{, for }\begin{bmatrix}x_1\\x_2\\x_3\\x_4\end{bmatrix}=\begin{bmatrix}x\\v\\\theta\\\omega\end{bmatrix}$$

여기서 $b=1$는 진자가 똑바로 서있는 경우의 fixed point를 상정하며, $b=-1$은 진자가 완전 내려가 있는 상태를 상정한다.

이 내용을 MATLAB으로 옮기면 아래와 같다.

```
m =1; M=5; L=2; g=-10; d=1;
b =1; %Pendulumup(b=1)
A = [0 1 0 0;
  0 -d/M b*m*g/M 0;
  0 0 0 1;
  0 -b*d/(M*L) -b*(m+M)*g/(M*L) 0];

B =[0; 1/M; 0; b*1/(M*L)];
```

이제 복잡한 미분방정식이 **행렬의 곱셈**이라는 선형대수학의 영역으로 완벽하게 넘어왔다.

## 3. 진자는 왜 쓰러지는가?: 해(Solution)와 Eigenvalue

$$\dot{\mathbf{x}} = \mathbf{A}\mathbf{x}$$

외부 입력($u=0$)이 없을 때, 이 1계 선형 미분방정식의 일반해는 어떻게 될까? 미분방정식 시간에 배웠듯, 해는 행렬 $\mathbf{A}$의 **고유값(Eigenvalue, $\lambda$)**과 **고유벡터(Eigenvector, $\mathbf{v}$)**의 선형 결합으로 나타난다.

$$\mathbf{x}(t) = c_1 e^{\lambda_1 t}\mathbf{v}_1 + c_2 e^{\lambda_2 t}\mathbf{v}_2 + c_3 e^{\lambda_3 t}\mathbf{v}_3 + c_4 e^{\lambda_4 t}\mathbf{v}_4$$

이 수식을 물리적으로 해석해 보자. 만약 고유값 $\lambda$ 중 단 하나라도 **실수부가 양수(Positive)**라면 어떻게 될까? 시간이 지남에 따라 $e^{\lambda t}$ 항이 무한대로 발산해버린다.

실제로 이 시스템의 행렬 $\mathbf{A}$의 Eigenvalue를 구해보면 양수 값이 존재한다. 진자가 목표점(수직)에서 아주 조금만 벗어나도 기하급수적으로 오차가 커지며 **쓰러진다(발산한다)**는 물리적 직관이, 선형대수학의 고유값을 통해 완벽하게 증명되는 순간이다.

```
>> lambda = eig(A)
lambda =
  0
  -2.4311
  -0.2336
  2.4648
```

## 4. 우리가 이 시스템을 지배할 수 있을까?: 가제어성(Controllability)과 Span

그렇다면 힘 $u$를 적절히 주면 이 발산을 막을 수 있을까? 제어를 시작하기 전에, 선형대수학의 **기저(Basis)**와 **생성(Span)** 개념을 빌려 이 시스템이 제어 가능한지(Controllable) 확인해야 한다.

입력 $\mathbf{B}$가 행렬 $\mathbf{A}$와 상호작용하며 상태 공간을 얼마나 휘저을 수 있는지 나타내는 행렬을 **가제어성 행렬(Controllability Matrix)**이라고 한다.

$$\mathcal{C} = [\mathbf{B} \quad \mathbf{A}\mathbf{B} \quad \mathbf{A}^2\mathbf{B} \quad \mathbf{A}^3\mathbf{B}]$$

이 4x4 행렬의 **Rank(계수)가 4**라면, 이 열벡터들이 4차원 상태 공간 전체를 **Span(생성)**한다는 뜻이다. 즉, 카트에 가하는 힘 $u$ 하나만으로 4개의 상태 변수(위치, 속도, 각도, 각속도)를 모두 우리가 원하는 곳으로 보낼 수 있다는 수학적 보증 수표이다. 다행히 이 시스템은 Rank가 4로 나온다!

```
>> rank(ctrb(A,B))
ans =
  4
```

## 5. 시스템을 해킹하다: 극점 배치 (Pole Placing)

이제 이 포스팅의 하이라이트이자, 제어의 마술인 **극점 배치(Pole Placing)**를 진행해보자.

우리는 시스템이 불안정하다는 것(Eigenvalue가 양수임)을 알았다. 그렇다면 **행렬 $\mathbf{A}$ 자체를 뜯어고칠 수는 없을까?** 현재 상태 $\mathbf{x}$를 실시간으로 측정하여, 제어 입력 $u$를 다음과 같이 상태 벡터의 선형 결합으로 만들어 봅시다. 이를 **상태 피드백(State Feedback)**이라고 한다.

$$u = -\mathbf{K}\mathbf{x}$$

(여기서 $\mathbf{K}$는 1x4 이득 행렬이다.)

이 식을 원래 방정식에 대입해 볼까?

$$\dot{\mathbf{x}} = \mathbf{A}\mathbf{x} + \mathbf{B}(-\mathbf{K}\mathbf{x})$$

$$\dot{\mathbf{x}} = (\mathbf{A} - \mathbf{B}\mathbf{K})\mathbf{x}$$

놀라운 일이 벌어졌다! 원래 시스템 행렬 $\mathbf{A}$가, 우리의 제어기 $\mathbf{K}$가 포함된 **새로운 행렬 $(\mathbf{A} - \mathbf{B}\mathbf{K})$로 바뀌었다.** 제어공학에서 고유값(Eigenvalue)을 부르는 다른 이름이 바로 **극점(Pole)**이다. **Pole Placing(극점 배치)**란, 우리가 설계할 행렬 $\mathbf{K}$의 값들을 조절하여, **새로운 행렬 $(\mathbf{A} - \mathbf{B}\mathbf{K})$의 Eigenvalue들을 우리가 원하는 위치(음수 방향)로 강제로 이동시키는 기술**을 말한다.

## 6. Eigenvalue 위치에 따른 시뮬레이션 결과

MATLAB과 같은 툴을 이용하면 $\mathbf{K}$를 구하는 것은 `place` 함수 한 줄이면 끝난다. Eigenvalue(Pole)를 복소평면의 좌반평면(음수)으로 옮기면 시스템은 무조건 안정화(수렴)된다. 하지만 **어디로** 옮기느냐에 따라 물리적 거동이 완전히 달라진다.

**원점에 가까운 음수 (예: -0.1, -0.2):**
* $e^{-0.1t}$처럼 천천히 0으로 수렴한다.
* **결과:** 카트가 목표 지점으로 매우 느릿느릿 이동하며, 진자도 천천히 중심을 잡는다. 부드럽지만 답답하다.

```
p = [-.3; -.4; -.5; -.6]; % just barely good

K = place(A, B, p);

tspan = 0:.001:10;
y0 = [0; 0; 0; 0];
[t, y] = ode45(@(t,y) pendcart(y, m, M, L, g, d, -K*(y-[4;0;0;0])), tspan, y0);
end
```

<p align = "center">
  <video width = "100%" height = "auto" autoplay muted controls>
    <source src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-08-Pole_Placing/pendCartPolePlaced.mp4">
  </video>
</p>

**더 먼 음수 (예: -1.0, -2.0):**
* $e^{-2.0t}$처럼 빠르게 0으로 수렴한다.
* **결과:** 카트가 날렵하고 공격적으로 움직여 목표 지점에 딱 멈춰 선다. 훌륭한 제어 성능을 보인다.
```
p = [-1; -2; -3; -4];
```

<p align = "center">
  <video width = "100%" height = "auto" autoplay muted controls>
    <source src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2026-03-08-Pole_Placing/pendCartPolePlaced2.mp4">
  </video>
</p>

**극단적인 음수 (예: -5.0 이하):**
* 이론적으로는 수렴 속도가 엄청나게 빨라서 극단적으로 큰 크기의 음수일 수록 좋다고 생각할 수 있다.
* **결과:** 실제로는 문제가 생긴다. 행렬 $\mathbf{K}$의 값이 너무 커져서, 초기 오차를 잡기 위해 카트 모터에 비현실적으로 거대한 힘($u$)을 요구하게 된다. 움직임이 너무 거칠어지고(Jerky), 선형화 범위를 벗어나 비선형성 때문에 시스템이 붕괴할 수도 있다.

## 마무리하며

정리해보면, **제어란 "시스템의 미분방정식을 지배하는 행렬의 Eigenvalue를, 선형대수학의 조작을 통해 원하는 위치(Pole)로 옮겨 심는 작업"**이다.

칠판 위에서만 존재하던 미분방정식의 $e^{\lambda t}$ 수식이, 위태로운 진자를 똑바로 세우고 자율주행차를 차선 안에 유지시키는 물리적인 힘으로 치환되는 과정. 이것이 바로 선형대수학과 미분방정식을 배운 우리가 제어 공학에 매력을 느낄 수밖에 없는 이유이다.

하지만 마지막에 보았듯, 무작정 고유값을 멀리 보낸다고 능사는 아니다. "제어 에너지를 적게 쓰면서도 가장 빠르게 안정화되는 **최적의 Eigenvalue 위치**는 어디일까?"
이 질문에 대한 해답이 바로 다음 포스팅에서 다룰 **LQR (Linear Quadratic Regulator)** 최적 제어이다.

# 참고 문헌

* [1] Data-Driven Science and Engineering: Machine Learning, Dynamical Systems, and Control, Steven L. Brunton and J. Nathan Kutz (link)[https://databookuw.com/]

---

*본 포스팅은 워싱턴 대학교 Steve Brunton 교수의 'Control Bootcamp' 유튜브 강의를 참고하여 작성되었습니다.*