# CSA Chapter3 : 데이터의 표현

### 1. 데이터의 종류(Data Types)
- 컴퓨터 레지스터에서 쓰이는 데이터의 종류
	- 산술 연산용 숫자(Numeric)
		> 컴퓨터의 본래 목적은 수를 계산함에 있음
	- 데이터 처리용 영문자(Alpha)
	- 특수 목적용 기호(Special)
- 진수와 진법
	- radix : 진법의 기수에 해당(10, 2, 8, 16 ...)
	- 10진수
	- 2진수
	- 8진수
	- 16진수
- 2진화 8진수(Octal) : 3자리씩 묶인 2진수로 표현한 8진수
- 2진화 16진수(Hexadecimal) : 16진수의 경우 10~15까지의 수를 알파벳으로 표현
- 2진화 10진수(BCD: Binary Code Decimal)
- 영숫자(AlphaNumeric)의 표시
	- ASCII Code : 7bits(+1 parity bit)
	- EBCDIC Code : 16bits, IBM internal code
	- Unicode : 16bits/32bits
		> 아스키 코드만으로는 다국적 언어를 표현하기 어려움에 따라 필요성 대두
	- Morse Code
	- Flag Signal (Red/White flags)
### 2. 보수(Complements)
- 정의
	- 진접의 기수 r에 대응하는 역(reverse)값
	- 뺄셈과 논리 계산에 사용
		> 최대값 - 특정수 = 보수
- (r-1)의 보수체계
	- 9's complement 99999 - 12389 = 87610
	- 1's complement 1111111 - 0001111 = 1110000
		> 1과 0이 서로 뒤집혀 있음
- (r)의 보수체계
	- 10's complement 100000 - 12389 = 87611
	- 2's complement 100000000 - 0001111 = 1110001
		> 1의 보수 + 1 의 값
- 부호 없는 숫자의 뺄셈
	- 부호없는 2진수의 뺄셈
		> 컴퓨터에서는 빼기, 곱셈, 나눗셈 연산을 하지않음
		> 모든 사칙연산을 덧셈만으로 계산
		>>	빼기의 경우 보수의 합으로 계산함
### 3. 고정 소수점 표현(Fixed Point Representation)
- 정의
	- 소수점의 위치를 결정하여 숫자 표현
	- 레지스터 비트에 소수점 위치를 표시
	- 16bit 정수의 경우 좌우측(LSB)에 소수점 자리 위치
		> 정수 : 소수점을 할당한 비트가 없음
		> 실제 컴퓨터에서 고정 소수점은 전부 정수
	- 부동소수점의 경우, 레지스터 비트 앞/중간에 소수점 자리 위치
- 정수의 표현(-14)
	- MSB(Most Significant Bit)로 부호 표현
	- 양수는 MSB --> 0, 음수는 MSB --> 1
	- 부호 절대값 표현(Signed magnitude) 1 0001110
	- 부호화된 1의 보수(signed 1's complement) 1 1110001
	- 부호환된 2의 보수(signed 2's complement) 1 1110010
		- 대부분의 컴퓨터, cpu에서 사용(intel, AMD, Zilog ...)
	- 산술 가산(Arithmetic add)
	- 산술 감산(Arithmetic substract)
- 오버플로우(Overflow)의 발생
	- N자리의 두 수를 더하여 N+1자리의 합이 발생하였을 때
	- 가수, 피가수의 부호와 관계없이 발생
	- 정해진 레지스터의 비트수로 인한 문제
		- 종이와 연필로 연산할 경우 절대 발생되지 않을 상황
		- 정해진 비트수 내에서만 연산이 가능한 컴퓨터에서 발생
- 오버플로우 발생 상황
	- 연산 결과값이 레지스터의 비트수를 초과할 경우 발생
	- 두 수의 부호가 같을 경우에만 발생
	- 레지스터에 저장된 연산 결과값은 잘못된 값으로 저장
- 오버플로우 처리 방법
	- 오버플로우 발생을 미리 확인
		- MSB의 두 캐리 비트의 값이 서로 다르면 오버플로우
		- if C8 + C7 = 1, Overcflow occurs
			> C7 7bit자리의 캐리 값
	- 연산을 처리하지 않고 인터럽트 또는 에러 처리
### 4. 부동 소수점 표현(Floating Point Representation)
- 부동소수점 표시방법(IEEE 754)
	- 가수와 지수로 표현
	- 가수(mantissa) : 분수(Fraction), 정수값 표시
	- 지수(Component) : 십진/이진 소수점 위치를 표시
		> 1001.11 = .1001110 * 2^4 --> 01001110(fraction), 000100(Exponent)  
		> 32bit FP 표현 : 0 10000100 00111000000000000000000
		>> 1번째bit 자리 : 부호표시  
		>> 이후 8bit 자리 : 지수 표시(128biased)(128 은 0과 같음)  
		>> 마지막 23bit 자리 : 가장 좌측 1을 제외한 가수표시(어차피 소수점 다음 자리는 항상 1이므로 표시를 안하는 것!)
	- 64bit = double, double presion / 32bit = float, single presion / 16bit = half, half presion
- 정규화(Normalization)
	- 부동소수점 숫자에서 최상위 비트가 0이 아닌경우
	- 0이 있을경우, Mantissa의 소수점 위치 이동
	- 이동한 만큼 exponent의 값 변경
### 5. 기타 이진 코드(Other Binary Codes)
- Gray Code
	- 한 숫자에서 다음 숫자로 변할 때 한 비트만 변동
		> 0000 --> 0001 --> 0011 --> 0010 ...
	- 제어 계통에 주로 사용
	- 여러 전기 신호가 동시에 바뀔 때 낮은 에러 발생률
- BCD Code
	- 10진수에 대한 2진수 표현(i.e 8421 code)
	- 4bit를 사용 0~9까지 사용(0000 ~ 1001)
- Exess-3 Code
	- BCD Code + 0011
	- 암호 교신의 기본코드, 파생 암호 발생 방법에 사용
- 기타영문 code
	- ASCII: 7bits + parity 1bit
	- EBCDIC: 8bits + parity 1bit
### 6. 에러 검출 코드(Error Detection Codes)
- Parity bit
	- 외부 잡음에 의한 에러 발생의 검출
	- 짝수(even)패리티/홀수(odd)패리티 사용
	- 가장 간단하고도 일반적인 방법
	- 2개의 비트 동시 에러의 경우 검출 불가능
- Parity bit의 적용
	- 송신측: 패리티 발생기
	- 수신측: 패리티 검사기
	- 수신측 패리티 검사결과
		- 데이터 패리티와 일치 : 에러없음 : 0출력
		- 데이터 패리티와 불일치 : 에러발생 : 1출력
