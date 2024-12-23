---
title: 체르노프 유계(Chernoff Bound)
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20220913
tags: 통계학
lang: ko
---

# prerequisites

본 포스트를 잘 이해하기 위해선 아래의 내용에 대해 알고 오는 것이 좋습니다.

* [마르코프 부등식과 체비셰프 부등식](https://angeloyeo.github.io/2022/09/12/Markov_Chebyshev_Inequality.html)

# 증명

Chernoff 부등식은 Lower-tail 버전과 Upper-tail 버전의 형태가 다르다. 아래에서는 증명 과정을 소개하고자 한다.

## Lower-Tail Chernoff Bound

$X$가 $N$ 개의 독립적인 랜덤변수의 합이라고 하자. 또, 이때 이 랜덤 변수들은 베르누이 분포를 따르며 $p_i$의 확률로 1의 값을 갖는다고 하자.

$$X = \sum_{i=1}^{N}X_i$$

[//]:# (식 1)

이 때, 임의의 $\delta\in (0, 1)$에 대해 다음이 성립한다.

$$P(X \lt (1-\delta)E[X]) \lt e^{-E[X]\cdot \delta^2/2}$$

[//]:# (식 2)

여기서 $e$는 자연로그의 밑이다.

(증명)

우선 아래의 부등식이 성립한다는 것을 증명하자.

$$P(X \lt (1-\delta) E[X]) \lt \left(\frac{e^{-\delta}}{(1-\delta)^{(1-\delta)}}\right)^{E[X]}$$

[//]:# (식 3)

이를 증명하기 위해 임의의 매개변수 $t>0$을 도입하자. 이 $t$를 이용해 우리는 $X$에 대한 식을 $e^{-tX}$에 대한 식으로 변환할 것이다. 이 방법은 적률생성함수(moment generating function)을 활용하는 원리와 유사하게 볼 수 있는데, 원래의 $X$ domain에서 풀기 어려운 문제를 매개변수 $t$ 도메인으로 옮겨 문제를 상대적으로 쉽게 풀기 위함이라고 볼 수도 있다.

식 (3)을 증명하기 위해 [마르코프 부등식](https://angeloyeo.github.io/2022/09/12/Markov_Chebyshev_Inequality.html)의 식을 $X$ 대신 $e^{-tX}$에 맞춰 수정하자. 원래의 마르코프 부등식은 아래와 같다.

$$P(X\lt \alpha) \leq \frac{E[X]}{\alpha}$$

[//]:# (식 4)

여기서 우변을 바꿔주면,

$$P(X\lt\alpha) \leq \frac{E[e^{-tX}]}{e^{-t\alpha}}$$

[//]:# (식 5)

가 된다.

식 (5)를 식 (2)의 좌변에 맞춰 적용하면 결과는 아래와 같다. 여기서 $\alpha = (1-\delta)E[X]$이므로,

$$\Rightarrow P(X\lt (1-\delta)E[X]) \leq \frac{E[e^{-tX}]}{e^{-t(1-\delta)E[X]}}$$

[//]:# (식 6)

이 성립한다. 또 $X$를 구성하고 있는 $X_i$ 들은 독립적으로 발생한 사건이다. 위 식의 우변의 분자를 보면,

$$E[e^{-tX}]=E[e^{-t\cdot\sum_{i}X_i}]=E[e^{-t(X_1+X_2+\cdots+X_N)}]\notag$$

$$=E[e^{-tX_1}\cdot e^{-tX_2}\cdot e^{-tX_3}\cdot \cdots \cdot e^{-t X_N}]$$

[//]:# (식 7)

과 같이 쓸 수 있는데, 독립 랜덤 변수의 곱의 기댓값은 기댓값들의 곱이므로 위 식은 아래와 같이 고쳐쓸 수 있다.

$$\Rightarrow E[e^{-tX_1}\cdot e^{-tX_2}\cdots e^{-tX_N}]=\prod_{i=1}^{N}E[e^{-tX_i}]$$

[//]:# (식 8)

위 식의 $E[e^{-tX_i}]$를 자세히 보면 베르누이 분포를 따르는 시행 $X_i$에 대한 변환식 $e^{-tX_i}$의 기댓값임을 알 수 있다. $X_i$는 $(1-p_i)$ 혹은 $p_i$의 확률로 0 또는 1의 값을 가지므로 $X_i$의 기댓값은

$$E[X_i] = (1-p_i)\cdot 0 + p_i \cdot 1 = p_i$$

이며, $e^{-tX_i}$의 기댓값은 

$$E[e^{-tX_i}]=(1-p_i)e^{-t\cdot 0}+p_i e^{-t\cdot 1}\notag$$

$$=1-p_i + p_i e^{-t}=1+p_i(e^{-t}-1)\notag$$

$$ = 1+E[X_i](e^{-t}-1)$$

임을 알 수 있다. 또한 위 식의 마지막 결과물은 $\exp(E[X_i]\cdot(e^{-t}-1))$의 테일러 급수 두 항과 일치한다는 점을 고려하면 다음이 성립함을 알 수 있다.

$$E[e^{-tX_i}]=1+E[X_i](e^{-t}-1) \lt e^{E[X_i](e^{-t}-1)}$$

[//]:# (식 11)

식 (11)을 식 (8)에 다시 대입하면,

$$\prod_{i=1}^{N}E[e^{-tX_i}]\lt\prod_{i=1}^{N}e^{E[X_i](e^{-t}-1)}$$

이 성립하게 됨을 알 수 있는데, 위 식의 우변을 또 다시 쓰면,

$$\prod_{i=1}^{N}\exp(E[X_i](e^{-t}-1))=\exp\left(\sum_{i=1}^{N}E[X_i]\cdot (e^{-t}-1)\right)\notag$$

$$=\exp\left(E[X](e^{-t}-1)\right)$$

[//]:# (식 13)

이다. 따라서 식 (13)의 결과를 식 (6)에 대입하면 아래와 같은 식을 얻을 수 있다.

$$P(X<(1-\delta)E[X]) \leq \frac{\exp\left(E[X](e^{-t}-1)\right)}{\exp\left(-t(1-\delta)E[X]\right)}$$

[//]:# (식 14)

위 식은 어떤 $t>0$에 대해서라도 성립하는 식이다. 이제는 식 (14)가 최대한 tight한 boundary에 대해 성립할 수 있도록 식 (14)의 최소값을 내주는 $t=t^\ast$ 값을 찾자. 이 과정은 식 (14)를 미분하고 미분한 값이 $0$이 되는 $t^\ast$를 찾음으로써 해결할 수 있다. 

식 (14)의 우변에 지수법칙을 적용하여 한줄로 쓰면 다음과 같다.

$$\exp(E[X](e^{-t}-1)+t(1-\delta)E[X])$$

[//]:# (식 15)

이를 조금만 더 정리하고 $f(t)$라고 이름 붙이자.

$$f(t) = \exp\left(E[X]e^{-t}-E[X]+tE[X]-t\delta E[X]\right)\notag$$

$$=\exp\left(E[X](e^{-t}+t-t\delta -1)\right)$$

[//]:# (식 16)

이제 $f(t)$를 $t$에 대해 미분하면,

$$f'(t) = \exp\left(E[X](e^{-t}+t-t\delta -1)\right)(E[X])(e^{-t}+1-\delta)$$

[//]:# (식 17)

임을 알 수 있다. 식 (17)에서 맨 앞의 $\exp()$ 함수는 항상 양수이며 $E[X]$ 역시 양수이다. 따라서, 가장 오른쪽의 괄호 안의 값만 0이 되도록 하면 $t=t^\ast$를 찾을 수 있다.

따라서, 

$$e^{-t}+1-\delta = 0$$

을 만족하는 $t=t^\ast$는

$$t=t^\ast = \ln\left(\frac{1}{1-\delta}\right)$$

[//]:# (식 19)

이다.

식 (19)를 식 (14)에 대입하면 식 (3)을 얻을 수 있게 된다. 식 (19)를 식 (14)에 대입하면,

$$\Rightarrow P(X<(1-\delta) E[X])\leq 
  \frac{\exp\left(E[X]\left(e^{-\ln\left(1/(1-\delta)\right)}-1\right)\right)}{\exp\left(-\ln(1/(1-\delta))(1-\delta)E[X]\right)}$$

[//]:# (식 20)

여기서 우변만 보면 다음과 같다.

$$\text{(우변)}\Rightarrow \frac{\exp(E[X](1-\delta -1))}{\exp(-(1-\delta)E[X]\ln\left(1/(1-\delta)\right))}$$

[//]:# (식 21)

$$=\frac{\exp(E[X](-\delta))}{\exp(\ln(1-\delta)^{(1-\delta E[X])})}=\frac{\exp(-\delta E[X])}{(1-\delta)^{(1-\delta)E[X]}}$$

[//]:# (식 22)

$$=\left(\frac{e^{-\delta}}{(1-\delta)^{(1-\delta)}}\right)^{E[X]}$$

[//]:# (식 23)

한편, 

$$\ln(1-x)=-x-\frac{x^2}{2}-\frac{x^3}{3}\cdots = -\sum_{i=1}^{N}\frac{x^n}{n}$$

[//]:# (식 24)

이므로,

$$(1-\delta)\ln(1-\delta) = - (1-\delta)\delta - (1-\delta)\frac{\delta^2}{2}\cdots\notag$$

$$=-\delta+\delta^2-\frac{\delta^2}{2}+\frac{\delta^3}{2}\cdots\notag$$

$$=-\delta+\delta^2/2+\cdots$$

[//]:# (식 25)

과 같다. 따라서 

$$(1-\delta)\ln(1-\delta) \gt -\delta +\frac{\delta^2}{2}$$

가 성립하며 로그의 성질에 따라

$$(1-\delta)^{(1-\delta)}\gt\exp\left(-\delta + \frac{\delta^2}{2}\right)$$

[//]:# (식 27)

가 성립함을 알 수 있다.

따라서, 식 (27)을 식(23)에 대입하면,

$$\left(\frac{e^{-\delta}}{(1-\delta)^{(1-\delta)}}\right)^{E[X]}\lt \left(\frac{e^{-\delta}}{e^{(-\delta+\delta^2/2)}}\right)^{E[X]}$$

$$\Rightarrow \left(\frac{e^{-\delta}}{(1-\delta)^{(1-\delta)}}\right)^{E[X]}\lt \left(e^{-\delta^2/2}\right)^{E[X]}$$

이다. 따라서, 이 결과를 식 (20)과 식 (23)에 대입하면,

$$\Rightarrow P(X\lt (1-\delta)E[X])\lt \exp(-E[X]\delta^2/2)$$

[//]:# (식 30)

이다.

(증명 끝)

## Upper-Tail Chernoff Bound

Upper-Tail 부분에 대한 증명은 Lower-tail에 대한 증명과 거의 유사한 방식으로 진행된다. 따라서 Upper-tail에 대한 증명은 더 빠르게 진행되며 빠르게 넘어간 부분은 Lower-tail 파트 증명에서 참고하기 바란다. 식 (1)과 같은 랜덤변수 $X$에 대해 임의의 $\delta\in(0, 1)$[^1]을 선정하면 다음이 성립한다.

$$P(X\gt(1+\delta)E[X]) \lt e^{-E[X]\cdot \delta^2/3}$$

[//]:# (식 31)

[^1]: 책 Outlier Analysis (Charu C. Aggarwal)에서는 (0, 2e-1)의 범위에서 성립하는 Chernoff Bound를 보여주고 있으나 아직까지 어떻게 증명해야 하는지 잘 모르겠다. 그래서 다른 교과서에서 소개하고 있는 (0, 1) 바운드에 대한 Chernoff Bound를 소개한다.

여기서 $e$는 자연로그의 밑이다.

(증명)

Lower-tail에 대한 증명에서와 마찬가지로 아래를 증명하는 것이 첫 스텝이다.

$$P(X\gt(1+\delta)E[X]) \lt \left(\frac{e^\delta}{(1+\delta)^{(1+\delta)}}\right)^{E[X]}$$

[//]:# (식 32)

이 때 $t>0$인 매개변수를 도입하고 $X$에 대한 식은 $e^tX$에 대한 식으로 바꾸자. 식 (32)의 좌변 정보를 이용하여 마르코프 부등식을 적용하면 아래와 같은 식을 얻을 수 있다.

$$P(X\gt(1+\delta)E[X]) \leq \frac{E[e^{tX}]}{e^{t(1+\delta)E[X]}}$$

[//]:# (식 33)

식 (1)의 $X$의 정의에 따라 식 (33) 우변의 분자만 따로 떼서 생각하면 다음과 같이 쓸 수도 있다는 것을 알 수 있다.

$$E[e^{tX}]=E[e^{t\sum_i X_i}]=E\left[\prod_{i=1}^{N}e^{tX_i}\right]=\prod_{i=1}^{N}E[e^{tX_i}]$$

[//]:# (식 34)

이다.

한편, $X_i$는 베르누이 시행이므로, 식 (9)가 성립하고, $e^{tX_i}$의 기댓값은 다음과 같다.

$$E[e^{tX_i}]=(1-p_i)e^{t\cdot 0}+p_i e^{t\cdot 1}=1-p_i+p_ie^t\notag$$

$$=1+p_i(e^t-1)=1+E[X_i](e^t-1)$$

[//]:# (식 35)

또, 식 (35)의 마지막 식은 $\exp(1+E[X_i]\cdot(e^t-1))$의 테일러 급수 첫 두항과 일치한다. 즉,

$$\exp(x) = 1+\frac{x}{1!}+\frac{x^2}{2}+\cdots$$

[//]:# (식 36)

이므로 $\exp(E[X_i]\cdot(e^t-1))$은 

$$\exp(E[X_i]\cdot(e^t-1))=1+E[X_i](e^t-1)+\frac{1}{2!}(E[X_i](e^t-1))^2+\cdots \notag$$

$$\gt 1+E[X_i](e^t-1)$$

[//]:# (식 37)

이다. 따라서, 식 (34)에서의 마지막 결과값에 대해 다음과 같이 정리할 수 있다.

$$\prod_{i=1}^{N}E[e^{tX_i}]=\prod_{i=1}^{N}(1+E[X](e^t-1))<\prod_{i=1}^{N}\exp(E[X_i](e^t-1))$$

[//]:# (식 38)

한편, 

$$\prod_{i=1}^{N}\exp(E[X_i](e^t-1))=\exp\left(E\left[\sum_{i=1}^{N}X_i\right](e^t-1)\right)=\exp(E[X](e^t-1))$$

[//]:# (식 39)

이므로 위 결과를 식 (33)에 대입하면,

$$P(X\gt(1+\delta)E[X])\leq \frac{\exp(E[X](e^t-1))}{e^{t(1+\delta)E[X]}}$$

[//]:# (식 40)

임을 알 수 있다. Lower-tail boundary에서와 마찬가지로 식 (40)의 우변을 미분하여, 미분 계수를 0으로 만들어줄 수 있는 가장 tight한 $t=t^\ast$를 찾으면 다음과 같다.

$$t^\ast=\ln(1+\delta)$$

[//]:# (식 41)

식 (41)을 식 (40)에 대입하면 식 (32)를 얻을 수 있게 된다.

$$P(X\gt(1+\delta)E[X]) \leq \frac{\exp(E[X](e^{\ln(1+\delta)}-1))}{\exp((1+\delta)E[X]\ln(1+\delta))}$$

[//]:# (식 42)

$$\Rightarrow P(X\gt(1+\delta)E[X]) \leq \frac{\exp(E[X]\delta)}{(1+\delta)^{(1+\delta)E[X]}}$$

[//]:# (식 43)

$$\Rightarrow P(X\gt(1+\delta)E[X]) \leq \left(\frac{e^\delta}{(1+\delta)^{(1+\delta)}}\right)^{E[X]}$$

[//]:# (식 44)

식 (44)로부터 식 (31)을 증명하기 위해선 아래의 수식이 사실인지 확인하면 된다.

$$\frac{e^\delta}{(1+\delta)^{(1+\delta)}}<e^{-\mu^2/3}$$

[//]:# (식 45)

식 (45)의 양변에 로그를 취하면 아래와 같은 식을 얻을 수 있다.

$$f(\delta) = \delta - (1+\delta)\ln (1+\delta) + \frac{\delta^2}{3}< 0$$

[//]:# (식 46)

$f(\delta)$의 미분계수를 구하면 아래와 같다.

$$f'(\delta) = 1-\frac{1+\delta}{1+\delta}-\ln(1+\delta)+\frac{2}{3}\delta = -\ln(1+\delta)+\frac{2}{3}\delta$$

$$f''(\delta) = - \frac{1}{1+\delta}+\frac{2}{3}$$

여기서 2계 도함수로부터 알 수 있는 것은 아래와 같다.

$$\begin{cases}f''(\delta)\lt 0\text{ for } 0\leq \delta \lt 1/2 \\ f''(\delta) > 0 \text{ for } \delta >1/2\end{cases}$$

다시 말해, $f'(\delta)$는 $(0,1)$ 구간에서 처음에는 감소하다가 증가하게 되는 형태를 띈다는 것이다. 또한, 1계 도함수 식을 보면 $f'(0)=0$이고 $f'(1)\lt 0$이라는 사실이다. 따라서, $(0,1)$ 구간에서 $f'(\delta)\lt 0$이라는 사실을 알 수 있다. 마지막으로 $f(0)=0$이므로 $(0,1)$ 구간에서 $f(\delta)$는 항상 음수임을 알 수 있다.

그러므로, 식 (46)은 사실임을 알 수 있고 식 (31) 또한 성립하는 것이다.

(증명 끝)

# Reference

* Outlier Analysis (2nd e.d), Charu C. Aggarwal, Springer
* Probability and Computing (2nd e.d.), Michael Mitzenmacher and Eli Upfal, Cambridge University Press