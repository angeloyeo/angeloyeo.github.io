---
title: EigenValue Decomposition (EVD)
sidebar:
  nav: docs-en
aside:
  toc: true
key: 20201119_en
tags: Linear_Algebra
lang: en
---

※ To facilitate visualization and understanding, the field in which vectors and matrices are defined is limited to real numbers.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A/" width="300" height = "240" frameborder="0"></iframe> <br> Original linear transformation $A$ <br> <iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A_preview/" width="300" height = "240" frameborder="0"></iframe><br> Linear transformation $A$ decomposed into three steps using EVD<br><br><b>EVD allows us to think of the original linear transformation as a sequence of three steps: 'rotate', 'stretch', and 'rotate'.</b><br>
</p>

# Prerequisites

To better understand this post, it is recommended that you be familiar with the following:

* [Matrix and Linear Transformation](https://angeloyeo.github.io/2019/07/15/Matrix_as_Linear_Transformation_en.html)
* [Eigenvalues and Eigenvectors](https://angeloyeo.github.io/2019/07/17/eigen_vector_en.html)

# Background Knowledge

## Matrix is a Collection of Vectors

Suppose we have $n$ $n$-dimensional vectors $a_i\in \Bbb{R}^{n \times 1} \text{ for } i = 1, 2, \cdots, n$.

Then we can gather these $n$ vectors and construct an $n\times n$-dimensional matrix.

$$A = \begin{bmatrix} | & | & \text{ } & | \\ a_1 & a_2 & \cdots & a_n \\ | & | & \text{ } & | \end{bmatrix}\in \Bbb{R}^{n\times n}$$

[//]:# (Eq. 1)

## How to factor each column of a matrix

Suppose an $n\times n$-dimensional matrix $A$ is constructed as follows:

$$A = \begin{bmatrix}    | &  | & \text{ } &  | \\   \lambda_1 a_1 & \lambda_2 a_2 & \cdots & \lambda_n a_n \\    | &  | & \text{ } &  | \end{bmatrix}\in \Bbb{R}^{n\times n}$$

[//]:# (Eq. 2)

Here, $\lambda_i \text{ for } i = 1, 2, \cdots, n$ are arbitrary real numbers.

Then the matrix $A$ in Eq. (2) can be factored as follows:

$$A = \begin{bmatrix} | & | & \text{ } & | \\ a_1 & a_2 & \cdots & a_n \\ | & | & \text{ } & | \end{bmatrix}
\begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (Eq. 3)

To prove this, we can proceed as follows. First,

$$\begin{bmatrix} | \\ a_1 \\ | \end{bmatrix}$$ 

[//]:# (식 4)

can be expanded as

$$\begin{bmatrix} a_{11} \\ a_{21} \\ \vdots \\ a_{n1} \end{bmatrix}$$

[//]:# (식 5)

and, by writing the vector in this way, we can rewrite equation (3) as follows:

$$A = \begin{bmatrix} a_{11} & a_{12} & \cdots & a_{1n} \\ a_{21} & a_{22} & \cdots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{n1} & a_{n2} & \cdots & a_{nn} \end{bmatrix}
\begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (식 6)

$$ = \begin{bmatrix} \lambda_1a_{11} & \lambda_2a_{12} & \cdots & \lambda_na_{1n} \\ \lambda_1 a_{21} & \lambda_2a_{22} & \cdots & \lambda_n a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ \lambda_1 a_{n1} & \lambda_2 a_{n2} & \cdots & \lambda_n a_{nn} \end{bmatrix}
$$

[//]:# (식 7)

That is, it can be seen that equation (3) and equation (2) are equivalent.

# Eigenvalue decomposition

Suppose we have obtained multiple eigenvalues and eigenvectors for an arbitrary $n \times n$ matrix $A$.

In other words, we can obtain $n$ eigenvalues and eigenvectors that satisfy the following equation:

$$Av_i = \lambda_i v_i\text{ for } i = 1, 2, \cdots, n$$

[//]:# (Equation 8)

Then we can think of the matrix $V\in\Bbb{R}^{n\times n}$, which collects all the eigenvectors, as follows:

$$V = \begin{bmatrix}    | &  | & \text{ } &  | \\    v_1 & v_2 & \cdots & v_n \\    | &  | & \text{ } &  | \end{bmatrix}$$

[//]:# (Equation 9)

Using equation (8), we can express the relationship between matrix $A$ and matrix $V$ as follows:

$$AV =  \begin{bmatrix}    | &  | & \text{ } &  | \\   \lambda_1 v_1 & \lambda_2 v_2 & \cdots & \lambda_n v_n \\    | &  | & \text{ } &  | \end{bmatrix}
$$

[//]:# (Equation 10)

If we think of the matrix $\Lambda \in \Bbb{R} ^{n \times n}$, which collects all the eigenvalues on the diagonal, as follows:

$$\Lambda = \begin{bmatrix}\lambda_1 & 0 & \cdots & 0 \\ 0 & \lambda_2 & 0 & 0 \\ \text{ } & \text{ } & \ddots & \text{ } \\ 0 & 0 & \cdots & \lambda_n\end{bmatrix}$$

[//]:# (Equation 11)

Using the relationship shown in equations (2) and (3), we can write equation (10) as follows:

$$Equation\ (10) \Rightarrow AV = V\Lambda$$

[//]:# (Equation 12)

If all eigenvectors are linearly independent, we can express matrix $A$ as follows using equation (12):

$$A = V\Lambda V^{-1}$$

[//]:# (Equation 13)

## Geometric interpretation of eigendecomposition

Eigendecomposition shows that a linear transformation represented by a matrix can be decomposed into three processes: 'rotate', 'stretch', and 'rotate'.

To understand the geometric interpretation of eigendecomposition, let's try to eigendecompose the following matrix A:

$$A = \begin{bmatrix}1.2 & -0.5 \\ -1.5 & 1.7\end{bmatrix}$$

First, let's visualize the linear transformation of matrix $A$ as shown below:

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A/" width="300" height = "240" frameborder="0"></iframe><br>
Animation 1. Linear transformation of matrix A</p>

The eigenvalues and eigenvectors of the above matrix are as follows:

$$\lambda = 0.5486 \text{ or } 2.3514$$

$$\vec{v}_1 = \begin{bmatrix}0.6089 \\ 0.7933\end{bmatrix}$$

$$\vec{v}_2 = \begin{bmatrix}-0.3983 \\ 0.9172\end{bmatrix}$$

If we write out the matrices used to decompose the matrix $A$ using its eigenvalues and eigenvectors as in equation (14), they are as follows.

$$V = \begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix}$$

$$\Lambda = \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}$$

$$V^{-1} = \begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}$$

We can think of matrix $A$ as being split into the following:

$$A = V\Lambda V^{-1} \notag$$

$$\Rightarrow \begin{bmatrix}1.2 & -0.5 \\ -1.5 & 1.7\end{bmatrix}=\begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix} \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}\begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}$$

The following is the linear transformation of matrix $V$ composed of eigenvectors.

If you look closely, the linear transformation of matrix $V$ shows a form similar to rotation because all the column vectors in $V$ are eigenvectors, which represent only direction and have a length of 1.

Therefore, since two vectors starting from the origin and having a length of 1 are pointing in different directions, it can perform a rotation-like transformation.

However, it cannot be completely the same as a rotation transformation because all the length of the basis vectors after transformation are not the same, and there is a possibility of being flipped during the transformation.

In addition, it should be noted that the angles between the basis vectors of V after transformation do not form 90 degrees.

$$V = \begin{bmatrix}0.6089 & -0.3983 \\ 0.7933 & 0.9172\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_V/" width="300" height = "240" frameborder="0"></iframe><br> Animation 2. Linear transformation of V</p>

The linear transformation of the diagonal matrix $\Lambda$, which consists of eigenvalues as diagonal elements, is shown below. Since only diagonal elements exist, it can be seen that only transformation that expands or contracts in the up-down or left-right directions is shown.

$$\Lambda = \begin{bmatrix}0.5486 & 0 \\ 0 & 2.3514\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_D/" width="300" height = "240" frameborder="0"></iframe><br> Animation 3. Linear transformation of $\Lambda$</p>

The linear transformation of the inverse matrix $V^{-1}$, composed of eigenvectors, is shown below.

The linear transformation of $V^{-1}$ also shows a rotation-like shape similar to $V$. However, it can be seen that it rotates in the opposite direction to $V$.

$$V^{-1} = \begin{bmatrix}1.0489 & 0.4555 \\ -0.9072 & 0.6963\end{bmatrix}\notag$$

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_Vinv/" width="300" height = "240" frameborder="0"></iframe> <br> Animation 4. Linear transformation of $V^{-1}$</p>

If the linear transformations of $V^{-1}$, $\Lambda$, and $V$ are applied in order, it can be seen that they are the same as the original linear transformation $A$.

The three slides in the applet below correspond to $V$, $\Lambda$, and $V^{-1}$, respectively.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_A_decomposed/" width="320" height = "265" frameborder="0"></iframe><br> Animation 5. Apply linear transformations of $V$, $\Lambda$, and $V^{-1}$ independently.</p>


# Eigenvalue decomposition of symmetric matrices

There is a slightly unique point in the eigenvalue decomposition of symmetric matrices compared to that of general square matrices. This is because symmetric matrices show the property that their eigenvectors are orthogonal to each other.

A symmetric matrix is a matrix that satisfies the following property:

$$A=A^T$$

If the matrix $A$ can be decomposed into eigenvalues as in Equation (13), the following can be derived:

$$A = V\Lambda V^{-1} = A^T = (V\Lambda V^{-1})^T = (V^{-1})^T\Lambda^TV^T$$

Here, since $\Lambda$ is a diagonal matrix, $\Lambda^T = \Lambda$ and $(V^{-1})^T = (V^T)^{-1}$, Equation (16) can also be written as follows.

$$V\Lambda V^{-1} = (V^T)^{-1}\Lambda V^T$$

Therefore, the matrix $V$ consisting of eigenvectors of a symmetric matrix is an orthogonal matrix. In other words, the following holds.

$$V^T = V^{-1}$$

and

$$VV^T = V^TV = I$$

Thus, a symmetric matrix can be decomposed into eigenvalues and eigenvectors as follows.

$$A= V\Lambda V^T$$

Generally, the matrix $Q$ is often used instead of $V$ to denote the matrix that collects the eigenvectors of a symmetric matrix $A$, such that

$$A = Q\Lambda Q^T$$

when $A$ is a symmetric matrix.

## Geometric interpretation of eigenvalue decomposition of a symmetric matrix

To understand the geometric interpretation of eigenvalue decomposition of a symmetric matrix, let's try to decompose the matrix A below into eigenvalues and eigenvectors.

$$A = \begin{bmatrix}2 & 1 \\ 1 & 2\end{bmatrix}$$

First, if we visualize the linear transformation of matrix $A$, it looks like the following.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_sym_A/" width="300" height = "240" frameborder="0"></iframe><br>
Animation 6. Linear transformation of matrix A</p>

The eigenvalues and eigenvectors of the matrix are as follows.

$$\lambda = 1 \text{ or } 3$$

$$\vec{q}_1 = \begin{bmatrix}0.7071 \\ -0.7071\end{bmatrix}$$

$$\vec{q}_2 = \begin{bmatrix}0.7071 \\ 0.7071\end{bmatrix}$$

When we use the eigenvalues and eigenvectors of matrix $A$ to decompose matrix $A$ as in equation (13), the matrices we need are as follows:

$$Q = \begin{bmatrix}0.7071 & 0.7071 \\ -0.7071 & 0.7071\end{bmatrix}$$

$$\Lambda = \begin{bmatrix}1 & 0 \\ 0 & 3\end{bmatrix}$$

$$Q^T = \begin{bmatrix}0.7071 & -0.7071 \\ 0.7071 & 0.7071\end{bmatrix}$$

From the perspective of eigenvalues and eigenvectors, the difference between a general square matrix and a symmetric matrix is that the eigenvectors of the symmetric matrix are orthogonal to each other.

Therefore, when linearly transformed by matrix $Q$, we can observe the result similar to rotating the vector space, as the length of the basis vectors remain 1 and they are orthogonal to each other even after the linear transformation. (The reason we say "similar to rotating" is that the eigenvectors of matrix $Q$ may be flipped depending on the position of the column vectors of $Q$.)

Thus, the matrix $Q$ obtained by collecting the eigenvectors of the symmetric matrix has a similar meaning to a rotation matrix.

By applying linear transformations of $Q^T$, $\Lambda$, and $Q$ in order, we can obtain the original linear transformation $A$.

The three slides in the following Applet correspond to $Q$, $\Lambda$, and $Q^T$, respectively.

<p align="center"><iframe  src="https://angeloyeo.github.io/p5/2020-11-19-eigen_decomposition/linear_transformation_sym_A_decomposed/" width="320" height = "265" frameborder="0"></iframe><br> Animation 7. Let's apply linear transformations $Q$, $\Lambda$, and $Q^T$ independently.</p>
