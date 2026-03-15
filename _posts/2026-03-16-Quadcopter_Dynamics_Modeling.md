---
title: 쿼드콥터의 동역학 모델링 (오일러-라그랑주 방정식 기반)
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20260316
tags: 변분법 미분방정식
lang: ko
---

쿼드콥터는 어떻게 움직일까? 오일러-라그랑주로 풀어보는 동역학 모델링

쿼드콥터를 제어하려면 먼저 이 기체가 어떤 물리 법칙에 따라 움직이는지 알아야 합니다. 단순히 "모터를 돌리면 뜬다"를 넘어, "모터 속도를 얼마나 조절해야 내가 원하는 위치로 정확히 갈까?"를 계산하기 위한 **수학적 설계도(모델)**를 그려보는 과정입니다. 오늘은 Raffo 등의 논문과 MATLAB Symbolic Math Toolbox의 문서를  바탕으로 그 흐름을 따라가 보겠습니다.

# Prerequisites

이 포스팅을 더 잘 이해하기 위해선 아래의 내용을 이해하고 오는 것이 좋습니다.

* [Euler-Lagrange 방정식 (변분법)](https://angeloyeo.github.io/2026/03/15/Euler_Lagrange.html)

# 1. 질문의 시작: "쿼드콥터의 상태를 어떻게 정의할까?"

모델링을 하려면 먼저 무엇을 관찰할지 정해야 한다. 우선 [1]의 논문에서 우리가 보고자하는 쿼드콥터의 geometry는 아래 [2]의 그림처럼 정의하고 있다.

![](../pics/2026-03-16-Quadcopter_Dynamics_Modeling/pic1.png)

쿼드콥터는 공간에서 자유롭게 움직이므로 **6자유도**를 가진다.

*   **위치 ($\xi$):** 지구 기준에서 어디에 있는가? $(x, y, z)^T$.
*   **자세 ($\eta$):** 지구 기준에서 얼마나 기울어져 있는가? 롤, 피치, 요 $(\phi, \theta, \psi)^T$.

여기에 각각의 속도까지 더하면 총 **12개의 상태 변수**가 우리 시스템의 주인공이 된다.

$$(x, y, z, \phi, \theta, \psi, \dot x, \dot y, \dot z, \dot \phi, \dot \theta, \dot \psi)^T % 식 (1)$$

추가로 쿼드콥터의 모션을 기술하기 위해 아래와 같이 파라미터들을 정의하도록 하자.

* $(u_1, u_2, u_3, u_4) = (\omega_1^2, \omega_2^2, \omega_3^2, \omega_4^2)$ 이는 각 로터의 각속도의 제곱을 의미한다.
* $(I_{xx}, I_{yy}, I_{zz})$ 이는 body frame의 관성 행렬의 대각 성분을 의미한다.
* $(k,l,m,b,g)$는 각각 추력 계수, 무게 중심으로부터 로터까지의 거리, 쿼드콥터의 질량, 항력 계수, 그리고 중력을 의미한다.
* $f_\xi$는 4개의 프로펠러가 합쳐서 만들어내는 전체 추력과 공기 역학적 방해를 포함하는 병진력을 의미한다.
* $\tau_\eta$는 기체를 회전시키기 위해 각 모터의 속도 차이로 만들어내는 롤, 피치, 요 방향의 회전력을 의미한다.

# 2. 왜 오일러-라그랑주인가?

보통 고전 역학에서는 $F=ma$를 쓰지만, 쿼드콥터처럼 축들이 복잡하게 얽혀 있는 시스템은 **에너지** 관점에서 접근하는 것이 훨씬 깔끔하다. [Euler-Lagrange 방정식 (변분법)](https://angeloyeo.github.io/2026/03/15/Euler_Lagrange.html) 편에서 본 것 처럼 Euler-Lagrange 방정식은 라그랑지안 $L$을 정의할 수 있다면 (나중에 정의할 것임) 아래와 같은 관계로 표현할 수 있다.

$$\frac{d}{dt}\left(\frac{\partial L}{\partial \dot q_i}\right)-\frac{\partial L}{\partial q_i}=Q_i % 식 (2)$$

여기서 $Q_i$는 시스템의 일반화된 힘 (generalized force)이다. 그런데 분명 [Euler-Lagrange 방정식 (변분법)](https://angeloyeo.github.io/2026/03/15/Euler_Lagrange.html) 편에서는 위 식의 우변이 항상 0이 되는 것 처럼 얘기했는데, 왜 0이 아니라 $Q_i$가 붙을까? 그것은 쿼드콥터가 작동하는 시스템은 가만히 내버려두는 보존계가 아니라 외부 힘(추력, 공기 저항, 토크 등)이 작용하는 비보존계이기 때문이다. 아무래도 우리가 모터를 돌려서 가만히 두면 떨어지는 쿼드콥터를 원하는 경로로 이동시켜야 하기 때문에 이런 가정을 하는 것은 굉장히 자연스럽다고 할 수 있다.

이제 이 원리를 따라 '에너지(라그랑지안, $L$)'를 먼저 구해보자.

## (1) 에너지 지도 그리기 (라그랑지안 정의)

라그랑지안($L$)은 **운동 에너지($E_c$)에서 위치 에너지($E_p$)를 뺀 값** 이다.

### 병진 운동 에너지

질량($m$)이 속도($\dot{\xi}$)로 이동할 때 생기는 에너지. 익히 알고 있는 $1/2mv^2$을 벡터 $\dot\xi$의 내적을 이용해서 쓰면 

$$E_{cTra}=\frac{1}{2}m\dot\xi^T\dot\xi % 식 (3)$$

가 된다.

### 회전 운동 에너지

기체가 회전할 때 생기는 에너지. 

쿼드콥터 기체 자체의 회전 운동 에너지는 기체 기준 각속도 ($\omega$)를 이용해 기술하면 아래와 같다.

$$E_{cRot}=\frac{1}{2}\omega^TI\omega % 식 (4)$$

여기서 $I$는 기체 프리엠이서 정의된 대각 관성 행렬이다.

하지만 우리는 시스템을 오일러각 $\eta$로 제어하고 싶을 것이다. (기체의 센서가 느끼는 각속도를 우리가 알고 있기 보다는 관성계에서 본 각도인 오일러각을 통해 생각하는 것이 더 자연스럽기 때문이다.) 그러므로 $\omega$를 $\dot\eta$로 변환시키기 위해 아래와 같은 관계를 활용할 수 있다.

$$\dot\eta=W_\eta^{-1}\omega \\ \begin{bmatrix}\dot\phi\\ \dot\theta \\ \dot\psi\end{bmatrix}=\begin{bmatrix}1 && \sin\psi \tan\theta && \cos\phi \tan\theta \\ 0 && \cos\phi && -\sin\phi \\ 0 && \sin\phi\sec\theta  && \cos\phi \sec\theta\end{bmatrix}\begin{bmatrix}p \\q \\ r\end{bmatrix} % 식 (5)$$

여기서 $\eta = [\phi, \theta, \psi]^T$이고 $\omega = [p, q, r]^T$이며, $p, q, r$은 각각 기체 고정 프레임에서의 각속도이다.

따라서, 

$$E_{cRot}=\frac{1}{2}(W_\eta \dot\eta)^TI(W_\eta\dot\eta)=\frac{1}{2}\dot\eta^T(W_\eta^TIW_\eta)\dot\eta % 식 (6)$$

와 같이 회전 운동 에너지를 오일러각 $\eta$로 표현해줄 수 있으며, 이 때 괄호 안의 부분인 $W_\eta^TIW_\eta$를 새로운 관성 행렬 $J(\eta)$로 정의하여 쓰면

$$\Rightarrow E_{cRot}=\frac{1}{2}\dot\eta^TJ\dot\eta % 식 (7)$$

가 된다.

이때 중요한 점은 기체 내부 센서가 느끼는 회전($\omega$)을 우리가 관찰하는 각도 변화율($\dot{\eta}$)로 변환해 기술했다는 점이다. 또, 이를 위해 **변환 행렬($W_\eta$)** 을 사용해 지구 기준 관성 행렬($J$)을 만들었다는 점에 주목하도록 하자.

### 위치 에너지

중력에 의해 높이($z$)에 따라 생기는 에너지 

$$E_P= mgz % 식 (8)$$

### 최종 라그랑지안

최종적으로 라그랑지안은 운동에너지 $E_C$에서 포텐셜 에너지 $E_P$를 빼준 것과 같으며 아래와 같이 기술할 수 있다.

$$L=E_{cTra}+E_{cRot}-E_P=\frac{1}{2}m\dot\xi^T\dot\xi+\frac{1}{2}\dot\eta^TJ\dot\eta-mgz % 식 (9)$$

## (2) 병진 운동 도출 - "우리가 아는 그 F=ma"

이제 식 (9)를 위치($\xi$)에 대해 식 (2)의 오일러-라그랑주 미분을 수행하면 병진 운동이 어떠해야하는지 도출할 수 있다. 이 때 병진 운동이 말하는 것은 "기체의 높이를 변화시키는 건 무엇일까?" 라고도 할 수 있다. 식 (2)의 $q_i$에 위치 $\xi$를 대입해 주고, $Q$를 알짜힘 $f_\xi$로 생각해준다면 아래와 같이 식 (2)를 변형시킬 수 있다.

$$\text{식 (2)}\Rightarrow \frac{d}{dt}\left(\frac{\partial L}{\partial \dot \xi}\right)-\frac{\partial L}{\partial \xi}=f_\xi % 식 (10)$$

여기서 $f_\xi$는 병진운동과 관련된 힘들을 모아둔 것이다. 전개를 계속해보면,

$$\Rightarrow \frac{d}{dt}m\dot{\xi}-(-mge_3)=f_\xi % 식 (11)$$

$$m\ddot{\xi}+mge_3=f_\xi % 식 (12)$$

여기서 $e_3$은 z 방향 단위 벡터이다.

* 결과: $m\ddot{\xi} + mge_3= f_\xi  $.

결과적으로 $F=ma$가 좀 복잡하게 써진 것을 얻었다고 볼 수 있다.

## (3) 회전 운동 도출 - "진짜 복잡한 건 지금부터"

이제 식 (9)를 자세($\eta$)에 대해 식 (2)의 오일러-라그랑주 미분을 수행한다. 여기서 쿼드콥터 모델링의 꽃인 **관성항**과 **코리올리 항**이 튀어나온다.

$$\text{식 (2)} \Rightarrow \frac{d}{dt}\left(\frac{\partial L}{\partial \dot \eta}\right)-\frac{\partial L}{\partial \eta}=\tau_\eta % 식 (13)$$

여기서 $\tau_\eta$는 기체를 회전시키기 위해 각 모터의 속도 차이로 만들어내는 롤, 피치, 요 방향의 회전력을 의미한다. 전개를 계속해보면,

$$\frac{d}{dt}\left(J\dot\eta\right)=J(\eta)\ddot\eta+\dot J(\eta, \dot\eta)\dot\eta % 식 (14)$$

이고

$$\frac{\partial L}{\partial \eta}=\frac{1}{2}\frac{\partial}{\partial \eta}\left(\dot\eta^TJ(\eta)\dot\eta\right) % 식 (15)$$

이다. 따라서, 식 (13)은 아래와 같이 쓸 수 있는 것이다.

$$\text{식 (13)}\Rightarrow J(\eta)\ddot\eta+\dot J(\eta, \dot\eta)\dot\eta-\frac{1}{2}\frac{\partial}{\partial \eta}\left(\dot\eta^TJ(\eta)\dot\eta\right) % 식 (16)$$

여기서 우변의 두 번째, 세 번째 항을 $\dot\eta$로 묶으면,

$$\Rightarrow J(\eta)\ddot\eta+\left(\dot J(\eta, \dot\eta) - \frac{1}{2} \frac{\partial}{\partial \eta}\dot\eta^TJ(\eta)\right)\dot\eta % 식 (17)$$

여기서 $J(\eta)$를 $M(\eta)$ 라고 참고문헌 [1]에서 바꿔서 써주고 있고, 큰 괄호로 묶인 것을 Coriolis matrix $C(\eta, \dot\eta)$로 쓰고 있다.

$$\Rightarrow M(\eta)\ddot{\eta} + C(\eta, \dot{\eta})\dot{\eta} = \tau_\eta % 식 (18)$$

*   **왜 $M(\eta)$ 인가? (관성 행렬):** 에너지를 속도로 미분한 후 다시 시간으로 미분할 때 생긴다. 기체가 얼마나 회전에 저항하는지를 나타낸다.
*   **왜 $C(\eta, \dot{\eta})$ 인가? (코리올리 행렬):** 회전 관성이 각도에 따라 변하기 때문에 생긴다. 롤과 피치가 동시에 일어날 때 요(Yaw) 축에 영향을 주는 것과 같은 **축 간의 간섭(자이로스코프 효과 등)**을 수학적으로 담아낸 행렬이다.
*   **우변 ($\tau_\eta$):** 우리가 모터 속도 차이를 이용해 만들어낸 롤, 피치, 요 방향의 **회전력(토크)** 이다.

이를 정리하면,

$$\ddot\eta=M(\eta)^{-1}(\tau_\eta-C(\eta,\dot\eta)\dot\eta) % 식 (19)$$

와 같이 정리할 수 있다.

# 완성된 쿼드콥터의 지도

위의 과정들을 거치면 드디어 12개의 미분 방정식으로 이루어진 **상태 공간 방정식**이 완성됩니다.

1.  **위치 변화:** 현재 속도에 의해 결정됨.
2.  **속도 변화:** 기체의 기울기와 모터 추력($U_1$)에 의해 결정됨 (식 (12))
3.  **각도 변화:** 현재 각속도에 의해 결정됨.
4.  **각속도 변화:** 가해준 토크($\tau$)와 복잡한 회전 간섭($C$)을 관성($M$)으로 나눈 값에 의해 결정됨. (식 (19))

이렇게 도출된 모델은 **MPC(모델 예측 제어)** 와 같은 고급 제어 알고리즘의 '엔진'이 되어, 쿼드콥터가 스스로 미래를 예측하며 비행할 수 있게 만든다.

**마치며:**
결국 쿼드콥터의 모델링은 **"우리가 가해준 에너지($U_1, \tau$)가 어떻게 기체의 운동 에너지로 변환되는가"** 를 추적하는 과정이었다. 수식은 복잡해 보이지만 그 바탕은 $F=ma$가 좀 더 복잡하게 써진 것이라고 볼 수 있다. 이렇게 구한 쿼드콥터의 동적 모델을 이용해서 다음 편에선 쿼드콥터의 MPC를 이해해보고자 한다.

# 참고 문헌

* [1] Raffo, G. V., et al. (2010). "An integral predictive/nonlinear H∞ control structure for a quadrotor helicopter." Automatica.
* [2] Derive Quadrotor Dynamics for Nonlinear Model Predictive Control, MathWorks [(link)](https://kr.mathworks.com/help/symbolic/derive-quadrotor-dynamics-for-nonlinearMPC.html)
