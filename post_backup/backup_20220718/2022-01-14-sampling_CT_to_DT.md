---
title: 연속 신호의 샘플링
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20220114
tags: 신호처리
---

[//]:# (연속 신호를 샘플링한다는 것은 무엇인지, 샘플링 시 발생할 수 있는 문제는 무엇인지, 주파수 측면에선 어떤 의미가 있는지 정리할 것)

[//]:# (섀넌 샘플링 정리는 추후에 다룰 것. 아직 푸리에 변환/급수에 대해 알지 못하기 때문. 여기선 가볍게 정리하고 넘어가도록 하자.)

※ 섀넌-나이퀴스트의 샘플링 이론의 증명은 [이 포스팅](https://angeloyeo.github.io/2019/07/11/Shannon_sampling_theorem.html)을 확인하세요.

<p align="center"><iframe width = "802" height = "302" src="https://angeloyeo.github.io/p5/2019-07-11-Shannon_sampling_theorem/" frameborder="0"></iframe>
<br><b>샘플링 전 연속 신호(흰색)와 샘플링하여 복원한 신호(파란색)의 차이 비교</b>
</p>

# 연속 신호, 이산 신호, 디지털 신호의 관계

요즘에는 디지털 기기가 보편화 되었다. 카세트 테이프 보다는 MP3 플레이어를 사용하게 되었고, 종이책과 e-book이 공존하며, 아날로그 TV 방송이 모두 디지털 방송으로 전환되었다.

일상 생활에서 디지털 기기는 '편의성을 고려했다' 혹은 '최신 기술이 적용되었다'는 이미지가 많이 떠오른다. 그만큼 연구가 많이 이루어졌고, 실생활과 맞닿아 있는 유용한 기술이라 할 수 있다.

디지털 신호 처리 과목에서는 이러한 디지털 신호를 분석하는데 필요한 기술과 이론들을 다루게 된다. 

그렇다면, 디지털 신호는 아날로그 신호와 어떻게 다른 것일까?

아래 그림에서 볼 수 있듯이 디지털 신호는 아날로그 신호를 디지털 변환한 것이다.

이런 변환기를 Analog-to-Digital Converter라고 부른다. 반대로 Digital에서 Analog로 복원하는 과정도 있다. 이를 처리하는 변환기를 Digital-to-Analog Converter라고 부른다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_ADC_DAC.png">
  <br>
  그림 1. 아날로그 신호의 디지털 처리 시스템
</p>

디지털 신호를 잘 살펴보면 시간 간격이 일정하게 신호를 받아온 것을 알 수 있다. 이렇게 시간 간격을 두고 신호를 저장하는 이유는 디지털 기기의 메모리는 유한하기 때문이다.

여기서 일정 시간 간격으로 연속 신호를 저장하는 과정을 시간 샘플링(time sampling)이라고 부른다.

대부분의 아날로그 신호들은 실수 함수(real function)인 경우가 많은데, 실수 체는 무한하다. 컴퓨터는 이를 받아들일 수가 없어 유한한 갯수의 함수값만을 받아오게 된다.

가로축이 샘플링되어 있는 것은 눈으로 쉽게 보이지만 세로축에 대해서는 신경을 쓰지 않는 경우도 종종 있다.

세로축도 일종의 샘플링된 것 처럼 이산적인 값만 가지도록 변환된다. 이를 양자화(quantization)라고 한다. 

양자화 이론은 간단해 보이지만, 생각보다 이론은 복잡하고 하드웨어로 구성하기 위한 아이디어도 꽤 복잡하다. 이 블로그에서는 양자화에 대해서는 깊게 다루지 않을 것이다.

아무튼 시간 샘플링과 양자화가 모두 수행된 신호를 비로소 '디지털 신호'라고 부른다. 

추가로 보통 시간 샘플링만 수행된 신호를 '이산 신호'라고 많이 부르고 양자화 여부에 따라 디지털 신호와 구분해 부르기도 한다.

# 시간 샘플링의 부수 효과(side effects)

어떤 신호든지 서로 다른 주파수를 가지는 정현파의 선형 결합으로 표현할 수 있기 때문에 우리는 정현파에 대해 생각한다.

그리고, 정현파는 원 위의 움직임으로부터 나오는 신호이기 때문에 주기를 가지며, 이 주기성으로 인해 샘플링에서 몇 가지 고려해야할 점들이 생긴다.

## 다른 주파수의 연속 정현파에서 나온 동일한 이산 정현파

임의의 정현파 $x(t)$를 생각해보자.

$$x(t) = A\cos(\omega_0 t)$$

이 신호를 주기 $T_s$로 샘플링해주면 다음과 같은 이산 신호를 얻게 되는 것이다.

$$x[n]=x(nT_s) = A\cos(\omega_0 nT_s) = A \cos(\Omega_0 n)$$

여기서 $\Omega_0=\omega_0 T_s \text{[rad]}$는 이산 정현파 신호의 각주파수이다. 이는 연속 정현파 신호의 각주파수 $\omega_0 \text{[rad/sec]}$와 차이를 보인다.

(참고로 각주파수는 주파수에 $2\pi$를 곱하여 계산하는 주파수를 말한다. 가령 1초 주기로 회전하는 원으로부터 얻은 정현파의 각주파수는 $2\pi$이다.)

$\Omega_0$는 단위가 라디안이고 $\omega_0$는 단위가 라디안/초 라는 점에 주목해보자. 즉, $\Omega_0$에서는 시간 정보가 사라지게 된다.

그러다보니 $\omega_0$이 크고 $T_s$가 작은 경우나 $\omega_0$이 작고 $T_s$가 큰 경우로 적당히 조합되면 연속 신호의 주파수는 다르더라도 이산 신호는 동일하게 얻어질 수 있다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_dif_freq_dif_time_sampling.png">
  <br>
  그림 2. 서로 다른 주파수와 샘플링 주기를 갖는 경우에도 동일한 이산 신호를 얻게될 수 있다.
</p>

즉, 주파수가 $f_0+ k f_s$ (여기서 $k$는 정수)인 정현파를 샘플링 주파수 $f_s$로 샘플링하면 주파수 $f_0$인 정현파를 샘플링한 것과 같은 결과를 얻게 된다.

$$\cos(2\pi(f_0+kf_s)nTs)=\cos(2\pi f_0nTs+2\pi knf_s T_s)$$

$$=\cos(2\pi f_0 nTs + 2\pi k n) = \cos(2\pi f_0 nT_s)$$

## 이산 정현파를 연속 정현파로 복원할 때의 문제: 에일리어싱

위의 문제를 거꾸로 생각해보면, 임의의 이산 정현파를 연속 신호로 복원한다고 해서 무조건 원래의 신호로 그대로 복원하지 못할 수 있다는 말이 된다.

다른 주파수의 정현파를 샘플링 했음에도 동일한 $f_0$의 주파수를 갖는 이산 신호를 얻게 되기 때문에, $f_0 + k f_s$를 샘플링 주파수 $f_s$에 대한 주파수 $f_0$의 에일리어스(alias)라고 부르고,

이처럼 샘플링 과정에서 원래 신호가 무엇인지 구별하지 못하게 되버리는 현상을 에일리어싱(aliasing)이라고 부른다[^1].

[^1]: aliasing의 어원은 alias인데, 이는 '본래의 신분을 속이기 위해 사용하는 가짜 이름'이라는 뜻을 갖고 있다. 이런 맥락에서 신호 처리 분야에서는 '연속 신호로 복원한 얻어낸 결과물이 본래의 신호와 다른 경우'를 상정하기 위해 aliasing이라는 용어를 붙인 것으로 보인다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_aliasing.png">
  <br>
  그림 3. 에일리어싱 현상
</p>

에일리어싱 현상을 방지하기 위해선 충분히 높은 주파수로 샘플링 해주어야 한다.

이 포스팅 맨 위의 애플릿을 통해서도 볼 수 있듯이 어느정도 이상의 빠른 주기로 샘플링을 해주면 원래의 신호 형태에 가깝게 이산 신호를 연속 신호로 복원할 수 있다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_aliasing2.png">
  <br>
  그림 4. 에일리어싱을 방지하기 위해선 충분히 큰 주파수로 샘플링 해주어야 한다.
</p>

수학적으로 '얼마나 빠르게 샘플링 해야하는가?'라는 문제에 대한 답을 제시해주는 이론이 [섀넌-나이퀴스트 샘플링 정리](https://angeloyeo.github.io/2019/07/11/Shannon_sampling_theorem.html)이다. 다만, 이 정리의 내용을 이해하려면 푸리에 급수/변환에 대한 이해가 선행되어야 하므로 추후에 더 자세히 다루고자 한다. 섀넌 나이퀴스트 샘플링 정리의 결론만 말하자면 복원하고자 하는 신호의 최대 주파수의 두 배 빠르기의 주파수로 샘플링 해주면 원래 신호로 복원할 수 있다.

## 이산 신호의 주파수 특성

이산 신호의 가로축을 잘 보면 순번만 표시되어 있는 것을 볼 수 있다.

그리고, 순번의 간격은 항상 1이기 때문에 이 신호를 표현할 수 있는 최소 주기는 1이다.

다시 말하면 최대 주파수는 1, 최소 주파수는 0이 될 것이다.

보통은 [음의 주파수](https://angeloyeo.github.io/2019/07/22/Negative_Frequency.html)까지도 포함해서 주파수를 표현하므로 이산 신호의 주파수 구간은

$$-0.5\lt F \lt 0.5$$

혹은

$$-\pi \lt \Omega \lt \pi$$

와 같다.

또 한편, 이산 정현파만의 주파수 특성에 대해서도 생각해볼 수 있다.

어떤 신호든지 서로 다른 주파수를 갖는 정현파의 선형결합으로 표현할 수 있다. 이 내용은 연속 신호에만 해당하는 것은 아니고 이산 신호의 경우에도 마찬가지로 적용할 수 있다. 따라서, 이산 신호를 분석할 때도 당연히 정현파를 이용하는 것이 유용한 점이 많다.

이산 정현파는 연속 정현파와 약간의 차이점이 있다. 이산 정현파는 항상 주기신호가 아니다. 다시 말하면 샘플링 주기에 따라 이산 정현파는 주기 신호일 수도 있고 아닐 수도 있다.

임의의 이산 정현파 $x[n]$을 다음과 같이 상정해보자.

$$x[n]=A\cos(\Omega_0 n)$$

만약 $x[n]$이 $N$을 주기로 하는 주기 신호라면 다음이 성립해야 한다. (여기서 $N$은 정수)

$$x[n]=x[N+n]$$

$$\Rightarrow A\cos(\Omega_0 n) = A\cos(\Omega_0 (n+N))$$

따라서 디지털 각주파수 $\Omega_0$는

$$\Omega_0 N = 2\pi k \Rightarrow \Omega_0 = \frac{2\pi k}{N}$$

를 만족하거나, (여기서 $k$는 정수)

혹은 디지털 주파수 $F_0 = \Omega_0/2\pi$가

$$\frac{\Omega_0}{2\pi}=F_0=\frac{k}{N}$$

을 만족하는 유리수여야 한다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_periodic_nonperiodic_discrete_sinusoids.png">
  <br>
  그림 5. 디지털 주파수가 유리수일 때만 이산 신호가 주기신호가 된다.
</p>

이 꼭지의 내용을 요약해서 정리하면 이산 정현파 신호는 $-\pi$에서 $\pi$ 내에 모든 주파수 성분을 다 표시할 수 있는데 $2\pi$ 만큼의 주기성을 동시에 갖는다.

따라서, 이산 신호는 디지털 각주파수 $-\pi$에서 $\pi$ 사이의 주파수 스펙트럼이 $2\pi$의 주기를 갖고 복사되어 있는 주기성을 띈다.

아래 그림은 주기 신호의 스펙트럼과 그것을 시간 샘플링하여 이산화 했을 때의 결과물을 비교한 것이다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_frequency_spectrum_of_periodic_discrete_signal.png">
  <br>
  그림 6. 이산 주기 신호의 주파수 스펙트럼은 원래 연속 주기 신호의 복사물이 $2\pi$ 간격으로 표시되게 된다.
</p>

또, 아래 그림은 비주기 신호의 스펙트럼과 그것을 시간 샘플링하여 이산화 했을 때의 결과물을 비교한 것이다.

<p align = "center">
  <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/pics/2022-01-14-sampling_CT_to_DT/pic_frequency_spectrum_of_nonperiodic_discrete_signal.png">
  <br>
  그림 7. 이산 비주기 신호의 주파수 스펙트럼은 원래 연속 신호의 복사물이 $2\pi$ 간격으로 표시되게 된다.
</p>

# 참고 문헌

* Hello! 신호 처리, James H. McClellan 등, 홍릉과학출판사
* 디지털 신호 처리, 이철희, 한빛아카데미