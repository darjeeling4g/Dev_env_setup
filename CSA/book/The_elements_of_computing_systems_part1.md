# Part 1. 불 논리

### 1. 불 대수
> 불 대수는  2진수(1/0, true/false 등) 값을 다루는 대수학을 의미하며, 불 함수는 2진수를 입력받아 2진수를 출력하는 함수이다
##### 진리표 표현
> 불 함수의 입력값들과 될 수 있는 모든 2진 값의 조합을 표현 하는 방식

|x|y|z|f(x,y,z)|
|---|---|---|:---:|
|0|0|0|0|
|0|0|1|0|
|0|1|0|1|
|0|1|1|0|
|1|0|0|1|
|1|0|1|0|
|1|1|0|1|
|1|1|1|0|
##### 불 표현식
> 불 함수를 입력값에 대한 불 연산으로 표현 하는 방식

**f(x,y,z) = (x + y) * z'**  
`x + y` : x Or y(x 또는 y가 1이거나, 둘 다 1일 때만 1)  
`xy` : x And y(x와 y가 둘 다 1일 때만 1)  
`x'` : Not x(x가 0일때 1)
##### 정준 표현
> 아무리 복잡한 불 함수라도 And, Or, Not의 세 가지 불 연산만으로 표현 가능하다

f(x,y,z) = (x + y) * z' = **f(x,y,z) = x'yz'+xy'z'+xyz'**  

##### 2-입력 불 함수
> n개의 2진 변수에 대해 정의되는 불 함수의 수는 **2^2^n개**다
>> NAND함수의 경우, NAND만으로 And, Or, Not연산을 만들 수 있다는 특징이 있음  
>> 즉, 모든 불 함수는 And, Or, Not연산만으로 이루어진 정준 표현식으로 바꿀 수 있으므로 모든 불 함수는 NAND연산만으로 표현이 가능하다

### 2. 게이트 논리
> 게이트는 불 함수를 구현한 물리적 장치로, n개 변수를 받아 m개의 2진 결과값을 반환하는 불 함수f는 n개의 입력 핀과 m개의 출력 핀이 있게된다
##### 기본게이트와 조합게이트
> 모든 논리 게이트는 입력 및 출력 신호 형태가 같으므로 서로 연달아 이으면 더 복잡한 조합 게이트를 만들어 낼 수 있다

### 3. 명세
##### NAND게이트
	칩 이름 : Nand
	입력 : a, b
	출력 : out
	기능 : If a=b=1 then out=0 else out=1
	설명 : 이 게이트는 가장 기본이 되는 게이트이므로 따로 구현할 필요가 없다
> 기본 논리게이트
##### NOT게이트
	칩 이름: Not
	입력 : in
	출력 : out
	기능 : If in=0 then out=1 else out=0
##### AND게이트
	칩 이름: And
	입력 : a, b
	출력 : out
	기능 : If a=b=1 then out=1 else out=0
##### OR게이트
	칩 이름: Or
	입력 : a, b
	출력 : out
	기능 : If a=b=0 then out=0 else out=1
##### XOR게이트
	칩 이름: Xor
	입력 : a, b
	출력 : out
	기능 : If a!=b then out=1 else out=0
##### 멀티플렉서
	칩 이름: Mux
	입력 : a, b, sel
	출력 : out
	기능 : If sel=0 then out=a else out=b
##### 디멀티플렉서
	칩 이름: dmux
	입력 : in, sel
	출력 : a, b
	기능 : if sel=0 then {a=in, b=0} else {a=0, b=in}
> 기본 게이트의 멀티비트 버전
##### 멀티비트 NOT
	칩 이름: Not16
	입력 : in[16]
	출력 : out[16]
	기능 : For i=0..15 out[i]=Not(in[i])
##### 멀티비트 AND
	칩 이름: And16
	입력 : a[16], b[16]
	출력 : out[16]
	기능 : For i=0..15 out[i]=And(a[i], b[i])
##### 멀티비트 OR
	칩 이름: Or16
	입력 : a[16], b[16]
	출력 : out[16]
	기능 : For i=0..15 out[i]=Or(a[i], b[i])
##### 멀티비트 멀티플렉서
	칩 이름: Mux16
	입력 : a[16], b[16], sel
	출력 : out[16]
	기능 : If sel=0 then for i=0..15 out [i]=a[i]  
		else for i=0..15 out [i]=b[i]
> 기본 게이트의 다입력 버전
##### 다입력 OR
	칩 이름: Or8way
	입력 : in[8]
	출력 : out
	기능 : out=Or(in[0], in[1], ... , in[7])
##### 다입력/멀티비트 멀티플렉서
	칩 이름: Mux4way16
	입력 : a[16],b[16],c[16],d[16],sel[2]
	출력 : out[16]
	기능 : If sel==00 then out=a else if sel=01 then out=b  
		else if sel=10 then out=c else if sel=11 then out=d
	설명 : 위에서 언급한 연산들은 모두 16비트이다. 예를 들어 "out=a"는 "i=0..15에 대해 out[i]=a[i]"란 뜻이다
##### 다입력/멀티비트 디멀티플렉서
	칩 이름: DMux4way
	입력 : in, sel[2]
	출력 : a, b, c, d
	기능 : If sel=00 then {a=in, b=c=d=0}
	else if sel=01 then {b=in, a=c=d=0}
	else if sel=10 then {c=in, a=b=d=0}
	else if sel=11 then {d=in, a=b=c=0}
