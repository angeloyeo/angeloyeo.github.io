---
title: 허근의 위치
sidebar:
  nav: docs-ko
aside:
  toc: true
key: 20190616
tags: 기초수학
---


# 1. 허근의 존재

중·고등학교 시절 이차방정식의 판별식을 배우면서 우리는 허근의 존재에 대해 익히 듣게 되었다. 실근, 중근, 허근이라는 이름으로 처음 등장하게 되면서 판별식이 음수인 경우에 ‘허근을 가진다’라고 말한다. 그렇다면 근의 위치는 어떻게 시각화 할 수 있는 것인가? 그것은 함수를 2차원 평면에 그려보는 것으로 가능해진다. 너무 쉽고 당연한 얘기이지만 오늘은 이 얘기를 확장시켜 보려고 한다.

<img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq1.png">의 2차 함수를 생각해보자. 근은 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq2.png">이다. 함수를 2차원 평면 상에 그려보도록 하자.

<p align="center"><iframe width = "480" height = "480" frameborder = "0" src="https://angeloyeo.github.io/p5/yx2_2019_06_22_00_21_14/"></iframe></p>


<center>
그림 1 두 실수 축에서 생각할 수 있는 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq3.png">의 그래프
</center>

근이라고 하는 것은 함수의 값을 0으로 만족시켜줄 수 있는 입력값 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq4.png">이어야 한다. 하지만 이 그림에서 함수의 값을 0으로 만들어주는 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq5.png">의 값은 축 어디에도 없다. 왜냐하면 우리가 그린 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq6.png">축과 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq7.png">축은 모두 실수(real number)축이기 때문이다.

# 2. 복소 평면의 등장

<img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq8.png"> 허수의 존재 의미 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq9.png"> 편에서 허수에 대해 짧게 다루었는데, 간단하게만 정리하자면 허수는 실수를 벗어난 다른 차원의 수이다. 왜냐하면 실수와 허수는 직교하는 수체계이기 때문이다.

 허수의 기본단위인 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq10.png">는 제곱해서 –1이 되는 복소수를 의미한다. 제곱이라는 것의 의미를 잘 생각해보면 같은 연산을 두 번 해주어서 그 결과를 낼 수 있어야 하는데, 같은 연산을 두 번 해주어서 –1이 되려면 실수 축에 직교하는 축으로 90도 회전하는 연산을 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq11.png">의 연산으로 보아야 한다.

복소수는 실수와 허수를 모두 합한 수체계를 의미하기 때문에, 따라서, 실수와 복소수를 동시에 한 평면에 나타내면 실수 축과 허수 축이 직교하는 형태의 ‘복소 평면’을 얻을 수 있게 된다.

<p align="center"><iframe width = "320" height = "320" frameborder = "0" src="https://angeloyeo.github.io/p5/imaginary_roots_pic2_circle/"></iframe></p>

<center>그림 2 복소 평면. 실수 축과 허수 축은 서로 직교한다.</center>

즉, 다시 말해 우리가 허근을 가지는 이차함수의 값이 0이 되는 부분을 찾기 위해서는 실수의 수준에서 그래프를 그리면 안되고 복소수 수준에서 그래프를 그려야 한다는 사실을 짐작할 수 있게 된다. 이 때, 우리는 복소수는 실수와 다르게 크기와 방향을 동시에 가지는 수라는 점을 꼭 인지하고 있어야 한다.

즉, 복소수는 수직선상에 나타나는 크기와 부호를 가지는 수가 아닌 수평면상에 나타나는 크기와 방향을 가지는 수체계이다. 이 중 복소수의 크기는 magnitude라고 부르고 방향은 phase라고 부른다.

이제 약간 어려운 부분이 생겼다. 그렇다면, 복소 함수를 제대로 그려주기 위해서는 입력인 두 개의 값(<img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq12.png">, <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq13.png">축의 값)에 대해 출력인 두 개의 값(magnitude와 phase)이 표현되어야 하므로 총 4개의 차원 정보가 시각화 되어야 한다.


# 3. 4차원 정보의 표현


인간이 시각적으로 이해할 수 있는 정보는 3차원까지 이기 때문에 일반적으로는 3차원을 넘는 정보는 시각화하는 것이 불가능한 것으로 알려져 있다.

하지만 phase는 독특한 성질을 가지고 있는데 그것은 phase는 그 크기가 얼마가 되었든 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq14.png">의 범위 안으로 바꿔 생각할 수 있다는 점이다.

따라서 우리가 취할 수 있는 전략 중 하나는 입력 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq15.png">, <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq16.png">와 출력 중 magnitude를 3차원의 그래프로 표현하고 phase는 색깔을 통해 표시하는 방법이다. 이것은 사람이 직접 하기에는 매우 힘든 작업이므로 컴퓨터로 구현해보았다.

아래는 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq17.png">의 그래프이다.

<p align = "center">
  <iframe width = "350" height = "350" src = "https://angeloyeo.github.io/p5/2019-06-16-imaginary_root/" frameborder = "0"></iframe>
</p>

빨간 선을 따라간 것이 지금 까지 배운 내용을 바탕으로 실수 축에서만 생각할 수 있는 함수 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq18.png"> 이다. 또한 이렇게 plot을 해두면 <img src = "https://raw.githubusercontent.com/angeloyeo/angeloyeo.github.io/master/equations/2019-06-16-imaginary_root/eq19.png">에서 근을 가진다는 것을 시각적으로 확인할 수 있다.

<center>
<iframe width="420" height="315" src="https://www.youtube.com/embed/DJD-s9jK6Tk" frameborder="0" allowfullscreen></iframe></center>