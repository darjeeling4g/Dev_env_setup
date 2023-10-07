# CSA Chapter 9 : 파이프라인과 벡터처리(Pipeline and Vector Processing)
### 1. 병렬처리(Parallel Processing)
- 다중 기능 장치를 가지는 프로세서
	- 공통 프로세서 레지스터와 다중 연산 유닛
	- 동시에 2개 이상의 연산 처리
- 병렬처리의 종류(Flynn의 분류)
	> 대부분 SIMD MIMD인 경우가 많음
	- SSID(single instruction single datastream)
	- SIMD(single insturction multiple datastream)
	- MISD(multiple instruction single datastream)
	- MIMD(multiple instruction multiple datastream)
- Pipelining
	> 한번의 클럭동안 동시에 여러가지 동작을 처리
	- 다단계 데이터 처리 방식
	- 동시 다중 데이터 처리
### 2. 파이프라인(Pipelining)
- 하나의 프로세서를 서로 다른 기능을 가진 세그먼트로 분할
- 각 세그먼트가 동시에 서로 다른 데이터 처리
	- Ai * Bi + Ci, i = 1, 2, 3...
	- R1 <-- Ai, R2 <-- Bi
	- R3 <-- R1 * R2, R4 <-- Ci
		> R3에 연산값이 들어가면 R1, R2는 불필요해짐
		>> 이러한 낭비를 줄이기 위해 R3동작을 수행하는 동안 R1, R2에 새로운 값을 로드하는 동작을 동시에 수행하는 것을 고려해볼 수 있음
	- R5 <-- R3 + R4
	```
	Clock Pulse	Segment1	Segment2	Segment3
	Number		R1	 R2	R3 	R4	R5
	---------------------------------------------------------
	1		A1	 B1	- 	-	-
	2		A2	 B2	A1*B1	C1	-
	3		A3	 B3	A2*B2	C2	A1*B1 + C1
	4		A4	 B4	A3*B3	C3	A2*B2 + C2
	5		A5	 B5	A4*B4	C4	A3*B3 + C3
	6		A6	 B6	A5*B5	C5	A4*B4 + C4
	7		A7	 B7	A6*B6	C6	A5*B5 + C5
	8		-	 -	A7*B7	C7	A6*B6 + C6
	9		-	 -	-	-	A7*B7 + C7
	```
	> 각 segment가 동시에 처리를 수행함에 따라서 필요한 클럭수가 줄어들게 됨
- 파이프라인의 효율
	- S = (n * tn) / ((k+n-1) * tp)
- 최대 효율
	- S = (k * tp) / tp = K
	> tn : 각 태스크를 완료하는 시간  
	> tp : clock 사이클 시간  
	> k : 세그먼트 수  
	> n : 태스크의 수
### 3. 산술 파이프라인(Arithmetic Pipeline)
- 실수의 가산
	- X = A * 2^a
	- Y = B * 2^b
- 세그먼트별 연산
	- 지수의 비교
	- 가수의 정렬
	- 가수의 연산
	- 결과의 정규화
### 4. 명령어 파이프라인(Instruction Pipeline)
- 명령 실행의 순차
	1. 메모리에서 명령어 fetch
		> segment 1(1)
	1. 명령어 디코딩
	1. 유효주소의 계산
		> segment 2(2,3)
	1. 메모리에서 피연산자 fetch
		> segment 3(4)
	1. 명령어 실행
	1. 연산 결과의 저장
		> segment 4(5,6)
- 4세그먼트 CPU파이프라인
- 명령어 파이프라인의 4세그먼트
	1. FI(fetch instruction)
	1. DA(decode and address)
	1. FO(fetch operand)
	1. EX(execution)
- 명령어 파이프라인의 지연
	> 특정 원인에 의해서 파이프 라인이 깨진 상태 / 정상적으로 동작하지 않는 상태
	>> 한개의 동작이 끝날때까지 지연되게 됨
	- 원인
		- 자원 충돌(Resource conflict)
			> 동일한 자원에 대해서 2곳에서 접근을 시도할때
		- 데이터 의존성(data dependency)
			> 사전에 먼저 선행되어야 하는 명령이 있을 때
		- 분기 곤란(branch difficulty)
			> 분기가 종료되어 원래 명령어로 돌아올때 까지 파이프라인을 채우지 않음
### 5. RISC파이프라인(RISC Pipeline)
- 3세그먼트 명령어 파이프라인
	- I : 명령어 fetch
	- A : ALU동작
	- E : 명령어의 실행
- 지연된 코드
	```assembly
	1. LOAD: R1 <-- M[address 1]
	2. LOAD: R2 <-- M[address 2]
	3. ADD : R3 <-- R1 + R2
	4. STORE: M[address 3] <-- R3
	```
	```assembly
	Clock cycle		1	2	3	4	5	6
	1. LOAD R1		I	A	E
	2. LOAD R2			I	A	E
	3. ADD R1 + R2				I	A	E
	; 4사이클 구간에서 데이터 의존성 문제 발생
	4. STORE R3					I	A	E
	```
	```assembly
	Clock cycle		1	2	3	4	5	6	7
	1. LOAD R1		I	A	E
	2. LOAD R2			I	A	E
	3. Non-operation			I	A	E
	; 지연된 코드로 문제 해결
	; 클럭만 한개 늘어나게 됨
	4. ADD R1 + R2					I	A	E
	5. STORE R3						I	A	E
	```
- 지연된 분기

	[이미지 자리]
	> 분기를 먼저 수행하고 먼저 수행되었어야 할 명령어를 이후에 수행하여 공백을 채움
- 해결
	- 정교한 컴파일러 사용 --> RISC컴파일러의 특징
	- 실행 순서 변경
	- 데이터 의존성 회피
### 6. 벡터 처리(Vector Processing)
- 벡터 처리
	- 행렬 데이터 처리
	- 병렬 데이터 처리
- 벡터 처리가 중요한 분야
	- 장기 기상 예보
	- 석유 탐사
	- 지진 데이터 분석
	- 의학 검진, 분석
	- 기계 역학, 비행 시뮬레이션
	- 인공지능, 전문가 시스템
	- 유전자 분석
	- 2/3차원 이미지 처리
- 벡터 연산
	- C(1:100) = A(1:100) + B(1:100)
- 벡터 명령어
	- `Operation code | Base address source 1 | Base address source 2 | Base address destination | Vertor length`
- 메모리 인터리빙(interleaving)
	- 두 개 이상의 명령어가 동시에 메모리를 접근하는 경우
	- 메모리를 여러 모듈로 분할 구성
		> 각각의 AR, DR사용
	- 파이프라인의 자원 충돌 문제 해결
- 슈퍼컴퓨터(super computer)
	- 정의
		- 벡터 명령어 제공
		- 파이프라인된 부동 소수점 산술연산 제공
		- 상업용 컴퓨터
	- 성능 요소
		- 고속의 연산을 위한 설계
		- 고속 위주의 소재, 부품 사용
	- Flop
		- 초당 처리할 수 있는 floating point 연산의 수
		- MFlop, Gflop 단위
- 대표적인 슈퍼컴퓨터
	- CRAY-1, CRAY-II, CARY X-MP
	- Fujitsu VP-200, VP-2600
> 최근에는 슈퍼컴퓨터에 집중하기 보다는 컴퓨터를 여러대 연결하여 클러스터 컴퓨터 --> 클라우드 컴퓨터 등으로 넘어가는 추세이다
### 7. 배열 프로세서(Array Processors)
- 부가 배열 프로세서
	- Backend프로세서 array사용
		- 대량의 데이터 처리 전담
		- Local memory에 데이터 저장
		- 트랜스퓨터 (transputer)라고도 지칭
	- Main프로세서
		- 데이터 전송 프로그램 실행
- SIMD배열 프로세서
	- Main CPU, Main memory에 다수의 PE연결
	- PE(Processing Element)
		- 자체 프로세서와 Local memory포함
		- Array프로세서 형태로 구현
- ILLIA-IV
	- 대표적인 초기 SIMD배열 프로세서
	- 미국 일리노이 대학 연구실 개발
	- 초기형 SIMD 슈퍼컴퓨터급 성능
