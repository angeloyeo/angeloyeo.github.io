---
title: Euler-Lagrange 방정식 (변분법)
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20260315
tags: 변분법 미분방정식
lang: ko
---

빛이 공기를 통과하다가 빛을 통과할 때 빛은 굴절 되어 들어갑니다. 매질에 따라 빛의 속도가 다르다보니 최단 시간으로 가기 위한 경로를 택한 것이라고 합니다. 이걸 페르마의 원리라고 하더라구요. 자연은 어떻게 최적의 경로를 찾는지 참으로 신기합니다. 이번 시간에는 수학적으로 최적의 경로를 찾는 방법 중 하나인 오일러 라그랑주 방정식에 대해 알아보겠습니다.

# 1. 도입: 함수를 입력으로 받는 함수, '범함수(Functional)'

우리는 보통 $y = f(x)$처럼 **숫자**를 넣으면 **숫자**가 나오는 함수에 익숙하다. 하지만 세상에는 조금 더 거대한 개념의 함수가 필요할 때가 있다.

예를 들어, "두 점 사이를 잇는 수많은 곡선 중 가장 짧은 것은 무엇인가?"라는 질문을 던져봅시다. 여기서 우리가 넣는 재료는 '숫자'가 아니라 **'곡선(함수) 그 자체'** 이다. 그리고 그 결과값은 '곡선의 길이'라는 **'하나의 숫자'**로 나온다.

이렇게 **함수를 입력받아 실수 값을 내놓는 함수**를 우리는 **범함수(Functional)** 라고 부른다. 범함수 $J$ 를 상정하여 아래처럼 표현해볼 수 있다.

$$J[y] = \int_{x_1}^{x_2} L(x, y, y') dx$$

여기서 $L$은 우리가 최적화하고 싶은 시스템의 상태를 담은 '알맹이'를 말하는 것이며 라그랑지안(Lagrangian)이라고 부른다.

(참고로 범함수의 개념은 [행벡터의 의미와 벡터의 내적](https://angeloyeo.github.io/2020/09/09/row_vector_and_inner_product.html) 편에서도 다룬 적 있다. 행 벡터 자체가 범함수의 기능을 한다고 설명하였다. 혹시 궁금하다면 참고.)

# 2. 사고의 전환: "정답 곡선이 이미 있다고 치자"

이제 우리의 목표는 범함수 $J$를 최소(혹은 최대)로 만드는 마법 같은 곡선 $y(x)$를 찾는 것이다. 여기서 변분법의 천재적인 **사고 흐름**이 시작된다.

**"만약 우리가 찾은 $y(x)$가 진짜 정답이라면, 그 옆으로 아주 살짝 비껴간 경로는 정답보다 효율이 떨어질 것이다."**

이 아이디어를 수학적으로 구현하기 위해, 정답 곡선 $y(x)$에 아주 미세한 변동(Variation)인 $\eta(x)$를 섞어보자.

* **새로운 경로:** $Y(x) = y(x) + \epsilon \eta(x)$
* $\epsilon$은 조절 나사임. $\epsilon=0$이면 정답이고, 조금이라도 커지면 정답에서 벗어남.

# 3. 오일러-라그랑주 방정식의 유도 과정

우리가 가정한 $y(x)$가 정말 최적의 경로라면, $\epsilon = 0$일 때 $J(\epsilon)$은 극값을 가져야 한다. 즉, $\epsilon$에 대해 미분했을 때 $0$이 되어야 한다. (어차피 같은 말이잖아!? 라고 생각할 수 있지만, 전개를 따라가보면 전혀 다른 방식으로 같은 현상을 표현하게 된다는 것을 알 수 있다.)

$$\left. \frac{dJ}{d\epsilon} \right|_{\epsilon=0} = 0$$

이것이 바로 변분법의 핵심 원리이다. 이제 우리는 이 식을 풀기만 하면 된다.

$$\frac{dJ}{d\epsilon} = \frac{d}{d\epsilon}\int_{x_1}^{x_2}  L(x, Y, Y') dx$$

적분 기호 안으로 미분을 밀어 넣으면(라이프니츠 법칙), **연쇄 법칙(Chain Rule)** 에 의해 다음과 같이 전개된다.

$$\Rightarrow\int_{x_1}^{x_2} \left( \frac{\partial L}{\partial Y} \frac{\partial Y}{\partial \epsilon} + \frac{\partial L}{\partial Y'} \frac{\partial Y'}{\partial \epsilon} \right) dx = 0$$

위 식에서 변수 치환을 통해 $\frac{\partial Y}{\partial \epsilon}$과 $\frac{\partial Y'}{\partial \epsilon}$을 계산해 보자.

* $Y = y + \epsilon \eta \implies \frac{\partial Y}{\partial \epsilon} = \eta(x)$
* $Y' = y' + \epsilon \eta' \implies \frac{\partial Y'}{\partial \epsilon} = \eta'(x)$

이를 대입하고, 우리가 찾고자 하는 $\epsilon=0$ 지점을 적용하면(즉, $Y \to y, Y' \to y'$):


$$\int_{x_1}^{x_2} \left( \frac{\partial L}{\partial y} \eta + \frac{\partial L}{\partial y'} \eta' \right) dx = 0$$

두 번째 항에 있는 $\eta'(x)$를 $\eta(x)$로 바꾸기 위해 **부분 적분**($\int udv = uv - \int vdu$)을 수행하자.

* $u = \frac{\partial L}{\partial y'}$, $dv = \eta'(x)dx$ 로 두면:

$$\int_{x_1}^{x_2} \frac{\partial L}{\partial y'} \eta'(x)  dx = \left[ \frac{\partial L}{\partial y'} \eta(x) \right]_{x_1}^{x_2} - \int_{x_1}^{x_2} \frac{d}{dx} \left( \frac{\partial L}{\partial y'} \right) \eta(x)  dx$$

우리는 처음에 양 끝점을 고정했기 때문에 $\eta(x_1) = 0, \eta(x_2) = 0$이다. 따라서 대괄호 항($uv$ 파트)은 **0이 되어 사라진다.** 

이제 남은 항들을 다시 합쳐서 $\eta(x)$로 묶어주자.

$$\int_{x_1}^{x_2} \left[ \frac{\partial L}{\partial y} - \frac{d}{dx} \left( \frac{\partial L}{\partial y'} \right) \right] \eta(x)  dx = 0$$

이 식이 **어떠한** $\eta(x)$에 대해서도 항상 성립하려면, 적분 기호 안의 대괄호 값이 반드시 $0$이어야 한다. 이를 정리하여 오릴러 라그랑주 방정식 (Euler-Lagrange Equation)이라고 부른다.

**The Euler-Lagrange Equation:**

$$\frac{\partial L}{\partial y} - \frac{d}{dx} \left( \frac{\partial L}{\partial y'} \right) = 0$$


이 짧은 방정식이 바로 **"전체적인(Global) 최적 경로를 찾기 위해, 곡선의 매 순간(Local)이 지켜야 할 물리 법칙"** 을 말해준다.

---

# 4. 예시

$L$이 무엇인지, 그리고 오일러 라그랑주 방정식이 말하는 최소 작용의 원리 (principle of least action)이 무엇인지 좀 더 잘 이해하기 위해 예시를 들어보자.

$L$은 우리가 최적화하고 싶은 시스템의 상태를 담은 '알맹이'라고 말했다. 예를 들어 $x$ 방향으로 이동하고 있는 물체를 생각해보자. 이 경우 라그랑지안 $L$은 운동에너지에서 포텐셜 에너지를 빼준 것과 같다.

$$L = \frac{1}{2}mv^2-U(x)$$

이 $L$을 오일러 라그랑주 방정식에 넣으면 어떻게 될까? 식 (8)을 현재 겪고 있는 시간($t$)에 따른 위치 ($x$)의 변화로 바꿔 써주면 아래와 같다.

$$\frac{d}{dt}\frac{\partial L}{\partial \dot x}=\frac{\partial L}{\partial x}$$

식 (10)의 좌변에 있는 $\dot x$는 속도 $v$로 써줄 수 있으므로,

$$\frac{\partial L}{\partial \dot x} = \frac{\partial L}{\partial v}=mv$$

이다. 한편, 식 (10)의 우변을 보면,

$$\frac{\partial L}{\partial x}=-U'(x)$$

이므로 운동 에너지와 포텐셜 에너지 차에 관한 $L$에 대한 식은 아래와 같이 정리된다.

$$\Rightarrow \frac{d}{dt}(mv)=-U'(x)$$

$$\Rightarrow m\frac{d}{dt}(v)=-U'(x)$$

Potential의 negative gradient가 힘과 같으므로, 이 식은 바로 뉴턴 제 2법칙인 가속도의 법칙이며 소위 $F=ma$로 알고 있는 것과 같다.

### 마치며

변분법은 "결과가 최소가 되려면 과정이 어떠해야 하는가?"를 묻는 학문이다. 이 방정식 덕분에 우리는 뉴턴 역학을 에너지 관점에서 재해석할 수 있게 되었고, 오늘날 로봇의 복잡한 움직임을 제어하거나 인공지능의 오차를 줄이는 데까지 이 원리를 사용하고 있다.