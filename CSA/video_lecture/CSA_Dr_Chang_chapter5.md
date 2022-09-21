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
	1. 명령어 실행
- Fetch와 Decode  
	T0 : AT <-- PC  
	T1 : IR <-- M[AT], PC <-- PC + 1  
	T2 : D0 ... D7 <-- decode IR(12-14), AR <-- IR(0-11), I <-- IR(15)
### 6. 메모리 참조 명령어(Memory-Reference Instructions)
### 7. 입출력과 인터럽트(Input-Output and Interrupt)
### 8. 컴퓨터에 대한 완전한 기술(Complete Computer Description)
### 9. 기본 컴퓨터의 설계(Design of Basic Computer)
### 10. 누산기 논리의 설계(Design of Accumulator Logic)
