# System Programming Chapter 12 : 쓰레드의 생성과 소멸
### 1. Windows에서의 쓰레드 생성과 소멸
- 쓰레드의 생성
	```c
	HANDLE CreateThread(
		LPSECURITY_ATTRIBUTES IpThreadAttribute,	//핸들의 상속여부 결정
		SIZE_T dwStackSize,				//initial stack size
		LPTHREAD_START_ROUTINE IpStartAddress,		//thread function
		LPVOID IpParameter,				//thread argument
		DWORD dwCreationFlags,				//creation option
		LPDWORD IpThreadId				//thread identifier
	);

	//if the function fails, the return value is NULL.
	```
- 생성 가능한 쓰레드 개수는?
	- 쓰레드는 별도의 stack영역이 각 할당되어야 함/ 메모리 공간에서 더이상 stack을 할당할 수 없는 단계가 허용치라고 볼 수 있음
- 쓰레드의 소멸 case1
	- 쓰레드 종료 시 return을 이용하면 좋은 경우 = 모든 경우
		> 쓰레드 main함수가 return하면 쓰레드는 종료됨
		```c
		BOOL GetExitCodeThread(
			HANDLE hThread,
			LPDWORD IpExitCode
		);

		// if the function fails, the return value is zero
		```
- 쓰레드의 소멸 case2
	- 쓰레드 종료 시 ExitThread함수 호출이 유용한 경우 = 특정 위치에서 쓰레드의 실행을 종료시키고자 하는경우
- 쓰레드의 소멸 case3
	- 쓰레드 종료 시 Terminate Thread 함수 호출이 유용한 경우 = 외부에서 쓰레드 종료시키고자 하는 경우
> 쓰레드의 생성과 소멸은 메인 쓰레드에서 제어될 때 안정적인 소프트웨어 설계가 가능함...
>> 가급적 case2,3의 경우는 사용하지 말고, 정상적으로 return시켜 종료시키는 것을 권장함

### 2. 쓰레드의 성격과 특성
- 힙, 데이터, 코드 영역의 공유 검증(예제 풀이)
- 동시 접근의 문제점
	- 공유 영역에 여러개의 쓰레드가 접근이 이루어졌을 경우, context switching이 지속적으로 이루어지며 레지스터 값이 서로 다르게 동기화되어 원하는 결과값을 얻지 못할 수 있음
	- 한 개의 작업이 끝날때까지 다른 쓰레드가 접근이 되면안됨
	- 결국 이러한 동시 접근을 유도하는 코드가 문제이며, 이를 임계영역이라고 함
- 프로세스로부터의 쓰레드 분리
	1. 쓰레드 Usage Conut : 생성과 동시에 2
		> 자기자신, 쓰레드 생성함수를 호출한 대상
	1. 하나는 쓰레드 종료 시 감소, 하나는 CloseHandle 함수 호출 시 감소
	1. 쓰레드 생성과 동시에 CloseHandle : 쓰레드 분리
### 3. 쓰레드의 상태 컨트롤 / 쓰레드의 우선순위 컨트롤
