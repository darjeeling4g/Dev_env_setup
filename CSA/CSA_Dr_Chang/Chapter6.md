# CSA Chapter 6 : 기본 컴퓨터 프로그래밍
### 1. 기계어(Machine Language)
- 명령어 Symbol <--> Hexa code 관계
- 프로그램의 종류
	- 이진코드(Binary code)
		> 컴퓨터가 이해할 수 있는 것은 오직 기계어뿐임  
		> 다른 상위 언어들도 결국에는 기계어로 다시 변환되어 컴퓨터가 처리함
		- 기계어 프로그램(코드)
		- 메모리상에 실제 나타나는 형태의 명령어 집합
		- 이진 명령어와 피연산자의 시퀀스로 구성
	- 8진/16진 코드(Octal/Hexa code)
		- 이진 기계어 코드를 8진수, 16진수로 표현
	- 기호 코드(Symbolic code)
		- 이진 기계어 코드에 대해서 문자로 된 심볼로 표현
		- 어셈블리어
	- 고급 프로그래밍 언어
		- 하드웨어 구조와 관계 없이 문제 해결 논리가 고려된 언어
		- 문제 위주의 기호와 형식사용
		- 인터프리터, 컴파일러 사용
		- FORTRAN, PASCAL, C, C++, BASIC, JAVA, COBOL, Prolong, Sketch
- 기계어 --> 16진 코드 --> 기호 코드 --> 어셈블리 코드
	> 어셈블리는 결국 2진 코드를 16진 변환한 값을 각각 특정 기호와 매핑하여 사용하는 것  
	> 실질적으로 기계어와 동일하다
### 2. 어셈블리 언어(Assembly Language)
- 언어규칙
	1. 라벨필드(Label) : 기호주소, 또는 공란
	1. 명령어 필드 : 기계명령어, 슈도 명령어
	1. 코멘트 필드 : 명령어에 대한 주석
- 명령어 필드 항목
	- 메모리 참조 명령어
	- 레지스터 참조 명령어, 입출력 명령어
	- 슈도 명령어
- 슈도 명령어(Pseudo Instruction)
	> 실제 컴퓨터에 실행하는 명령은 아님  
	> 어셈블리 표현을 보기 용이하게 하기위한 명령(가짜 명령어)
	- ORG N : 시작 주소가 N이라는 의미
	- END : 어셈블리 프로그램의 끝이라는 의미
	- DEC N : N은 10진수라는 의미
	- HEX N : N은 16진수라는 의미
- 어셈블리 프로그램 예
	- 83 - (-23) = 106  
	0x53 - 0xFFE9 = 0x6A
	```assembly
		ORG 100
		; 시작주소 : 16진수 100
		LDA SUB
		; SUB의 값 로드
		CMA
		; 1의보수화
		INC
		; 1증가(2의 보수화)
		ADD MIN
		; MIN과 ADD연산실행
		STA DIF
		; DIF 값 저장
		HLT
		; 프로그램 종료
	MIN,	DEC 83
	SUB,	DEC -23
	DIF,	HEX 0
	END
	```
	- 심볼 테이블(주소-기호 테이블)
		- MIN 106
		- SUB 107
		- DIF 108
### 3. 어셈블러(The Assembler)
- 어셈블러란?
	- 기호-언어 프로그램을 이진 프로그램으로 번역하는 프로그램
		- MS Macro Assembler, Turbo Assembler등
	- Two pass 어셈블러
		- First pass, Second pass
- 메모리 내에서 기호 프로그램의 표현
	- 프로그램 예
		- PL3, LDA SUB I
			> 각 문자들이 코드에 대응하여 binary로 변환가능
- First Pass
	> 기계어 변환작업 수행하지 않고, 각 심볼들에 대응하는 주소의 관계를 파악하는 단계
	- 주소기호-이진수값의 관계표 작성
	- Symbol Table을 출력(Address-Symbol Table)
	- Location Counter(LC)를 사용하여 프로그램 주소 카운트
- Second Pass
	- 이진수로의 번역 수행
	- 4개 테이블 참조
		- MRI 명령어 Table
		- Non-MRI 명령어 Table
		- 슈도 명령어 Table
		- Symbol Table
	- 출력
		- 기계어 코드
### 4. 프로그램 루프(Program Loops)
- 루프를 가지는 프로그램
	- FORTRAN프로그램 예
		```fortran
		DIMENSION A(100)
		INTEGER SUM, A
		SUM = 0
		DO 3 J = 1, 100
		3 SUM = SUM + A(J)
		```
	- 어셈블리어로의 표현
		```assembly
			ORG 100		;Origin of program is HEX 100
			LDA ADS		;Load first address of oprands
			STA PTR		;Store in pointer
			LDA NBR		;Load minus 100
			STA CTR		;Store in counter
			CLA		;Clear accumulator
		LOP,	ADD PTR I	;Add an operand to AC
			ISZ PTR		;Increment pointer
			ISZ CTR		;Increment counter
			BUN LOP		;Repeat loop again
			STA SUM		;Store sum
			HLT		;Halt
		ADS,	HEX 150		;Frist address of operands
		PTR,	HEX 0		;This location reserved for a pointer
		NBR,	DEX -100	;Consistant to initialized counter
		CTR,	HEX 0		;This location reserved for a counter
		SUM,	HEX 0		;Sum is stored here
			ORG 150		;Origin of operands is HEX 150
			; 아래 데이터는 실제 메모리상 주소에서 150번 주소에 저장됨
			DEC 75		;First operand
			...
			DEC 23		;Last operand
			END		;End of symbolic program
		```
		- 루프부분
			```assembly
			LOP,	ADD PTR I
				ISZ PTR
				ISZ CTR		;100번 돌고나면 counter가 0이된다 / ISZ는 0일때 다음 명령어가 skip되므로 루프가 종료됨
				BUN LOP
			```
		- 카운터 부분
			```assembly
			NBR,	DEX -100		;0일때 탈출조건이 되므로 -값부터 값을 올림
			CTR,	HEX 0
			```
		- 데이터 array부분
			```assembly
			ORG 150
			DEC 75
			...
			DEC 23
			```
### 5. 산술 및 논리 연산의 프로그래밍(Programming Arithmetic and Logic Operations)
- 곱셈 프로그램
	> 이진 곱셉 : 각 자리수마다 왼쪽으로 쉬프트해서 더해주는 것을 반복한다(이때, 0이면 더하지 않고 1인경우만 왼쪽으로 쉬프트 한 값을 더함)

[이미지 자리]
- 배정밀도 가산
	> 배정밀도가 32bit일때, 16bit 레지스터로 어떻게 연산할 것인가?  
	> 캐리값만 올려주고 나눠서 계산 / 저장도 나눠서 실행
	>> 시간이 배로 걸린다는 단점이 있음
	- High part와 Low part를 따로 연산
	- Low part의 캐리를 High part에 가산
	- 결과치도 High/Low part별도 저장
	```assembly
	LDA AL		;Load A low
	ADD BL		;Add B low, carry in E
	STA CL		;Store in C low
	CLA		;Clear AC
	CIL		;Circulate to bring carry into AC
	ADD AH		;Add A high and carry
	ADD BH		;Add B high
	STA CH		;Store in C high
	HLT
	```
### 6. 서브루틴(Subroutines)
- 서브루틴 사용 예
```assembly
	ORG 100		;Main program
	LDA X		;Load X
	BSA SH4		;Branch to subroutine
	STA X		;Store shifted number
	LDA Y		;Load Y
	BSA SH4		;Branch to subroutine again
	STA Y		;Store shifted number
	HLT
X,	HEX 1234
Y,	HEX 4321
			;Subroutine to shift left 4 times
SH4,	HEX0		;Store return address here
	CIL		;Circulate left once
	CIL
	CIL
	CIL		;Circulate left fourth time
	AND MSK		;Set AC(13-16) to zero
	BUN SH4 I	;Return to main program
MSK,	HEX FFF0	;Mask operand
	END
```
- 서브루틴 파라미터와 데이터 링키지(X OR Y 연산)
	> 파라미터가 2개일때 서브루틴으로 어떻게 값을 넘길것인가?
	>> BSA 명령 바로 다음줄에 2번째 파라미터 값을 위치시키면, 서브루틴 첫번째 줄에 해당 데이터의 주소가 저장되므로 이를 간접호출 하면 서브루틴 내부에서 활용 가능!

	> AND연산 만으로 어떻게 OR 연산을 수행할 것인가?
	>> A OR B = (A' AND B')'
	
	[이미지 자리]
- 16bit 데이터 블록의 복사(memcpy()함수)
	```assembly
				;Main program
		BSA MVE		;Branch to subroutine
		HEX 100		;First address of source data
		HEX 200		;First address of destination data
		DEC -16		;Number of items to move
		HLT		;
	MVE,	HEX 0		;Subroutine MVE
		LDA MVE I	;Bring address of source
		STA PTI		;Store in first pointer
		ISZ MVE		;Ancrement return address
		LDA MVE 1	;Bring address of destination
		STA PT2		;Store in second pointer
		ISZ MVE		;Ancrement return address
		LDA MVE I	;Bring number of items
		STA CTR		;Store in counter
		ISZ MVE		;Ancrement return address
	LOP,	LDA PT1 I	;Load source item
		STA PT2 I	;Store in destination
		ISZ PTI		;Ancrement source pointer
		ISZ PT2		;ncrement destination pointer
		ISZ CTR		;Ancrement counter
		BUN LOP		;Repeat 16 times
		BUN MVE I	;Return to main program
	PT1,	-
	PT2,	-
	CTR,	-
	```
### 7. 입출력 프로그래밍(Input-Output Programming)
- 1개 문자의 입출력  
	> 입출력 신호를 나타내는 flag식별 될때까지 대기

[이미지 자리]
- 2개 문자의 패킹
	- 8bit ASCII --> 16bit Unicode
	- SH4 서브루틴 사용

[이미지 자리]
- 버퍼에 문자 저장

[이미지 자리]
- 두 워드의 비교
	- 데이터 감산을 통한 비교
	- 결과가 0인 경우 두 워드는 동일

[이미지 자리]
- 프로그램 인터럽트
	1. 레지스터들의 내용을 저장
		- M[xx] <-- REGs
		- IEN <-- 0 (by IOFF)
	1. FGI/FGO Flag들의 값 체크
	1. 인터럽트 서비스 루틴 수행
	1. 레스터 내용 원상 복구
		- REGs <-- M[xx]
	1. 인터럽트 기능 ON
		- IEN <-- 1(by ION)
	1. 원래 프로그램으로 복귀
