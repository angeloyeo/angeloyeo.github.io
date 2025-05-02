---
title: 고윳값 분해(eigen-value decomposition)
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20201119
tags: 선형대수
lang: ko
---

※ 시각화와 이해의 편의를 도모하기 위해 벡터와 행렬이 정의되는 체(field)는 실수(real number)로 한정함.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A/" width="300" height = "240" frameborder="0"></iframe> <br> 원래의 선형변환 $A$ <br> <iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A_preview/" width="300" height = "240" frameborder="0"></iframe><br>EVD를 이용해 세 개의 단계로 분해한 선형변환 $A$<br><br><b>EVD는 기존의 선형변환을 '돌리기','늘리기','돌리기'의 세 과정으로 분해해서 생각할 수 있게 해준다.</b><br>
</p>
# Prerequisites

해당 post를 잘 이해하기 위해선 아래의 내용에 대해 알고 오시는 것이 좋습니다.

* [행렬과 선형변환](https://angeloyeo.github.io/2019/07/15/Matrix_as_Linear_Transformation.html)
* [고윳값과 고유벡터](https://angeloyeo.github.io/2019/07/17/eigen_vector.html)

# 배경 지식

## 행렬은 벡터들의 모음

$n$개의 $n$차원 벡터 $a_i\in \Bbb{R}^{n \times 1} \text{ for } i = 1, 2, \cdots, n$이 있다고 생각해보자.

그러면 우리는 이 $n$개의 벡터들을 모아 $n\times n$ 차원의 행렬을 구성할 수 있다.

$$A = \begin{bmatrix} | & | & \text{ } & | \\ a_1 & a_2 & \cdots & a_n \\ | & | & \text{ } & | \end{bmatrix}\in \Bbb{R}^{n\times n}$$

[//]:# (식 1)

## 행렬의 각 열의 상수를 인수분해 하는 방법

어떤 $n\times n$ 차원 행렬 $A$가 다음과 같이 구성되어 있다고 생각해보자.

$$A = \begin{bmatrix} 
   | &  | & \text{ } &  | \\ 
  \lambda_1 a_1 & \lambda_2 a_2 & \cdots & \lambda_n a_n \\ 
   | &  | & \text{ } &  | \end{bmatrix}\in \Bbb{R}^{n\times n}$$

[//]:# (식 2)

여기서 $\lambda_i \text{ for } i = 1, 2, \cdots, n$ 은 임의의 실수이다.

그렇다면 식 (2)의 행렬 $A$는 다음과 같이 인수분해 할 수 있다.

$$A = \begin{bmatrix} | & | & \text{ } & | \\ a_1 & a_2 & \cdots & a_n \\ | & | & \text{ } & | \end{bmatrix}
\begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (식 3)

이를 증명하기 위해 아래와 같이 수행해볼 수 있다. 우선 

$$\begin{bmatrix} | \\ a_1 \\ | \end{bmatrix}$$ 

[//]:# (식 4)

과 같이 쓴 벡터를 풀어서 

$$\begin{bmatrix} a_{11} \\ a_{21} \\ \vdots \\ a_{n1} \end{bmatrix}$$

[//]:# (식 5)

과 같이 써서 식 (3)을 아래와 같이 고쳐 쓸 수 있다.

$$A = \begin{bmatrix} a_{11} & a_{12} & \cdots & a_{1n} \\ a_{21} & a_{22} & \cdots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{n1} & a_{n2} & \cdots & a_{nn} \end{bmatrix}
\begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (식 6)

$$ = \begin{bmatrix} \lambda_1a_{11} & \lambda_2a_{12} & \cdots & \lambda_na_{1n} \\ \lambda_1 a_{21} & \lambda_2a_{22} & \cdots & \lambda_n a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ \lambda_1 a_{n1} & \lambda_2 a_{n2} & \cdots & \lambda_n a_{nn} \end{bmatrix}
$$

[//]:# (식 7)

즉, 식 (3)과 식 (2)는 같음을 알 수 있다.

# 고윳값 분해

임의의 $n\times n$ 행렬 $A$에 대해 여러개의 고윳값과 고유벡터를 얻었다고 해보자.

다시 말해, 아래의 식을 만족하는 고윳값과 고유벡터 $n$개 씩을 획득할 수 있다.

$$Av_i = \lambda_i v_i\text{ for } i = 1, 2, \cdots, n$$

[//]:# (식 8)

그러면 우리는 고유벡터들을 모아둔 행렬 $V\in\Bbb{R}^{n\times n}$를 아래와 같이 생각할 수 있다.

$$V = \begin{bmatrix} 
   | &  | & \text{ } &  | \\ 
   v_1 & v_2 & \cdots & v_n \\ 
   | &  | & \text{ } &  | \end{bmatrix}$$

[//]:# (식 9)

이 때, 행렬 $A$와 행렬 $V$의 관계를 식 (8)을을 이용해 한꺼번에 표현하면 다음과 같다.

$$AV =  \begin{bmatrix} 
   | &  | & \text{ } &  | \\ 
  \lambda_1 v_1 & \lambda_2 v_2 & \cdots & \lambda_n v_n \\ 
   | &  | & \text{ } &  | \end{bmatrix}
$$

[//]:# (식 10)

또 고윳값들을 대각성분에 모아둔 행렬 $\Lambda \in \Bbb{R} ^{n \times n}$을 아래와 같이 생각해본다면,

$$\Lambda = \begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \text{ } & \text{ } & \ddots & \text{ } \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (식 11)

식 (2)와 식 (3)에서 본 관계를 이용해 식 (10)을 아래와 같이 쓸 수 있다.

$$식 (10) \Rightarrow AV = V\Lambda$$

[//]:# (식 12)

만약 모든 고유벡터들이 선형독립이라면 식 (12)로부터 아래와 같이 행렬 $A$를 쓸 수 있다.

$$A = V\Lambda V^{-1}$$

[//]:# (식 13)

## 고윳값 분해의 기하학적 의미

고윳값 분해는 기하학적으로 행렬로 표현되는 선형변환은 '돌리고', '늘리고', '돌리고' 하는 세 가지의 과정을 통해 분해할 수 있음을 보여준다.

고윳값 분해의 기하학적 의미를 이해하기 위해 아래와 같은 행렬 A를 고윳값 분해 해보도록 하자.

$$A = \begin{bmatrix}1.2 & -0.5 \\ -1.5 & 1.7\end{bmatrix}$$

우선 행렬 $A$의 선형변환을 시각화하면 아래와 같다.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A/" width="300" height = "240" frameborder="0"></iframe><br>
애니메이션 1. 행렬 A의 선형변환</p>

위 행렬의 고윳값 고유벡터는 아래와 같다.

$$\lambda = 0.5486 \text{ or } 2.3514$$

$$\vec{v}_1 = \begin{bmatrix}0.6089 \\ 0.7933\end{bmatrix}$$

$$\vec{v}_2 = \begin{bmatrix}-0.3983 \\ 0.9172\end{bmatrix}$$

행렬 $A$의 고윳값과 고유벡터를 이용해 식 (14)와 같이 행렬 $A$를 분해하기 위한 행렬들을 써보면 아래와 같다.

$$V = \begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix}$$

$$\Lambda = \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}$$

$$V^{-1} = \begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}$$

그리고 행렬 $A$는 아래와 같이 쪼개서 생각해줄 수 있는 것이다.

$$A = V\Lambda V^{-1} \notag$$

$$\Rightarrow \begin{bmatrix}1.2 & -0.5 \\ -1.5 & 1.7\end{bmatrix}=\begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix} \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}\begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}$$

아래는 고유벡터로 구성된 행렬 $V$의 선형 변환이다.

자세히 보면 행렬 $V$의 선형변환은 회전과 유사한 형태를 보인다. 

왜냐하면 $V$에 들어간 열벡터들은 모두 고유벡터인데 고유벡터는 방향만을 표시하므로 그 길이는 1이 되기 때문이다.

따라서, 원점에서부터 시작하는 길이가 1인 벡터들이 두 개가 서로 다른 방향을 보여주고 있으니 회전 변환과 유사한 역할을 할 수 있다.

다만 변환 후의 기저 벡터의 길이가 모두 같은 것은 아니라는 점과 변환 시 뒤집어 지면서 변환 할 가능성이 있기 때문에 완전히 회전 변환과 같다고는 할 수 없다.

또, V의 변환 후 기저벡터들의 각도가 90도를 이루지 않는다는 점도 주의해야 할 점이다.

$$V = \begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_V/" width="300" height = "240" frameborder="0"></iframe><br> 애니메이션 2. 선형변환 V</p>

아래는 고윳값을 대각성분에 구성한 행렬 $\Lambda$의 선형변환이다. 대각성분만 존재하기 때문에 위 아래 혹은 양 옆으로 늘어나거나 줄어드는 변환만 보이는 것을 알 수 있다.

$$\Lambda = \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_D/" width="300" height = "240" frameborder="0"></iframe><br> 애니메이션 3. 선형변환 $\Lambda$</p>

아래는 고유벡터로 구성된 행렬 $V$의 역행렬 $V^{-1}$의 선형 변환이다.

$V^{-1}$의 선형변환도 $V$와 비슷하게 회전과 유사한 형태를 보인다. 다만 $V$와의 회전 방향과는 반대인 것을 알 수 있다.

$$V^{-1} = \begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_Vinv/" width="300" height = "240" frameborder="0"></iframe> <br> 애니메이션 4. 선형변환 $V^{-1}$</p>

$V^{-1}$, $\Lambda$, $V$의 각각의 선형 변환을 차례대로 적용하면 원래의 선형 변환 $A$와 같은 것을 알 수 있다.

아래의 Applet에서 세 개의 슬라이드는 각각 $V$, $\Lambda$, $V^{-1}$에 해당한다.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A_decomposed/" width="320" height = "265" frameborder="0"></iframe><br> 애니메이션 5. 선형변환 $V$, $\Lambda$, $V^{-1}$을 독립적으로 적용 시켜보자.</p>


# 대칭 행렬의 고윳값 분해

대칭 행렬의 고윳값 분해는 일반 정방 행렬의 고윳값 분해와 비교했을 때 약간 특이한 점이 있다. 대칭 행렬의 경우 고유벡터가 서로 직교하는 성질을 보이기 때문이다.

대칭 행렬은 아래와 같은 성질을 만족하는 행렬이다.

$$A=A^T$$

만약, 행렬 $A$가 식 (13)에서와 같이 고윳값 분해할 수 있다면 아래의 내용이 성립한다.

$$A = V\Lambda V^{-1} = A^T = (V\Lambda V^{-1})^T = (V^{-1})^T\Lambda^TV^T$$

여기서, $\Lambda$는 대각행렬이므로 $\Lambda^T = \Lambda$이고, $(V^{-1})^T = (V^T)^{-1}$이므로 식 (16)는 다음과 같이 쓸 수도 있다.

$$V\Lambda V^{-1} = (V^T)^{-1}\Lambda V^T$$

따라서, 대칭 행렬의 고유벡터를 모아둔 행렬 $V$는 직교행렬이다. 다시 말해 다음이 성립한다.

$$V^T = V^{-1}$$

이고,

$$VV^T = V^TV = I$$

이다.

따라서, 대칭행렬은 아래와 같이 고윳값 분해할 수 있다.

$$A= V\Lambda V^T$$

일반적으로 대칭행렬의 고윳값을 모아둔 행렬은 $V$ 대신에 $Q$로 종종 쓴다.

즉, $A$가 대칭행렬인 경우

$$A = Q\Lambda Q^T$$

로 행렬을 분해할 수 있다.

## 대칭 행렬 고윳값 분해의 기하학적 의미

대칭 행렬 고윳값 분해의 기하학적 의미를 이해하기 위해 아래와 같은 행렬 A를 고윳값 분해 해보도록 하자.

$$A = \begin{bmatrix}2 & 1 \\ 1 & 2\end{bmatrix}$$

우선 행렬 $A$의 선형변환을 시각화하면 아래와 같다.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_sym_A/" width="300" height = "240" frameborder="0"></iframe><br>
애니메이션 6. 행렬 A의 선형변환</p>

위 행렬의 고윳값 고유벡터는 아래와 같다.

$$\lambda = 1 \text{ or } 3$$

$$\vec{q}_1 = \begin{bmatrix}0.7071 \\ -0.7071\end{bmatrix}$$

$$\vec{q}_2 = \begin{bmatrix}0.7071 \\ 0.7071\end{bmatrix}$$

행렬 $A$의 고윳값과 고유벡터를 이용해 식 (13)과 같이 행렬 $A$를 분해하기 위한 행렬들을 써보면 아래와 같다.

$$Q = \begin{bmatrix}0.7071 & 0.7071 \\ -0.7071 & 0.7071\end{bmatrix}$$

$$\Lambda = \begin{bmatrix}1 & 0 \\ 0 & 3\end{bmatrix}$$

$$Q^T = \begin{bmatrix}0.7071 & -0.7071 \\ 0.7071 & 0.7071\end{bmatrix}$$

고윳값, 고유벡터 관점에서 봤을 때 일반적인 정방 행렬과 대칭 행렬의 차이는 고유벡터들이 서로 직교한다는 것이다.

따라서, 행렬 $Q$에 의해서 선형 변환되었을 때는 선형 변환 후에도 여전히 기저 벡터들의 길이는 1이면서 동시에 직교하기 때문에 벡터 공간을 회전 시켜놓은 것 같은 결과를 확인할 수 있다.

(여기서 '회전 시켜 놓은 것 같은'이라고 말하는 것은 행렬 $Q$의 열벡터의 위치에 따라 기저벡터가 뒤집혀서 선형변환 될 수도 있기 때문이다.)

따라서, 대칭 행렬의 고유벡터를 모아 얻은 행렬 $Q$는 회전행렬과 유사한 의미를 갖는다.

$Q^T$, $\Lambda$, $Q$의 선형 변환을 차례대로 적용하면 원래의 선형 변환 $A$와 같은 것을 알 수 있다.

아래의 Applet에서 세 개의 슬라이드는 각각 $Q$, $\Lambda$, $Q^T$에 해당한다.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_sym_A_decomposed/" width="320" height = "265" frameborder="0"></iframe><br> 애니메이션 7. 선형변환 $Q$, $\Lambda$, $Q^T$을 독립적으로 적용 시켜보자.</p>

<center>
<iframe width="560" height="315" src="https://www.youtube.com/embed/VUHihs_ClFA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</center>
