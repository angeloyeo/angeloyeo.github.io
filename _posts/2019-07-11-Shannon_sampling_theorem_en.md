---
title: Shannon's Sampling Theorem
sidebar:
  nav: docs-en
aside:
  toc: true
key: 20190711_en
tags: Signal_Processing
lang: en
---

[//]:# (섀넌의 샘플링 정리라는 수정된 제목에 맞춰 내용 수정할 것. )

<p align="center"><iframe width = "802" height = "302" src="https://angeloyeo.github.io/p5/2019-07-11-Shannon_sampling_theorem/" frameborder="0"></iframe></p>

What Sampling theorem tells you: :
<center>

<b>"How compact do I have to sample the signal in order to reconstruct it to original?"</b>

</center>

{% raw %}

이 문서의 한국어 버전은 아래의 위치에서 찾을 수 있습니다. (You can find a Korean version of this article as below.)

* [섀넌의 샘플링 정리](https://angeloyeo.github.io/2019/07/11/Shannon_sampling_theorem.html)

# Time Sampling?

In order to display physical (analog) signals on a digital screen, sampling is necessary. In signal processing, when we talk about sampling, we usually refer to time sampling.

Time sampling can be described as the process of converting the original analog signal (the white solid line in the topmost applet of the postman) into a digital signal. (Finally, the analog world and the digital world meet!) In the topmost applet of the postman, the analog signal is sampled with 'some' period, and if the sampling rate is above a certain threshold, the sampled time and signal values can be used to reconstruct the original signal almost accurately.

Then, theoretically, what period should we use to sample the analog signal so that it can be reconstructed into the original signal? (i.e., ideal reconstruction). The answer to this question can be found in the sampling theorem.

## Proof process of the Sampling theorem

Let's consider a continuous-time signal $x_c(t)$ and a discrete-time signal $x_d[n]$.

The sampled sequence of this continuous-time signal can be expressed as follows.

$$x_d[n]=x_c(nT)$$

Here, $T$ is the sampling interval.

For the continuous-time signal $x_c(t)$, we know that it has the following Fourier transform.

$$X_c(f) = \int_{-\infty}^{\infty}x_c(t) \exp(-j2\pi f t)dt$$

For the discrete-time signal $x_d[n]$, we know that it has the following Fourier transform.

$$X_d(f) = \sum_{n=-\infty}^{\infty}x_d[n]\exp(-j2\pi fn)$$

Now, we want to mathematically express the relationship between $X_c(f)$ and $X_d(f)$.

***

Next, let's define a signal called an impulse train.

$$p_c(t) = \sum_{n=-\infty}^{\infty}\delta(t-nT)$$

<p align = "center">
<img width = "400" src = "https://upload.wikimedia.org/wikipedia/commons/4/49/Dirac_comb.svg">
<br>
Figure 1. impulse train
</p>

We can mathematically represent the process of sampling a continuous signal using an impulse train. Therefore, we can think of the relationship between a continuous signal and a discrete signal as follows:

$$y_c(t) = x_c(t)p_c(t) = \sum_{n=-\infty}^{\infty}x_d[n]\delta_c(t-nT)$$

Since $y_c(t)$ is a non-periodic continuous signal, it can be Fourier transformed. The Fourier transform of $y_c(t)$, denoted by $Y_c(f)$, can be expressed as follows:

$$Y_c(f) = \int_{-\infty}^{\infty}y_c(t) \exp(-j2\pi ft)dt $$

$$=\int_{-\infty}^{\infty}\sum_{n=-\infty}^{\infty}x_d[n] \delta(t-nT) \exp(-j2\pi ft)dt$$

$$=\sum_{n=-\infty}^{\infty}x_d[n]\int_{-\infty}^{\infty}\delta(t-nT) \exp(-j2\pi ft)dt$$

$$=\sum_{n=-\infty}^{\infty}x_d[n] \exp(-j2\pi f nT) = X_d(Tf)$$

In going from Equation (8) to Equation (9), we use the property of the Dirac delta function:

$$\int_{-\infty}^{\infty}\delta(t-k)f(t) dt = f(k)$$

Also, since $p_c(t)$ is a periodic continuous-time signal with a period of $T$, $p_c(t)$ can be represented using the CTFS:

$$p_c(t) = \sum_{n=-\infty}^{\infty} \delta(t-nT)$$

$$=\sum_{k=-\infty}^{\infty} a_k \exp\left(j \frac{2\pi k}{T}t\right)$$

<center> where </center>

$$a_k = \frac{1}{T}\int_{-T/2}^{T/2}\delta(t) \exp\left(-j \frac{2\pi k}{T}t\right)dt = \frac{1}{T}$$

<center>(Here, we also use the property in Equation (10).)</center>

However, at the same time, CTFT can be applied to any continuous signal, whether it is a periodic signal or not, so it is also possible to apply CTFT to $p_c(t)$.

$$P_c(f) = \int_{-\infty}^{\infty}p_c(t) \exp(-j2\pi ft) dt $$

$$=\int_{-\infty}^{\infty}\frac{1}{T} \sum_{k=-\infty}^{\infty} \exp\left(j\frac{2\pi k}{T}t\right) \exp(-j2\pi ft)dt$$

$$=\frac{1}{T} \sum_{k=-\infty}^{\infty}\int_{-\infty}^{\infty} \exp\left(j\frac{2\pi k}{T}t\right) \exp(-j2\pi ft)dt$$

Let's consider the static integral part in equation (16). Rewriting this equation gives the following equation (17).

$$\int_{-\infty}^{\infty}\exp\left(j\frac{2\pi k}{T}t\right) \exp(-j2\pi ft)dt$$

Equation (17) can also be interpreted as the Fourier transform of $\exp\left(j\frac{2\pi k}{T}t\right)$.

To understand equation (17), let's consider the following two Fourier transforms.

$$ \mathfrak{F}(1) = \int_{-\infty}^{\infty}1 \times \exp\left(-j2\pi ft\right) = \delta(f)$$

Also, assuming $\mathfrak{F}(f(t)) = F(f)$, we have

$$\mathfrak{F}\left(\exp\left(j2\pi f_0 t\right)f(t)\right) = F(f-f_0)$$

Therefore, equation (17) can be considered as the Fourier transform of 1, but it has been modulated by $\frac{k}{T}$.

Thus, equation (17) can be written as follows.

$$Eq(17) = \delta(f-\frac{k}{T})$$

Therefore, equation (16) can be written as follows.

$$P_c(f) = \frac{1}{T}\sum_{-\infty}^{\infty}\delta(f-\frac{k}{T})$$

Furthermore, since $y_c(t)=x_c(t)p_c(t)$, considering the relationship between convolution and Fourier transform, we have $Y_c(f)=X_c(f)\otimes P_c(f)$. (Here, the '$\otimes$' operator represents the convolution operator.)


Therefore,

$$Y_c(f) = X_c(f) \otimes P_c(f) = P_c(f) \otimes X_c(f)$$

$$ = \int_{-\infty}^{\infty}P_c(\tau)X_c(f-\tau)d\tau$$

$$=\int_{-\infty}^{\infty}\frac{1}{T}\sum_{k=-\infty}^{\infty}\delta\left(\tau-\frac{k}{T}\right)X_c\left(f-\tau\right)d\tau$$

$$=\frac{1}{T}\sum_{k=-\infty}^{\infty}\int_{-\infty}^{\infty}\delta\left(\tau-\frac{k}{T}\right)X_c\left(f-\tau\right)d\tau$$


We can think of the part of the equation (25), i.e.,

$$\int_{-\infty}^{\infty}\delta\left(\tau-\frac{k}{T}\right)X_c(f-\tau)d\tau$$

as follows:

$$\int_{-\infty}^{\infty}\delta\left(\tau-\frac{k}{T}\right)X_c\left(f-\tau\right)d\tau= \delta\left(f-\frac{k}{T}\right)\otimes X_c(f)$$

> This is because we can view the convolution operation of $X(f)$ and $Y(f)$, as shown in the equation below, as replacing $f$ with $\tau$ in $X(f)$ and replacing $f-\tau$ in $Y(f)$ with $f$:
> 
> $$X(f)\otimes Y(f) = \int_{-\infty}^{\infty}X(\tau)Y(f-\tau)d\tau$$
> 
> Applying the same method, we can change the $f$ in the delta function on the left and the $f$ in $X_c$ to $\tau$ and $f-\tau$, respectively, in $\delta(f-\frac{k}{T})\otimes X_c(f)$, and obtain the expression:
> 
> $$\int_{-\infty}^{\infty}\delta\left(\tau-\frac{k}{T}\right)X_c(f-\tau)d\tau$$

Therefore,

$$Y_c(f) =  P_c(f) \otimes X_c(f) $$

According to equation (26),

$$=\frac{1}{T}\sum_{k=-\infty}^{\infty}\delta\left(f-\frac{k}{T}\right)\otimes X_c(f)$$

By the property of the delta function,

$$=\frac{1}{T}\sum_{k=-\infty}^{\infty}X_c\left(f-\frac{k}{T}\right)$$

Thus, we can confirm the relationship between $X_c(f)$ and $X_d(f)$ from equations (6)-(9) and (27)-(29) as follows:

$$Y_c(f) = X_d(Tf) = \frac{1}{T}\sum_{-\infty}^{\infty}X_c\left(f-\frac{k}{T}\right)$$

When the frequency spectrum of $X_c(f)$ is 0 for $\|f\|>B$, or in other words, when $\frac{1}{T}>2B$ (i.e., when the frequency domain is bounded), then

$$Y_c(f) = X_d(Tf) = \frac{1}{T}X_c(f) \space for \space |f| < \frac{1}{2T}$$


# ideal reconstruction

So far, we have looked at the relationship between $X_c(f)$ and $X_d(f)$ in the frequency domain. But what does knowing their relationship mean? Or do we need to understand their relationship mathematically to grasp something?

We want to know if there is a way to perfectly restore a sampled signal (or discrete signal) to its original continuous-time signal. Through the Sampling Theorem, we have discovered a mathematical relationship as shown in equation (32).

So, what measures should we take to convert the Fourier transform of the sampled signal, $Y_c(f)$, back to $X_c(f)$? Since $Y_c(f)=\frac{1}{T}X_c(f)$, we can say that we can restore $Y_c(f)$ back to $X_c(f)$ using the following method.

$$X_c(f) = Y_c(f) H_c(f)$$

<center>where</center>

$$H_c(f) =
\begin{cases}
T,  & \text{if } |f|<\frac{1}{2T} \\
0, & \text{otherwise}
\end{cases}
$$

So, we can say that $H_c(f)$ is an ideal low pass filter. (It passes all signals below a certain frequency and rejects all signals in the higher frequency band.)

In the time domain, we can derive the following relationship between $x_c(t)$ and $y_c(t)$:

$$x_c(t) = y_c(t) \otimes h_c(t) $$

$$ = \int_{-\infty}^{\infty} y_c(\tau)h_c(t-\tau)d\tau$$

$$= \sum_{n=-\infty}^{\infty}x_d[n]h_c(t-nT)$$

$$\Rightarrow h_c(t) = \mathfrak{F}^{-1}(H_c(f)) = \frac{\sin(\pi t/T)}{\pi t/T} = sinc(t/T)$$

Here, we can confirm that the ideal low pass filter in the frequency domain is represented by the sinc function in the time domain. Below is the proof of the derivation of the sinc function.

`PROOF`{:.info} impulse response function in ideal reconstruction transfer function

Let's take inverse fourier transfor for $H_c(f)$ like below:

$$H_c(f) =
\begin{cases}
T,  & \text{if } |f|<\frac{1}{2T} \\
0, & \text{otherwise}
\end{cases}
$$

$$\mathfrak{F}^{-1}(H_c(f)) = \int_{-\infty}^{\infty}H_c(f) \exp(j2\pi ft) df$$

$$= \int_{-1/2T}^{1/2T} T \space \exp(j2\pi ft) df$$

$$=\frac{T}{j2\pi t} \left\|\exp\left(j2\pi ft\right)\right\|^{1/2T}_{-1/2T}$$

$$
=\frac{T}{j2\pi ft} \left(
\exp\left(\frac{j2\pi t}{2T}\right) - \exp\left(-\frac{j2\pi t}{2T}\right)
\right)
$$

$$=\frac{T}{\pi t}\space\frac{1}{2j}\left(
\exp\left(j\frac{\pi t}{T}\right)-\exp\left(-j\frac{\pi t}{T}\right)
\right)$$

$$=\frac{T}{\pi t}\sin\left(\frac{\pi t}{T}\right) = \frac{\sin(\pi t /T)}{\pi t /T}$$

$$\therefore\mathfrak{F}^{-1} (H_c(f))=h_c(t) =\frac{\sin(\pi t/T)}{\pi t/T}$$

Q.E.D.

---

{% endraw %}