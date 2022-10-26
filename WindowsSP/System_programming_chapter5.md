# System programming chapter 5 : 프로세스의 생성과 소멸
### 1. 프로세스와 스케줄러의 이해
- 프로세스란?
	- 메인 메모리로 이동하여 실행중인 프로그램 --> 일반적인 정의
- 프로세스의 범위
	- 메모리 구조 + 레지스터 set
	- 프로세스 별 독집적인 대상은 프로세스의 범주에 포함시킬 수 있다
		> 단일 레지스터 set을 가진 CPU가 멀티 프로세스를 실행시킬 때에는 C.S(context switching)기법을 통해서 레지스터 set 내부 데이터를 지속적으로 변견하는 작업을 수행함
- 프로세스 스케줄러
	- 프로세스 스케줄러 기능
		- 둘 이상의 프로세스가 적절히 실행되도록 컨트롤
			> CPU입장에서 프로세스 스케줄러 또한 프로세스라고 볼 수 있음 --> 자주 동작할 수록 다른 프로세스가 실행될 수 있는 시간이 적어짐
	- 스케줄링 방법
		- 스케줄링 알고리즘에 따라 다양함
- 프로세스의 상태
	- 프로세스의 시작과 종료 사이에 Running state, Ready state, Blocked state 3가지 상태가 존재함
		> 단일 CPU의 경우 한개의 프로세스만 Running state 일 수 있으므로, 나머지 프로세스들과 주기적으로 상태가 변함
		- Running state : 실질적으로 CPU에 의해서 연산이 수행되는 상태(프로세스가 동작하는 상태)
		- Ready state : 프로세스 스케줄러에 의해서 Running state로 넘어가기를 대기하는 상태
		- Blocked state : I/O연산과 같이 CPU(ALU)의 도움이 불필요한 명령의 경우 연산이 종료될 때 까지 기다리는 상태
- 컨텍스트 스위칭
	- 동작중인 프로세스가 바뀔때마다 빈번하게 일어남
	- CPU 레지스터 set 에 현재 동작중인 데이터를 메모리에 저장하고, 실행시킬 프로세스의 레지스터 set 데이터를 메모리로 부터 가져오는 방식

### 2. 프로그래밍을 통한 프로세스의 생성
- 프로세스 생성 함수
	```c
	BOOL CreateProcess(
		LPCTSTR IpApplicationName	//실행파일의 이름지정
		LPTSTR IpCommandLine		//매개변수 전달
		// 현재는 위의 두줄 맨아래에서 두줄만 기억하면 됨
		LPSECURITY_ATTRIBUTES IpProcessAttributes
		LPSECURITY_ATTRIBUTES IpThreadAttributes
		BOOL binheritHandles
		DWORD dwCreationFlags
		LPVOID IpEnvironment
		LPCTSTR IpCurrentDirectory
		//
		LPSTARTUPINFO IpStartupInfo
		LPPROCESS_INFORMATION IpProcessInformation
	);
	```
	- `LPSTARTUPINFO` -정보전달-> `CreateProcess` -정보반환-> `LPPROCESS_INFORMATION`
		> LPSTARTUPINFO, LPPROCESS\_INFORMATION 두 가지 구조체를 선언해야함
	- CreateProcess에 의한 생성 : Process A(부모 프로세스) --> Process B(자식 프로세스)
- LPSTARTUPINFO
	```c
	typedef struct _STARTUPINFO {
		DWORD	cd;	//구조체 변수의 크기
		LPTSTR	IpReserved;
		LPTSTR	IpDesktop;
		LPTSTR	IpTitle;	//콘솔 윈도우의 타이틀 바 제목
		DWORD	dwX;	//프로세스 윈도우의 x좌표
		DWORD	dwY;	//프로세스 윈도우의 y좌표
		DWORD	dwXSize;	//프로세스 윈도우의 가로길이
		DWORD	dwYSize;	//프로세스 윈도우의 세로길이
		DWORD	dwXCountChars;
		DWORD	dwYConutChars;
		DWORD	dwFileAttribute;
		DWORD	dwFlags;	//설정된 멤버의 정보
		WORD	wShowWindow;
		WORD	cbReserved2;
		LPBYTE	IpReserved2;
		HANDLE	hStdinput;
		HANDLE	hStdOuput;
		HANDLE	hStdError;
	} STARTUPINFO, *LPSTARTUPINFO;
	```
- LPPROCESS\_INFORMATION
	```c
	typedef struct _PROCESS_INFORMATION
	{
		HANDLE	hProcess;	//프로세스의 핸들
		HANDLE	hThread;	//쓰레드 핸들
		DWORD	dwProcessId;	//프로세스의 ID
		DWORD	dwThreadId;	//쓰레드ID
	} PROCESS_INFORMATION;
	```
