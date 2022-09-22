# CSA Chapter 5 : 기본 컴퓨터의 구조와 설계
### 1. 명령어 코드(Instruction Codes)
- 컴퓨터의 동작
	- 레지스터 내에 저장된 데이터에 대한 마이크로 연산의 시퀀스에 의하여 정의
	- 범용 컴퓨터 시스템에서는 다양한 마이크로 연산 시퀀스를 정의
- 명령어 코드
	- 컴퓨터에게 어떤 특별한 동작을 수행할 것을 알리는 비트들의 집합
	- 연산 코드들로 구성
- 컴퓨터 명령어
	- 컴퓨터에 대한 일련의 마이크로 연산을 기술
	- 이진 코드로 구성
	- 데이터와 함께 메모리에 저장
- 프로그램
	- 사용자가 원하는 연산과 피연산자가 처리되는 순서를 기술한 컴퓨터 명령어의 집합
	- 명령어 처리 과정을 제어
- 내장 프로그램
	- 제어 신호에 의하여 명령어의 이진 코드를 해석하여 실행
	- 명령어를 저장하여 실행하는 컴퓨터 구동 방식
- 저장(내장) 프로그램 구조
	- 명령어의 집합으로 구성
	- 각 명령어는 명령어 포맷(Insturction format)에 따라서 정의
		> 총 16bit로 구성(기본)
		>> 15 : I / 14-12 : opcode / 11-0 : address
		>>> I : address가 직접주소인지 간접주소인지 구분  
		>>> opcode : 기계 명령어  
		>>> address : 데이터가 저장된 주소
	- 프로그램 실행부분에 따라서 메모리의 다른 부분(segment)에 저장
		> code segment : instruction(program)이 저장되는 영역  
		> data segment : operands(data)가 저장되는 영역  
		> stack segment : 임시영역
	- 명령어 실행 결과는 AC에 저장
		> accumulator : 실행결과를 저장

			cpu메모리의 기본용량은 address의 최대값의 크기를 기본적으로 가진다(12bit --> 2^12)
- 간접주소(Indirect Address) 시스템
	- 많은 경우, 직접주소를 사용하여 데티어 지정
	- 필요한 경우, 간접주소로 데이터 지정
		> I bit == 0 : 직접주소 / I bit == 1 : 간접주소
### 2. 컴퓨터 레지스터(Computer Registers)
- 기본 컴퓨터의 레지스터
	- 기본 컴퓨터란?
		- DEC PDP-11 Mini Computer
		- 가상의 컴퓨터가 아닌 실제 제품
		- 1980년대 주력 메인프레임급
		- 최신의 CPU도 기본적으로 동일한 구조
	- 기본 컴퓨터 레지스터 종류
		- PC(program counter) : 12bit(address가 12bit이므로)
		- AR(address register) : 12bit
		- IR(instruction register) : 16bit
		- TR(temporary register) : 16bit
		- DR(data register) : 16bit
		- AC(accumulator) : 16bit
		- INPR(input register) : 8bit(주변장비 통신 bit수와 동일)
		- OUTR(output register) : 8bit
- 버스 시스템의 종류
	- 내부버스
		- CPU(컴퓨터)내부 레지스터 간 연결
	- 외부버스
		- CPU내부 레지스터 - 메모리간 연결
	- 입출력버스
		- CPU <--> 주변장치(I/O)연결
- 공통 버스 시스템
	- 내부 버스를 통칭
	- 내부 버스의 크기(Width)로 CPU 워드 크기 결정
		> 즉 한번에 이동 가능한 데이터의 크기를 의미
		- 16bit 컴퓨터 - 내부버스/레지스터 크기가 16bit
		- 32bit 컴퓨터 - 내부버스/레지스터 크기가 32bit
	- 전솔 연결 통로
		- 레지스터-레지스터 데이터 전송 통로
		- 레지스터-메모리 데이터 전송 통로(예외적 표현)
		- 한 순간에는 하나의 전송 신호만이 버스에 존재 가능
			- 2개 이상의 신호 발생시에는 버스 충동(collision)발생
			- 버스 제어기(정확한 타이밍과 MUX제어 수행)
	- 레지스터 출력은 버스의 MUX입력에 연결
		> 각 레지스터의 출력과 입력은 공통버스로 연결됨
	- 각 레지스터에 MUX입력번호 설정됨
	- 레지스터 입력은 버스에 직접 연결(LD로 제어)
		> 공통버스로 출력된 데이터는 broadcast되어 공통버스로 연결된 모든 레지스터에서 접근 가능해짐 --> 이후 LD입력을 통한 제어로 공통버스에 뿌려진 데이터를 읽어오게 됨
	- S2, S1, S0에 의하여 레지스터 출력 결정
- 버스의 동작
	- DR <-- AC, AC <-- DR  
	M[AR] <-- DR  
	AR <-- PC
### 3. 컴퓨터 명령어(Computer Instructions)
- 기본 컴퓨터 명령어의 종류
	- MRI명령 7가지
		> memory reference instruction  
		> 동일한 명령어이더라도 I값으로 직접명령인지 간접명령인지 나누어짐
	- RRI명령 12가지
		> register reference instruction  
		> I = 0 && opcode = 1 1 1 일때
	- IO명령 6가지
		> input/output instruction  
		> I = 1 && opcode = 1 1 1 일때
### 4. 타이밍과 제어(Timing and Control)
- 명령어 실행 타이밍 예  
D3T4 : SC <-- 0
- timing diagram(각 신호들의 타이밍을 표시한 그림)
### 5. 명령어 사이클(Instruction Cycle)
- 명령어 사이클 단계
	1. 메모리에서 명령어 가져오기(Fetch)
		> 메모리에서 IR로 명령어를 가져옴
	1. 명령어 디코딩
		> opcode에 따라 디코더에서 출력결정
	1. 유효주소(Effective Address)계산
		> 실제 operand가 위치한 주소를 결정하는 단계
	1. 명령어 실행
		> opcode에 의거해서 명령어 종류 파악 및 실행
- Fetch와 Decode  
	- T0 : AT <-- PC
		> T0 타이밍에 실행됨  
		> PC: 지금 가져와야할 명령어의 주소를 가지고 있음  
		> 메모리의 데이터를 읽어오기 위해서는 AR로 주소를 옮겨야 함
	- T1 : IR <-- M[AT], PC <-- PC + 1
		> T1 타이밍에 실햄됨  
		> AR에 주소가 담기게 되면 담긴 주소를 기반으로 데이터를 읽어 출력으로 나오게 됨  
		> 명령어가 IR에 담기고 나면 PC는 다음에 가져와야 할 명령어 주소를 가짐(주소상 바로 다음 주소 = +1)
	- T2 : D0 ... D7 <-- decode IR(12-14), AR <-- IR(0-11), I <-- IR(15)
		> T2타이밍에 실행  
		> decode를 통해 명령어 파악(D0~D7중 하나)  
		> I FF로 I-bit를 넘겨 간/직접주소 파악  
		> 데이터를가져오기 위해서 IR의 opcode를 제외한 부분을 AR로 보내게 됨  
		>> IR(16bit)에서 AR(12bit)로 12개의 버스만 연결되어 있어 자연스럽게 해당 부분만 load하게 된다
	##### 위의 T0 ~ T2까지의 과정을 fetch cycle이라고 하며, 모든 명령어는 반드시 해당 cycle을 포함한다(T0-T1: fetch단계/T2: decode단계)
- 명령어의 종류 결정
	> D7이 1인경우는 곧 opcode가 111이라는 의미이며 이는 RRI 또는 IO명령임을 나타냄  
	> 명령어 실행 마지막에는 항상 SC <-- 0으로 설정하여 T사이클을 초기화 해줌(SR는 오를때마다 T타이밍이 변하게 됨)
	- MRI명령어 여부
		> T3타이밍에 직접주소인지 간접주소인지 여부에 따라 각기 다른 동작 수행  
		>> 간접주소일 경우 : AR <-- M[AR] / 직접주소일 경우 : Nothing

		> T4타이밍에 실제 MRI명령 실행  
		> SC <-- 0으로 초기화
	- RRI명령어 여부(i-bit : 0 / opcode : 111)
		> T3타이밍에 RRI명령 실행  
		> SC <-- 0으로 초기화
	- IO명령 결정(i-bit : 1 / opcode : 111)
		> T3타이밍에 IO명령 실행  
		> SC <-- 0으로 초기화
- 레지스터 참조 명령어

[이미지 자리]
### 6. 메모리 참조 명령어(Memory-Reference Instructions)
- 메모리 참조 명령어의 종류와 동작
	- AND
		- D0T4 : DR <-- M[AR]
			> T4타이밍에 AR이 지칭하는 메모리를 DR로 옮김
		- D0T5 : AC <-- AC ^ DR, SC <-- 0
			> T5타이밍에 AC와 DR을 and하고, SC를 0으로 함
	- ADD
		- D1T4 : DR <-- M[AR]
		- D1T5 : AC <-- AC + DR, E <-- Cout, SC <-- 0
			> T5타이밍에 AC와 DR을 더하고, 캐리값을 E FF로 넣어줌 이후 SC를 0으로 함
	- LDA
		- D2T4 : DR <-- M[AR]
		- D2T5 : AC <-- DR, SC <-- 0
			> AC는 공통버스를 통한 입력단이 존재하지 않으며, DR의 출력단이 연결된 버스가 존재함
			>> 따라서 AC가 데이터를 로드하기 위해서는 DR을 통해서만 데이터를 받을 수 있음
	- STA
		- D3T4 : M[AR] <-- AC, SC <-- 0
			> AC의 값을 메모리에 저장
	- BUN
		- D4T4 : PC <-- AR, SC <-- 0
			> PC의 값을 바꿔줌으로서 명령어가 순차적으로 실행되는 것이 아닌 무조건분기(jump) 하게됨
	- BSA
		- 함수, 서브루틴의 구현에 사용
		- 간접주소 사용의 전형적인 예
		- D5T4 : M[AR] <-- PC, AR <-- AR + 1
			> fetch-cycle단계에서 PC값은 이미 다음 실행할 명령어의 주소를 가지고 있음  
			> 일반적으로 AR가 지칭하는 메모리는 비어있음, 이 공간에 다시 돌아올 PC의 값을 저장하고 AR주소 다음 주소값(서브루틴 시작지점)으로 변경
		- D5T5 : PC <-- AR, SC <-- 0
			> 다음 주소를 AR로 변경하여 서브루틴 실행
			>> 이후 서브루틴 종료 지점에 BUN명령을 통해 서브루틴 시작 바로 전 지점 주소로 돌아가도록 하면  그 주소에 담겨있는 PC값으로 돌아가게 됨
	- ISZ
		- Loop제어문 구현에 사용(for, while ...)
		- D6T4 : DR <-- M[AR]
		- D6T5 : DR <-- DR + 1
		- D6T6 : M[AR] <-- DR, if(DR = 0) then (PC <-- PC + 1), SC <-- 0
### 7. 입출력과 인터럽트(Input-Output and Interrupt)
- 입출력 구성
	- CPU와 IO장치의 속도 차이 제어를 위하여 Flag사용
		- Buffer overrun 상태
		- Buffer underrun 상태
	- FGI
		> 입력 상태를 나타내는 flag
		- 1 : 입력 가능한 상태
		- 0 : 입력 블럭킹
	- FGO
		> 출력 상태를 나타내는 flag
		- 1 : 출력 가능한 상태
		- 0 : 출력장치 사용중
	- 인터럽트(interrupt)
		> 인터럽트가 발생하면 cpu는 현재 동작하는 작업을 잠시 중단하고 해당 동작을 먼저 수행함  
		> 입터럽트의 발생은 곧 입출력을 의미한다
		- IEN flag에 의하여 제어
		- 입출력 전체를 제어
- 입출력 명령어
	> i-bit : 1 && opcode : 111

	[이미지 자리]
- 프로그램 인터럽트
	- 메인 프로그램 동작 중 인터럽트 발생 시 동작과정
		- 서브루틴과는 다르게 진행중인 명령어의 주소를 서브루틴 함수 시작지점에 저장하는 것이 아닌 무조건 0번 주소지에 저장
		- 1번 주소의 명령실행 : 0 BUN 1120
			> 1120번 주소지로 점프
		- 1120번 주소에는 I/O프로그램이 존재한다
			> 해당 프로그램이 바로 BIOS(basic input output system)
		- I/O프로그램 마지막에는 1 BUN 0 명령이 존재
			> 0번 주소지로 점프
	- 명령 실행 사이클 중 인터럽트를 식별할 수 있는 이유
		- 각 사이클 실행 전 R FF을 통과한 뒤 해당 사이클 진행
		- R FF은 각 사이클의 마지막 단계에 FGI/FGO에 의해서 값이 결정됨(0 : 인터럽트 없음 / 1 : 인터럽트 발생)
		- R FF의 값이 1이면 interrupt-cycle로 분기하여 I/O프로그램 진행
			> 이때, 만약 I/O프로그램 실행 중 인터럽트가 또 발생할 경우, 해당 인터럽트 사이클 완료전에 다시 해당 실행중인 주소로 0번지의 주소가 초기화 될 수 있음  
			> 이렇게 되면 원래 돌아가야할 주소를 잃어버리게 되어 문제가 생김  
			> 따라서 해당 사이클 실행 중에는 IEN을 0으로 세팅하여 FGI/FGO의 값이 변경됨에 따라 다시 I/O프로그램이 다시 시작하지 않도록 방지한다
		- 위처럼 기존에는 한번의 한개의 인터럽트만을 받아서 처리했지만, 현대의 컴퓨터는 인터럽트를 큐로 저장하여 인터럽트 중 인터럽트가 발생하여도 처리하도록 한다
	- 장치가 준비되었을 때 cpu에게 알림
	- 인터럽트 발생시 BSA명령어처럼 동작
	- FGI, FGO플래그 사용
		- 플래그가 set되면 R <-- 1
		- R = 1이면 다음 명령어 사이클에 인터럽트 사이클 실행
	- IEN
		- 인터럽트 enable/disable제어
- I/O Program
	- 입출력 인터럽트 처리 루틴의 집합
- IVT(interrupt vector table)
	- 각 인터럽트에 벡터번호 부여
	- 벡터번호와 인터럽트 처리 루틴 시작번지를 table로 유지
	- 시스템 부팅시에는 IVT는 0번 segment에 load
	- 현대의 대부분의 CPU가 IVT사용
- 인터럽트 사이클(IC)
	- IC로 분기되는 조건
		- T0'T1'T2'(IEN)(FGI+FGO) : R <-- 1
			> T3이후 시점부터(즉, fetch-cycle이후) / IEN == 1 / FGI == 1 or FGO == 1 일때
	- 인터럽트 사이클의 실행
		- RT0 : AR <-- 0, TR <-- PC
		- RT1 : M[AR] <-- TR, PC <-- 0
		- RT2 : PC <-- PC + 1, IEN <-- 0, R <-- 0, SC <-- 0
### 8. 컴퓨터에 대한 완전한 기술(Complete Computer Description)
- 기본 컴퓨터(PDP-11)의 전체 명령어 set

	[이미지 자리]
### 9. 기본 컴퓨터의 설계(Design of Basic Computer)
- 하드웨어 구성요소
	- 16bit 4096워드 메모리
		> 메인 메모리
	- 9개의 레지스터
		> 범용 양방향 시프트 레지스터
		- AR, PC, DR, AC, IR, TR, OUTR, INPR, SC
	- 7개의 플립플롭
		- I, S, E, R, IEN, FGI, FGO
			> I : 직접주소, 간접주소 구분  
			> S : 음수 양수 구분  
			> E : 올림수, 오버플로우 기록  
			> R : 인터럽트 발생여부 기록  
			> IEN : 인터럽트를 받을지 여부 결정
	- 2개의 디코더
		- 3 x 8(opcode), 4 x 16(타이밍)
	- 16bit 공통버스
		> 멀티플렉서  
		> 공통버스에 묶이는 요소들 : 메모리, AR, PC, DR, AC, IR,INPR
	- 제어 논리 게이트
	- AC입력 연결 논리회로(ALU)
- 컴퓨터의 동작흐름
	- MRI, RRI, IO명령 사이클 구현
	- 인터럽트 사이클 구현
- 레지스터와 메모리에 대한 제어
	- AR제어 논리 게이트 예
		> AR이 bus로부터 데이터를 로드하는 경우에 대한 동작들이 중요  
		> 즉, AR의 LD, CLR, INC가 동작하는 관계를 정리하고 설계하면 됨
- 설계 순서
	- AR에 대한 LD, CLR, INC동작의 경우 수집
		- R'T0 : AR <-- PC
		- R'T2 : AR <-- IR(0-11)
		- D7'T3 : AR <-- M[AR]
		- RT0 : AR <-- 0
		- D5T4 : AR <-- AR + 1
	- 각 동작들을 OR로 연결
		- LD(AR) = R'T0 + R'T2 + D7'T3
		- CLR(AR) = RT0
		- INR(AR) = D5T4
- 메모리 READ제어 게이트의 예
	> '<-- M[ ]'의 형식인 경우
	>> 'M[ ] <--'의 형식은 Write동작을 의미
	- Read = R'T1 + D7'IT3 + (D0 + D1 + D2 + D6)T4
- 공통버스에 대한 제어
	- 인코더에 대한 부울식  
		[table 5-7이미지]
	- x1에 대한 설계 예
		- D4T4 : PC <-- AR
		- D5T5 : PC <-- AR
		- x1 = D4T4 + D5T5
	- 메모리 읽기(x7)에 대한 설계 예
		- x7 = R'T1 + D7'T3 + (D0 + D1 + D2 + D6)T4
### 10. 누산기 논리의 설계(Design of Accumulator Logic)
- AC레지스터 관련 회로
	- AC를 변경하는 경우 수집
	- LD, CLR, INC
- AC레지스터에 대한 제어
	- LD신호제어
		- MRI명령 : AND, ADD, LDA
		- RRI명령 : COM, SHR, SHL
		- IO명령 : INPR
	- INR신호 제어
		- MRI명령 : none
		- RRI명령 : INC
		- IO명령 : none
	- CLR신호 제어
		- MRI명령 : none
		- RRI명령 : CLR
		- IO명령 : none
- 가산 논리 회로
	- AND gate
	- Full Adder
	- Inverter
	- Shifter
	- INPR/OUTR
