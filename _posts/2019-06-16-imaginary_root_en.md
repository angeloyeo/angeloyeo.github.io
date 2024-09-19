---
title: Location of Imaginary Roots
sidebar:
  nav: docs-en
aside:
  toc: true
key: 20190616_en
tags: Basic_Math
lang: en
---

이 문서의 한국어 버전은 아래의 위치에서 찾을 수 있습니다. (You can find a Korean version of this article as below.)

* [허근의 위치](https://angeloyeo.github.io/2019/06/16/imaginary_root.html)

# 1. The Existence of Complex Roots

During middle and high school, we learn about the existence of complex roots through the discriminant of quadratic equations. When the discriminant is negative, we say that the equation "has complex roots" and label them as either imaginary, real, or complex. But how can we visualize the location of these roots? It can be done by graphing the function on a two-dimensional plane. Although it may seem obvious and simple, today we will explore this concept further.

Let's consider the quadratic function $y=x^2+1$. The roots are $x=\pm \sqrt{-1}=\pm i$. Let's graph the function on a two-dimensional plane.

<p align="center"><iframe width = "480" height = "480" frameborder = "0" src="https://angeloyeo.github.io/p5/yx2_2019_06_22_00_21_14/"></iframe><br>
Figure 1: Graph of $y=x^2+1$ that can be visualized on two real axes.
</p>

The roots, which are also called solutions or zeros, are the input values $x$ that make the output of the function equal to zero. However, in this graph, the values of $\pm\sqrt{-1}=\pm i$ that make the function equal to zero are not found on either axis. This is because the $x$ and $y$ axes we have drawn are both real number axes.

# 2. Introduction to the Complex Plane

In the previous [article about the existence of imaginary numbers](https://angeloyeo.github.io/2019/06/15/imaginary_number_en.html), we briefly touched on the concept of imaginary numbers being a different dimensional system than real numbers since they are orthogonal to the real number system.

The fundamental unit of imaginary numbers, denoted by $i$, represents a complex number that equals -1 when squared. If we consider what squaring means, we need to perform the same operation twice to obtain the result. In order for the same operation to yield -1, we must consider the operation to be a rotation of 90 degrees with respect to the axis orthogonal to the real number line, which is represented by $\times i$.

Since complex numbers are a combination of real and imaginary numbers, they form a new coordinate system where the real and imaginary axes are orthogonal to each other. By visualizing both real and imaginary numbers on the same plane, we obtain the "complex plane" where the real and imaginary axes are orthogonal to each other.

<p align="center"><iframe width = "320" height = "320" frameborder = "0" src="https://angeloyeo.github.io/p5/imaginary_roots_pic2_circle/"></iframe><br>Figure 2: The complex plane. The real and imaginary axes are orthogonal to each other.</p>

In other words, to find the roots of a quadratic function with imaginary solutions, we need to plot the graph of the function not only in the real number line but also in the complex plane. It is important to note that complex numbers have both magnitude and direction unlike real numbers, which only have magnitude. 

Thus, complex numbers form a coordinate system on a two-dimensional plane where the size of the number is referred to as magnitude and the direction is referred to as phase. 

Now, things get a bit more complicated. To properly plot a complex function, we need to represent four dimensions of information: two input values (values along the $x$ and $y$ axes) and two output values (magnitude and phase).

# 3. Representation of 4-dimensional information

Humans can only visually understand information up to 3 dimensions, so it is generally known that visualizing information beyond 3 dimensions is impossible. However, phase has a unique property in that it can be thought of as being within the range of $[-\pi, \pi]$, regardless of its magnitude.

Therefore, one strategy we can take is to represent the input $x$, $y$ and the magnitude of the output as a 3D graph, and represent the phase through color. This is a very difficult task for humans to do directly, so we have implemented it with a computer.

Below is a graph of $f(z)=f(x,y)=z^2+1=(x+iy)^2+1$.

<p align = "center">
  <iframe width = "380" height = "350" src = "https://angeloyeo.github.io/p5/2019-06-16-imaginary_root/" frameborder = "0"></iframe>
</p>

The red line represents the function $y=x^2+1$, which can only be thought of as a function in the real axis based on what we have learned so far. Additionally, by plotting it this way, we can visually confirm that it has roots at $\pm i$.