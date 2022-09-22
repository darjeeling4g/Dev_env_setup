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
		> 시작주소 : 16진수 100
		LDA SUB
		> SUB의 값 로드
		CMA
		> 1의보수화
		INC
		> 1증가(2의 보수화)
		ADD MIN
		> MIN과 ADD연산실행
		STA DIF
		> DIF 값 저장
		HLT
		> 프로그램 종료
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
			ORG 100
			LDA ADS
			STA PTR
			LDA NBR
			STA CTR
			CLA
		LOP,	ADD PTR I
			ISZ PTR
			ISZ CTR
			BUN LOP
			STA SUM
			HLT
		ADS,	HEX 150
		PTR,	HEX 0
		NBR,	DEX -100
		CTR,	HEX 0
		SUM,	HEX 0
			ORG 150
			DEC 75

			DEC 23
			END
		```
		- 루프부분
			```assembly
			LOP,	ADD PTR I
				ISZ PTR
				ISZ CTR
				BUN LOP
			```
		- 카운터 부분
		- 데이터 array부분
### 5. 산술 및 논리 연산의 프로그래밍(Programming Arithmetic and Logic Operations)
### 6. 서브루틴(Subroutines)
### 7. 입출력 프로그래밍(Input-Output Programming)
