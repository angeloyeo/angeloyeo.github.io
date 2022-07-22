---
title: 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq1.png">의 의미
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20190904
tags: 기초수학
---

# 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq2.png">의 정의

우선은 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq3.png">의 정의와 그 값에 대해 알아보면 다음과 같다.


자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq4.png">는 다음의 극한으로 표현되는 값이다. 

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq5.png"> </p>

또한, 소수로 나타낸 e의 근사값은 다음과 같다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq6.png"> </p>

자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq7.png">는 숫자만 놓고 보기엔 매우 부자연스러워 보이지만 어떤 이유에서 필요했기에 저런 상수를 도입했을까?

마치, 파이(<img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq8.png">)도 숫자로만 생각하면 3.14159 265359 ... 와 같이 아무런 의미 없어보이는 값이지만 사실은 원의 둘레, 넓이 등을 계산하는데 도움을 주는 값인것처럼 자연 상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq9.png"> 역시 어떤 의미가 있을 것이다.

# 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq10.png">의 의의

자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq11.png">는 자연의 연속 성장을 표현하기 위해 고안된 상수라고 할 수 있다. 

조금 더 구체적으로는 **100%의 성장률**을 가지고 **1회 연속 성장**할 때 얻게되는 성장량을 의미한다.

위 문장에서 bold처리를 한 두 가지 단어가 핵심이라고 할 수 있다.

## 100% 성장률로 1회 연속 성장한다는 것의 의미

마법의 저금통이 있다고 상상해보자. 이 저금통은 1원을 넣으면 정확히 1년 뒤에 1원이 더 늘어나(즉, 100% 성장률) 2원이 된다고 하자. 이것을 1회 성장한 것이라고 상정할 수 있다.

이것을 그림으로 표현하면 다음과 같다.

<p align = "center">
  <img width = "500" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2019-09-04_natural_number_e/pic1.png">
  <br>
  그림 1. 1년 뒤 100% 성장하는 마법의 저금통
</p>

그런데, 여기서 만약 6개월마다 50%씩 성장한다고 세팅을 변경하면 어떻게 될까?

1원은 6개월 뒤에 0.5원이 붙고... 그 0.5원도 또 ... 말로 설명하면 복잡하니 그림으로 표현하면 아래의 그림 2와 같다.

<p align = "center">
  <img width = "500" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2019-09-04_natural_number_e/pic2.png">
  <br>
  그림 2. 6개월에 50%씩 성장하는 마법의 저금통
</p>

여기서, 핵심적인 포인트는 그림 2처럼 6개월 단위로 50%씩 성장시키면 1년 뒤에는 2원이 아니라 2.25원이 된다는 점이다.

즉, 그림 1에서 처럼 한번에 100% 성장 시키는 것 보다 0.25원이나 더 늘었다.

그러면, 3번에 나눠서 성장시킨다면 어떻게 될지 확인해보자.

<p align = "center">
  <img width = "500" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2019-09-04_natural_number_e/pic3.png">
  <br>
  그림 3. 4개월에 33.33%씩 성장하는 마법의 저금통
</p>


역시나 6개월에 50% 성장하는 것 보다 4개월에 33.33% 성장하는게 더 성장량이 크다.

그렇다면, 자연스럽게 이런 의문이 들 것이다.

**"무한히 많이 쪼개면 어떻게 될까? 성장량도 무한하게 커질까?"**

이 의문을 해소하기 위해서는 위의 그림 1, 2, 3의 내용을 수식으로 만들어볼 필요가 있다.

그림 1의 내용을 수식으로 만들면 다음과 같다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq12.png"> </p>

그림 2의 내용을 수식으로 만들면 다음과 같다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq13.png"> </p>

그림 2가 식 (4)와 같이 쓸 수 있는 이유를 설명하면 다음과 같다.

식 (4)를 풀어쓰면 다음과 같은데,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq14.png"> </p>

즉, 그림 2에서 볼 수 있는 원래의 1원이 1.5원이 되는 과정이 우변의 첫번째 항, 6개월 뒤에 얻어진 0.5원이 0.75원이 되는 과정이 우변의 두 번째 항에서 표현된 것이다.

같은 원리로 그림 3을 수식으로 만들면 다음과 같다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq15.png"> </p>

같은 원리를 이용하여 100% 성장을 n번으로 나눠서 성장시키면 다음과 같은 결과를 얻을 수 있다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq16.png"> </p>

그러면, 무한히 쪼갠다면 아래와 같은 수식으로 그 성장량을 생각할 수 있게 된다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq17.png"> </p>

잘 알고있듯이 식 (8)이 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq18.png">로 정의되는 숫자이며, 그 값은 2.718 가량이다.

여기서 무한히 쪼개서 성장시킨다는 개념을 앞서 언급한 \'연속 성장\'과 맞춰서 생각할 수 있다.

# 성장 횟수와 성장률에 관하여

앞서 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq19.png">는  **100%의 성장률**을 가지고 **1회 연속 성장**할 때 얻게되는 성장량을 의미한다고 얘기했다. 또, 100% 성장률로 1회 연속 성장할 때 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq20.png">만큼 성장량을 갖게 된다는 것을 알수 있었다.

그렇다면, 만약 50% 성장률을 가지고 1회 연속성장한다면 그 값은 어떻게 될까?

수식으로 적으면 다음과 같을 것이다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq21.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq22.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq23.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq24.png"> </p>

또, 100% 성장률로 2회 연속 성장한다면 그 성장량은

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq25.png"> </p>

일 것이다.

다시 말해, <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq26.png">라는 식에서 지수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq27.png">가 갖는 의미는 성장 횟수(growth time)와 성장률(growth rate)과 관련이 있다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq28.png"> </p>

인 것이다.

## 자연 로그의 의미에 대해서

앞서 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq29.png">라는 식에서 지수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq30.png">가 갖는 의미가 성장횟수(growth time)와 성장률(growth rate)을 곱한 것과 관련이 되어 있다고 언급했다.

이를 수학적으로 표현하면 자연로그의 의미 중 하나를 쉽게 유추할 수 있다.

즉, 어떤 성장량을 알고 있을 때 성장횟수와 성장률을 곱한 값을 역으로 계산해낼 수 있게 되는 수학적 기술인 것이다.

즉, A라는 성장량을 알고 있다고 하고, 이것을 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq31.png">로 나타낼 수 있다고 하면 자연로그를 이용해 아래와 같이 성장횟수 x 성장률을 계산할 수 있다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq32.png"> </p>

# 자연상수가 밑인 지수함수의 미분

고등학교 시절에 배우는 미분에서는 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq33.png">를 밑(base)으로 하는 지수함수의 미분에 대해 배우게 된다.

이 부분에 있어 가장 중요한 포인트는 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq34.png">를 밑으로 하는 지수함수의 미분은 그 자신이라는 것이다.

다시 말해,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq35.png"> <br> 식 (16) </p>

[//]:# (식 16)

이다.

마치 [각도법 대신 호도법](https://angeloyeo.github.io/2019/06/04/2-1-angle_rad.html)을 쓰면 삼각함수의 미분이 깔끔해지는 것 처럼

지수함수에 대해 미분할 때에도 밑이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq36.png">를 쓰면 미분의 결과가 깔끔해지는 것이다.

만약 밑이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq37.png">가 아닌 양의 실수라면 어떻게 결과가 바뀌었더라?

공식을 써보면 아래와 같았다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq38.png"> <br> 식 (17)  </p>

[//]:# (식 17)

그래서 미분적분학에서 가능한 많은 지수함수의 밑을 모두 자연상수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq39.png">로 생각해서 쓰고자 하는 것이다.

---

다시, 우리의 원래 관심사인 자연상수가 밑인 지수함수의 미분에 대해 돌아와보자.

우리는 식 (16)의 의미를 어떻게 받아들여야 할까?

그것은 

* 식 (16)이 정말 연속성장을 의미하는가? 

라는 점과 

* 식 (16)에서 지수함수의 밑이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq40.png">여야 하는가라는 점이다.

식 (16)에서 <p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq41.png"> </p>가 아니라 임의의 함수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq42.png">라고 써보자. 그러면 미분방정식이 보인다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq43.png"> <br> 식 (18) </p>

[//]:# (식 18)

식 (18)의 의미가 뭘까? 이게 왜 성장과 관련이 있는 것일까?

이를 알아보기 위해 미분의 원래 공식을 다시 써보도록 하자.

<img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq44.png">라고 하면,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq45.png"><br> 식 (19)  </p>

[//]:# (식 19)

이렇게까지 썼지만 식 (19)에서 갖는 극한이 어려워 보이기 때문에 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq46.png">인 경우부터 차근히 생각해보자.

## 1. 식 (16)이 정말 연속 성장을 의미하는가?

### 1) <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq47.png">인 경우

식 (16)의 의미를 조금 더 깊이 생각하기 위해 식 (19)를 가져와 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq48.png">의 값을 점점 작게 만들어보자.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq49.png"> <br> 식 (20) </p>

[//]:# (식 20)

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq50.png"><br> 식 (21)  </p>

[//]:# (식 21)

식 (21)이 말하는 것은 뭔가? 바로 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq51.png">라는 뜻이다. 그림으로 그리면 다음과 같다.

<p align = "center">
  <img width = "400" src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2019-09-04_natural_number_e/pic4.png">
  <br>
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq52.png">에서 매 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq53.png">의 성장률은 자기 자신이다.
</p>

즉, <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq54.png">일 때 식 (18)의 의미를 조금 자세히 볼 수 있다. 변화율이 자기 자신이라는 것이다.

다시 말해 다음번 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq55.png">에서는 지금의 함수 크기만큼 키워준다는 뜻이기도 하다.

### 2) <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq56.png">인 경우

이번에는 식 (19)에 대해 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq57.png">인 경우에 대해 생각해보자.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq58.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq59.png"> </p>

이런 식으로 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq60.png">가 매우 작은 경우에 대해서도 생각해볼 수 있을 것이다.

### 3) <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq61.png">인 경우

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq62.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq63.png"> <br> 식 (25) </p>

[//]:# (식 25)

식 (25)가 말하는 것은 무엇인가? 그것은 바로

<center><b>
  "지금 값 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq64.png">에서 진짜 조금만 키운 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq65.png"> 값이 바로 다음 함수 값 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq66.png">이다"
  </b>
</center>

라는 것이다.


다시 말해 매번 아주 작은 스텝에서 매우 조금씩 크게 만들겠다는 것이고 이것은 다시 말하면 연속 성장이다.

## 2. 식 (16)에서 지수함수의 밑이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq67.png">여야 하는가

식 (18)을 다시 써보자.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq68.png"> </p>

식 (18)의 미분방정식을 풀기 위해 y는 모두 좌변으로, x는 모두 우변으로 옮기면 다음과 같다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq69.png"> <br> 식 (27) </p>

[//]:# (식 27)

이 때 양변에 모두 적분을 취해주자.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq70.png"> </p>

여기서 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq71.png">의 정의가 바로 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq72.png">이므로 좌변의 값은 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq73.png">와 같다.

이것의 증명은 아래와 같이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq74.png">의 미분이 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq75.png">임을 보임으로써 확인할 수 있다.

다시 말해,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq76.png"> </p>

이므로 미적분학의 기본정리에 의해,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq77.png"> </p>

(여기서 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq78.png">는 적분상수)

임을 알 수 있는 것이다.

이를 확인해보자면,

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq79.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq80.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq81.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq82.png"> </p>

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq83.png"> </p>

따라서 식 (27)은 다음과 같이 쓸 수 있다.

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq84.png"> </p>

그러므로

<p align = "center"> <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq85.png"> </p>

이다.

즉, 식 (18)에서의 함수는 지수함수이면서 밑은 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-09-04-natural_number_e/eq86.png">인 지수함수이다.

<p align= "center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/_EY8QUKWrhc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>

<p align = "center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/gIyZv8ea6Gw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>
