# lldb(Low-Level Debugger)를 이용한 디버깅
> `lldb`란 Xcode에 내장되어 있는 `Command line debug` 환경으로 `LLVM`의 `Debugger Component`를 개발하는 서브 프로젝트이다
### 0. 컴파일 옵션
- 실행파일 컴파일 시 `-g` 옵션을 부여하여 진행
	```zsh
	gcc [파일 이름] -g
	```
	> `-g` 옵션을 주지 않을 경우, 코드가 어셈블리로 표기된다
### 1. lldb 실행
- `lldb + 실행파일 이름`의 형태로 작성
	```zsh
	lldb [executable file name]
	```
### 2. 프로세스 실행
- `r(run)` 을 입력하여 실행파일 실행
	> breakpoint 없이 실행시 단순실행 동작과 동일한 결과를 얻을 수 있음
	``` zsh
	# lldb 동작 중 아래와 같이 입력하여 실행
	run

	# run을 축약하여 r만 작성가능
	r

	# argument를 넘기고 싶을 때는 아래와 같이 작성
	# argv[1]에 해당 값이 들어가게 됨
	run "argument"

	# 위의 결과로 인자가 들어가지 않을 시 아래와 같은 방식 사용가능
	setting set target.run-args "argument"
	```
### 3. breakpoint 부여
- `breakpoint(b)` :  프로세스 동작간 breakpoint를 만나면 동작을 일시중단한다
	``` zsh
	# 특정 함수에 breakpoint 부여
	b [함수명]

	# 특정 라인에 breakpoint 부여
	list main.c
	b 7

	# 특정 라인에 breakpoint 부여
	b main.c:7

	# breakpoint 제거
	br del (breakpoint 번호)

	# 모든 breakpoint 제거
	br del
	```
### 4. 다음 줄 실행하기
- `next(n)` : step over
	- 다음 한 줄을 실행하되, 함수가 있다면 함수 안으로 들어가지 않는다
- `step(s)` : step into
	- 다음 한 줄을 실행하되, 함수가 있다면 함수 안으로 들어간다
> 지속적으로 다음 줄을 실행하고자 할때는`return` 키를 이용( 이전에 수행한 동작을 반복함)
### 5. 함수 종료하기
- `continue(conti)` : 다음 breakpoint 까지 프로그램 실행
- `finish` : 현재 function의 return이후 지점까지 진행
### 6. 변수 값 출력하기
- `print(p)` : 현재 변수 내부 값을 보여줌
	```zsh
	# 변수 값 출력
	print ptr

	# 포인터 연산, 구조체 관련 연산은 아래와 같이 표기
	p ptr
	p *ptr
	p ptr->next

	# 형변환시 아래와 같이 표기
	p (unsigned long long)ptr;
	p (char)ptr;
	```
- `display` : 변수 값을 고정적으로 띄어놓고 변하는 값을 즉시 확인 가능

##### [`leaks`와 연계한 memory leak 잡는 방법]()
