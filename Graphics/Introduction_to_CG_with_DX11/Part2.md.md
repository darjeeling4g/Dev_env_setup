# Part2. Realtime Pipeline

## Chapter4. 레스터화의 원리

### [벡터](Vector.md)와 포인터

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
  
		>**⚠️ Warning**
		> 대부분의 API에서는 포인터와 벡터를 구분해서 구현하지 않음


$$
\vec{a}\over\vert\vec{a}\vert
$$