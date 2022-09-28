# CSA Chapter 7 : 마이크로 프로그램된 제어(Microprogrammed Control)

### 1. 제어 메모리(Control Memory)
- 하드와이어 제어 장치
	- 하드웨어적으로 제어 장치를 설계
	- 일상적인 놀리회로를 구현하여 구현
- 제어 워드
	- 버스 구조 시스템에서 정보 전달 제어 비트 모임
	- 제어 워드에 의하여 마이크로 연산 수행
- 마이크로 프로그램
	> 명령어들을 수행하는데 공통적으로 사용되는 워드들을 정의하고 묶어서 일괄적으로 저장하고 제어하는 프로그램
	- 명령을 수행하는 일련의 제어워드의 집합
	- 별도의 기억장치에 저장된 프로그램 형태
- 마이크로프로그램된 제어 장치
	- 마이크로 프로그램을 사용하는 제어 장치
	- ROM에 저장하여 사용
	- 시퀀서(Sequencer)와 제어 메모리로 구성
		> 시퀀서 : 수행해야할 제어워드의 주소를 결정
### 2. 주소 시퀀싱(Address Sequencing)
- 초기 주소
	- 시스템 부트시 jump하는 주소
	- ROM BIOS주소
		> 일반적으로ROM BIOS주소
	- 하드웨어적으로 미리 결정된 주소
	- IBM PC : 0xFFFE0 (20bit XT)
- 제어 메모리 주소 시퀀싱 단계
	- 명령어fetch
	- 유효주소(EffectiveAddr.) 계산
	- **마이크로연산 수행을 위한 제어 워드 fetch**
		> control memory에서 가져와야 함
		>> CAR(control address register)값에 의해서 접근
	- 명령어 실행
- 제어 메모리의 주소 결정하는 방법
	- Branch by condition
	- Mapping from Opcode
	- Subroutine call/return
	- Increment

	[이미지 자리: 시퀀서 구조]
- 조건부 분기(branch by condition)
	- 상태비트(U, I, S, Z)에 따른 분기
- 명령어의 매핑(mapping from opcode)
	- Opcode로부터 제어워드 주소 분기
	- 제어 메모리 크기(비트수)에 맞는 매핑 논리 사용
	- 명령어에 사용되는 제어 워드수에 따라서 매핑
	- 매핑비트의 결정
		- 제어메모리 크기 : 128 --> 2^7(7bit)
			> CAR을 의미  
			> opcode 좌측으로 1bit, 우측으로 2bit 를 추가하여 7자리 주소 완성
		- 명령어가 가지는 제어 워드 최대크기가 3인 경우
			> 동일 명령어의 타이밍에 따른 제어비트가 필요하므로 우측 2bit는 T5이상의 타이밍일때의 주소로 저장
			>ex. T4 : 00, T5 : 01, T6 : 10, T7: 11 / 총 4가지 경우의 제어메모리 주소
		- 2^1 < 3 < 2^2 이므로 2비트 간격으로 제어 메모리 배치
- 서브루틴(subroutine)
	- 동일한 제어 코드들을 서브루틴화
	- fetch제어, 간접주소 계산 등
		> 모든 명령어들이 반드시 수행해야 하는 fetch
	- SBR에 복귀 제어메모리 주소 저장
### 3. 마이크로 프로그램의 예(Microprogram Example)
- 마이크로 프로그램 제어를 위한 하드웨어 구성
	- 128 x 20제어 메모리 사용
		> Control memory
		- 128개의 제어워드 사용
		- 20bit의 제저워드로 구성
- 컴퓨터 명령어 형식
	- 마이크로 프로그래밍을 위한 명령어 형식
		```
		Symbol		Opcode	Description
		----------------------------
		ADD		0000	AC <-- AC + M[EA] (EA: effective address)
		BRANCH		0001	If(AC < 0) then PC <-- EA
		STORE		0010	M[EA] <-- AC
		EXCHANGE	0011	AC <-- M[EA], M[EA] <-- AC
		```
- 마이크로 명령어 형식
	- `F1(3bit) | F2(3bit) | F3(3bit) | CD(2bit) | BR(2bit) | AD(7bit)`
	- F1, F2 ,F3 : Microoperation fields
		> 명령어들을 설계자에 따라 3가지 그룹으로 나눌 수 있음
			>> 3가지 그룹을 각각 표현할 수 있기 때문에 각 그룹은 동시에 수행될 수 있게 됨  
			>> 따라서 각 그룹은 동시에 수행되면 안되는 명령어들로 묶는 것이 좋음
	
	[이미지 자리 : microoperation그룹]
	- CD : Condition for branching
		```
		CD	Condition	 Symbol	Comments
		-------------------------------------------
		00	Always = 1	U	Unconditional branch
		01	DR(15)		I	Indirect address bit
		10	AC(15)		S	Sign bit of AC
		11	AC = 0		Z	Zero value in AC
		```
	- BR : Branch field
		```
		BR	symbol	Function
		--------------------------------------
		00	JMP	CAR <-- AD if condition = 1
				CAR <-- CAR + 1 if condition = 0
		01	CALL	CAR <-- AD, SRB <-- CAR + 1 if condition = 1
				CAR <-- CAR + 1 if condition = 0
		10	RET	CAR <-- SBR (Return from subroutine)
		11	MAP	CAR(2-5) <-- DR(11-14), CAR(0,1,6) <-- 0
		```
	- AD : Address field
- 기호로 표시된 마이크로 명령어
	- fetch 루틴
		```assembly
		AR <-- PC
		DR <-- M[AR], PC <-- PC + 1
		AR <-- DR(0-10), CAR(2-5) <-- DR(11-14), CAR(0,1,6) <-- 0

			ORG 64
		FETCH:	PCTAR		U	JMP	NEXT
			READ, INCPC	U	JMP	NEXT
			DATAR		U	MAP
		```
		- fetch명령 이진 표시 예
			```
			Binary Address	F1	F2	F3	CD	BR	AD
			-----------------------------------------------------------
			10000000	110	000	000	00	00	10000001
			10000001	000	100	101	00	00	10000010
			10000010	101	000	000	00	11	00000000
			```
	- indirect 루틴
		```assembly
		INDRCT:	READ	U	JMP	NEXT
			DRTAR	U	RET
		```
### 4. 제어 장치의 설계(Design of Control Unit)
