# CSA Chapter 8 : 중앙처리장치
### 1. 범용 레지스터 구조(General Register Organization)
- 기억장치
	> 5장에서 주로 다뤘던 레지스터를 이야기함
	- 레지스터 집합
	- 데이터 임시 저장 장소
- 제어장치
	> 5-7장까지 cpu제어를 위한 제어장치 설계를 다뤘음
	>> 게이트, 논리회로, 와이어 등으로 구성됨
	- cpu명령어 처리 회로의 집합
	- 논리 게이트와 요소들로 구성
	- 명령어에 따라서 연산 제어 수행
- 연산장치
	> 8장에서 어떤 기능을 수행하는지 상세히 다룸
	- ALU
	- 산술 연산, 논리 연산 및 시프트 연산 수행
- 공용 ALU를 가진 레지스터 집합
	> ALU관점에서 CPU의 동작은 어떤 레지스터로부터 데이터를(source) 가져와서, 어떤 작업을 처리하고 어떤 레지스터로 내보낼 것이가(destination)
	- 7개의 범용 레지스터
	- 3x8 디코더 1개
	- 8x1 MUX 2개
	- ALU
- 제어 워드 집합
	- SELA, SELB : ALU 입력 결정
		> 각 셀렉트 비트는 8개의 입력(7개 레지스터, 1개 외부입력)중 한개를 선택하기 위해서 3bit로 MUX를 제어
	- SELD : ALU 출력 저장소 결정
		> 디코더에 3bit 입력을 통해 어떤 레지스터의 LD입력을 활성화 시킬것 인지 결정
		>> LD입력이 활성화 된 레지스터로 데이터가 저장됨
	- OPR : 연산의 종류 지정
		> 5bit로 2항연산 단항 연산등을 결정
	- 3bit(SELA) 3bit(SELB) 3bit(SELD) 5bit(OPR) 의 구성
		- ex) R1 <-- R2 + R3  
		010(R2) 011(R3) 001(R1) 00010(ADD)
- 레지스터와 연산 인코딩
```
code	SELA	SELB	SELD
----------------------------
000	Input	Input	None
001	R1	R1	RI
010	R2	R2	R2
011	R3	R3	R3
100	R4	R4	R4
101	RS	RS	RS
1R6	10	R6	R6
1R7	11	R7	R7
```
```
Select	Operation	Symbol
------------------------------
00000	Transfer A	TSFA
;입력을 그냥 바로 통과시키는 연산
00001	Increment A	INCA
;1 증가시킴
00010	Add A + B	ADD
00101	Subtract A - B	SUB
00110	Decrement A	DECA
;1 감소시킴
01000	AND A and B	AND
01010	OR A and B	OR
01100	XOR A and B	XOR
01110	Complement A	COMA
;보수화
10000	Shift right A	SHRA
11000	Shift left A	SHLA
```
- 마이크로 연산의 예
	- R1 <-- R2 - R3
	- R2 R3 R1 SUM
	- 010 011 001 00101
### 2. 스택구조(Stack Organization)
- 레지스터 스택
	> 메모리의 일부를 사용하거나 레지스터 여러개로 구현가능  
	> DR(data register) : 스택에 쌓으려고 하는 데이터가 저장되어 있음  
	> SP(stack pointer) : 스택의 가장 위의 주소가 담겨있음  
	> FULL : 스택이 가득 찼을경우 1을 가짐  
	> EMTY : SP가 0을 가지고 있을경우 = 스택이 비어있을 경우 0을 가짐
	
	- PUSH 동작
		- SP <-- SP +1
		- MISP] <-- DR
		- If (SP = 0) then (FULL <-- 1)
		- EMPTY <-- 0
	- POP 동작
		- DR <-- MISPI
		- SP <-- SP - 1
		- If (SP = 0) then (EMPTY <-- 1)
		- FULL <-- 0
- 메모리 스택
	> 메인메모리의 일부를 스택영역으로 할당하여 사용
	- PUSH 동작
		- SP <-- SP - 1
			> 스택이 내려가는 방향으로 구현할 수도 있음(downward grow stack)
		- M[SP] <-- DR
	- POP 동작
		- DR <-- M[SP]
		- SP <-- SP + 1
- 메모리 세그먼트
	> 1개의 프로세스를 구동시키기 위해서는 반드시 아래 3가지 세그먼트를 포함시켜야 함
	- code / data/ stack(heap)
		> code segment : 명령어 즉 프로그램이 들어가는 공간  
		> data segment : 프로그램에 사용되는 데이터가 들어가는 공간
	- 세그먼트의 크기
		- MS-DOS/Window : 64KB
		- UNIX/Linux : N x 1KM블록
- 스택 오버플로우
	> 스택이 커져서 다른영역을 침범할때 에러를 발생시킴
	- 스택의 크기를 벗어나는 SP값
	- Protected mode 에서 발생
- 연산자 표기 방식
	- Infix
		- A + B
	- Prefix(polish)
		- + A B
	- Postfix(reverse polish)
		- A B +
- 역 Polish 표기
	- A * B + C * D --> A B * C D * +
-- 연산자 표기 방식
	- Infix
		- A + B
	- Prefix(polish)
		- + A B
	- Postfix(reverse polish)
		- A B +
- 역 Polish표기
	- A * B + C * D --> A B * C D * +
- 스택 기반의 산술식의 계산
	- (3 * 4) + (5 * 6) --> 34 * 56 * +
		> 데이터를 먼저 가져오고 연산을 수행하기 위함
		>> 연산을 수행하기 위해서는 먼저 2개의 데이터를 가지고 있어야함
### 3. 명령어 형식(Instruction Format)
- 단일 누산기 구조
	> AC를 사용하는 구조
	- ADD X
	- AC <-- AC + M[X]
- 범용 레지스터 구조
	> 모든 operand를 표기하는 방식
	- ADD R1, R2, R3 = R1 <-- R2 + R3
	- ADD R1, R2 = R1 <-- R1 + R2
	- MOV R1, R2 = R1 <-- R2
	- ADD R1, X = R1 <-- R2 + M[X]
- 스택구조
	> 스택방식을 사용 : 스택의 가장 위의 데이트를 사용
	- PUSH X
	- ADD
- 3주소 명령어
	> source, destination을 모두 표시하는 명령어
	```assembly
	ADD R1, A, B	;R1 <-- M[A] + M[B]
	ADD R2, C ,D	;R2 <-- M[C] + M[D]
	MUL X, R1, R2	;M[X] <-- R1 * R2
	```
- 2주소 명령어
	> 2개의 레지스터만 표시하는 명령어
	```assembly
	MOV R1, a
	ADD R1, B
	MOV R2, C
	ADD R2, D
	MUL R1, R2
	MOV X, R1
	```
- 1주소 명령어
	> 항상 AC를 사용하는 명령어
	```assembly
	LOAD A
	ADD B
	STORE T
	LOAD C
	ADD D
	MUL T
	STORE X
	```
- 무주소 명령어
	> 스택을 사용하는 명령어
	```assembly
	PUSH A
	PUSH B
	ADD
	PUSH C
	PUSH D
	ADD
	MUL
	POP X
	```
- RISC 명령어
	> 모든 데이터를 레지스터에 미리 담아놓고 레지스터끼리만 연산하는 방식
	>> 데이터를 로드하고 저장할때만 메모리에 접근하고 연산할때는 메모리에 접근하지 않음
	```assembly
	LOAD R1, A
	LOAD R2, B
	LOAD R3, C
	LOAD R4, D
	ADD R1, R1, R2
	ADD R3, R3, R4
	MUL R1, R1, R3
	STORE X, R1
	```
### 4. 어드레싱 모드(Addressing Mode)
- 다양한 어드레싱 모드의 사용 이유
	- Pointer counter indexing 기능 제공
	- 프로그램 재배치(relocation)편의 제공
		- 프로그램 융통성 제공
	- 명령어 주소 필드 최소화
- 명령어 형식 with mode filed
	> 명령어의 모드를 나타내는 mode라는 필드가 추가로 존재함
	- I : opcode : mode : address
- Implied 모드
	- 피연산자가 묵시적으로 정의
	- AC, 또는 스택에 피연산자 위치
- Immediate 모드
	- 피연산자가 명령어 자체에 있음
	- 상수를 레지스터에 초기값으로 주는 경우 사용
- 레지스터(직접)모드
	- CPU내 레지스터에 피연산자 존재
- 레지스터 간접 모드
	- 명령어가 피연산자의 주소를 가지고 있는 레지스터를 지정
	- 직접 주소보다 적은 어드레스 비트 사용
- 자동증가 / 자동감소 모드
	- 메모리리 접근 후, 레지스터 값이 자동으로 증가/감소
- 직접 주소 모드
	- 명령어의 주소 부분이 유효주소(EA)를 표시
	- 분기 명령에서는 실제 분기 주소 표시
- 간접 주소 모드
	> 5장에서 이야기한 간접주소모드가 이에 해당
	>> 아래 나머지 3가지는 다른 방식의 간접주소 모드
	- 명령어 주소 부분에 유효주소를 지정하는 주소 표시
	- 다양한 간접주소 모드 사용
	- 유효주소의 계산
		- 유효주소(EA) = 명령어 주소 부분(ADDR) + cpu내 특정 레지스터 값
- 상대 주소 모드
	> OS단에서 주로 사용
	- 유효주소 = 주소 필드값과 프로그램 카운터값의 합(EA = ADDR + PC)
- 인덱스 어드레싱 모드
	- 유효주소 = 주소 필드값과 인덱스 레지스터값의 합(EA = ADDR + XR)
	- 배열의 각 원소에 대한 인덱스 주소 계산에 사용
		> XR: array의 시작주소를 가지고 있음 / ADDR : index값
- 베이스 레지스터 어드레싱 모드
	- 유효주소 = 주소필드값과 베이스 레지스터 값의 합(EA = ADDR + BR)
	- Protected 모드의 메모리에서 세그먼트 주소 인덱싱에 사용
		> BR : Segment의 시작주소를 가지고 있음
		>> code / data / stack(heap)
### 5. 데이터 전송과 처리(Data Transfer and Manipulation)
- 데이터 전송 명령어와 주소 모드
```assembly
LD ADR		;Direct address
LD @ADR		;Indirect address
LD $ADR		;Relative address
LD #ADR		;Immediate operand
LD ADR(X)	;Index addressing
LD R1		;Register
LD (R1)		;Register indirect
LD (R1)+	;Autoincrement
```
- 데이터 처리 명령어
	> ALU에서 사용하는 operation
	- 산술 명령어  
	[이미지 자리]
	- 논리 연산 및 비트 처리 명령어  
	[이미지 자리]
	- 시프트 명령어  
	[이미지 자리]
### 6. 프로그램 제어(Program Control)
- 상태 비트 조건
	- C (ALU 출력 캐리값)
	- S (AC의 부호비트)
	- Z (AC값의 zero여부)
	- V (연산 결과 오버플로우 여부)
		> C7 와 C8의 합으로 결정
- 상태비트의 예
	- A = 11110000 B = 000101000
		- A : 11110000
		- B' + 1 : 11101100
		- A - B : 11011100
		###### C = 1 / S = 1/ V = 0 / Z = 0
- 조건부 분기 명령어

	[이미지 자리]
	- 상태비트에 따라서 분기
		> C, S, V, Z의 값에 따른 8가지 케이스가 있음
	- 2개 값의 비교를 통한 분기
		> >, <, <=, >=, ==, != : 6가지
		>> signed인경우와 unsigned인 경우로 각각 나누어짐
- 서브루틴 Call
	```
	SP <-- SP - 1			;Decrement stack pointer
	M[SP] <-- PC			;Push content of PC onto the stack
	PC <-- effective address	;Transfer control to the subroutine
	```
- Return
	```
	PC <-- M[SP]		;Pop stack and transfer to PC
	SP <-- SP + 1		;Increment stack pointer
	```
- 순환 서브루틴(Recursive subroutine)
	- 서브루틴이 자기 자신을 호출
	- 순환 call이 return주소를 지워버리는 것을 방지하기 위형 스택에 return주소를 저장
- 프로그램 인터럽트
	- 서브루틴과의 차이점
		- 시스템 내, 외부적 신호에 의하여 프로그램 진행 변경
		- 인터럽트 처리 루틴의 주소는 하드웨어적으로 결정되어 있음
		- PC값만이 아니라 CPU의 다른 상태를 나타내는 정보도 대피(메모리에 저장)
	- PSW(program status word)
		> 현재 프로그램이 중단되고 다른 프로그램(BIOS)가 실행되어야 하기 때문에 현재 실행되는 프로그램에 대한 정보들은 저장(상태 조건 비트까지도)
		- 인터럽트가 발생될 때 저장하는 CPU정보
		- PSW로 저장되는 데이터
			1. 프로그램 카운터(PC)의 값
			1. 모든 레지스터의 값
			1. 상태 조건 비트(C, S, V, Z)
- 인터럽트의 형태
	- 외부 인터럽트
		- 입출력 장치, 타이밍 장치, 전원 등 외부 요소에 의하여 발생
	- 내부 인터럽트
		- 불법적인 명령이나 데이터를 사용할 때 발생
		- 오버플로우, divided by 0, segment falut등
	- 소프트웨어 인터럽트
		- 명령어의 수행에 의하여 발생
		- supervisor call명령, system call
### 7. 간소화된 명령어 집합 컴퓨터(RISC)
- RISC(Reduced instruction set computer)개요
	> 기존 시스템 대비 명령어가 매우 줄어든(reduced) 시스템  
	> PC를 제외한 대부분의 중대형 프로세서는 RISC방식을 사용하고 있음
	>> 명령어의 수가 늘어날수록 자연스럽게 제어장치 수는 많아질 수 밖에 없음  
	>> 이를 줄임으로써 효율적으로 설계가 가능해짐
	- 1980년, UC Berkeley David. A. Patterson교수가 설계
	- CISC(Complex Instruction Set Computer)에 비하여 새로운 설계 개념 제시
	- 새로운 마이크로 아키텍쳐와 명령어 구조 제시
	- MIPS, ALPHA, PowerPC, SPARC, PA-RISC
- CISC vs. RISC
	CISC|RISC
	---|---
	많은 수의 명령어| 상대적으로 적은 수의 명령어
	특별한 명령을 수행하는 일부 명령어느 자주 사용되지 않음 | 상대적으로 적은 수의 어드레싱 모드
	다양한 어드레신 모드 사용 | 메모리 참조는 load/store 명령으로만 제한
	가변 길이 명령어 형식 | 모든 동작은 CPU내 레지스터에서 수행
	메모리에서 피연산자 처리 | 고정된 길이의 명령어 형식 사용
	-|단일 사이클의 명렁어 실행
	-|하드와이어 제어방식 사용
- RISC 프로세서의 특징
	- 적은 수의 명령어로 인한 장점
		- 제어장치의 간소화로 여유 공간 확보
		- 많은 수의 레지스터(128개 이상)
		- 제어장치를 하드와이어 방식으로 구현
	- 효과적인 명령어 파이프라인 사용
		> 9장에서 관련내용을 다룰 예정
	- 프로시저의 빠른 호출/복귀를 위한 중첩된 레지스터 윈도우 사용
	- 빠르고 효과적인 구조의 컴파일러
	- 고정 길이 명령어 사용으로 간단한 디코딩
	- 단일 사이클의 명령어 실행
		> 클럭수를 극적으로 줄일 수 있기 때문에 발열, 전력소모, 안정성 측면에서 매우 유리하다
- 중첩된 레지스터 윈도우
	> 많은 수의 레지스터를 가지고 있기 때문에 각 프로시저가 배타적으로 특정 레지스터 그룹을 독자적으로 사용함
	>> 그 중 각 프로시저 간 공유하여 사용하는 레지스터 그룹도 존재한다  
	>> 이 공유 레지스터 공간을 통해서 데이터를 서로 주고받을 수 있음
	- 프로시저에 사용할 파라미터를 전달
	- 중첩된 윈도우를 통하여 보호모드에서 빠른 데이터 전달
	- 많은 수의 레지스터로 인한 구조적 장점
- Berkeley RISC I 명령어 구조
	> 3개의 명령어 만 존재한다  
	> 명령어의 길이가 모두 32bit로 동일
	> register mode 명령어는 주소에 대한 정보가 없음(register만으로 연산을 수행하므로)
	- opcode(8bit) : Rd(5bit) : Rs(5bit) : 0(1bit) : Not used(8bit) : S2(5bit)
		> Rd : register destination / Rs : register source  
		> Register mode
	- opcode(8bit) : Rd(5bit) : Rs(5bit) : 1(1bit) : S2(13bit)
		> Register-immediate mode
	- opcode(8bit) : COND(5bit) : Y(19bit)
		> PC relative mode

