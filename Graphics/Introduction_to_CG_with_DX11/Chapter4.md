# Chapter4. 레스터화의 원리

## [벡터](Vector.md)와 포인터

- 일반적인 벡터
	- $\vec{a}, \vec{b}$ : 위치 벡터와 벡터

- 그래픽스 수학
	 > "Interactive Computer Graphics" by Edward Angel
	- $P, Q, R$: 포인트 (point. 위치)
	- $u, v, w$: 벡터 (vector)
	- $\alpha, \beta, \gamma$ : 스칼라(scalar)
	- **$a$** : 벡터를 행렬로 표기할 경우
	- **$M$** : 행렬

- 포인트
	- 위치만 표현
	- 예) 철수의 위치, 영희의 위치

- 벡터
	- 방향과 크기 효현
	- 예) 속도, 힘

 - 포인트 - 벡터 연산
	 - $포인트 - 포인트 = 벡터$
	 - $포인트 + 벡터 = 포인트$
	 - $포인트 - 벡터 = 포인트$   
		> **⚠️ Warning**
		> 대부분의 API에서는 포인터와 벡터를 구분해서 구현하지 않음

- 직선 (Line) 
	> $\alpha$ 값을 바꿔가면서 직선위의 모든 점을 표현가능

$$
P(\alpha) = P_0 + \alpha d
$$

- 선분 (Line Segment)
> 직선의 일부분 ($\alpha$ 가 0 ~ 1 사이값)
>> $\alpha$가 0일 경우 : $P_0$
>> $\alpha$가 1일 경우 : $Q$

$$
\begin{aligned}
P(\alpha) &= P_0 + \alpha(Q - P_0) \\
&= P_0 + \alpha d \\
&= (1 - \alpha)P_0 + \alpha Q
\end{aligned}
$$

- Affine Combination (Affine Sum)
	- 여러개의 포인트를 스칼라배한 후에 더해준 표현식 
	- 이때, 포인트의 계수들의 총합은 반드시 1이어야 함
	 > 계수들이 일종의 가중치로 작용
 
$$
\begin{aligned}
P(\alpha) = (1 - \alpha)P_0 + \alpha Q \\
0 \leq \alpha \leq 1
\end{aligned}
$$

- 행렬 벡터
	-  2차원에서는 숫자 2개, 3차원에서는 숫자 3개
	- $u = (1, 2, 3)$
	- $u = \begin{bmatrix} 1\\\2\\\3 \end{bmatrix} = \begin{bmatrix} 1&2&3 \end{bmatrix}^T$
	 > T : Transpose (전치행렬)

- Homogeneous Coordinates (동차좌표)
	- $u = \begin{bmatrix} 1\\\2\\\3\\\0 \end{bmatrix}$ : 벡터
	- $u = \begin{bmatrix} 1\\\2\\\3\\\1 \end{bmatrix}$ : 포인트
	 > 행렬의 마지막 값이 0이면 벡터, 아니면 포인트(보통 1)

## 레스터화가 빠른 이유

- 레이 트레이싱
	- 모든 픽셀에 대해서 최소 한 개의 Ray에 대한 연산이 필요함
	- Anti-aliasing을 적용하거나 물체의 갯수가 많아지면 그에 따라 Ray의 수도 늘어남

- 레스터화
	1. 3차원 상의 삼각형은 3개의 정점(vertex)로 정의할 수 있음
	2. 3개의 정점을 2차원 스크린으로 투영(project) 시킴
	3. 2차원 평면 상으로 투영된 삼각형안에 있는 픽셀에 대해서만 연산 수행
	4. 해당 영역을 설정하기 위해 삼각형을 포함하는 가장 작은 직사각형을 구함(바운딩 박스)
	5. (xmin, ymin) 과 (xmax, ymax) 로 박스 사이즈를 정의 

```c++
//@Raytracing(광추적)
for pixels
	for objects
		getPixelColor();

//@Rasterizaion(레스터화)
for objects
	for pixels
		getPixelColor();
```

## 무게 중심 좌표계(Bary-Centric Coordinates)