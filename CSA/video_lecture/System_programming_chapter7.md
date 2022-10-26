# System Programming Chapter 7 : 프로세스간 통신(IPC) 1
### 1. 프로세스간 통신(IPC)의 의미 / 메일슬롯 방식의 IPC
- 프로세스 간 통신(Inter Process Communication)
	- 프로세스 간 데이터 송수신 --> 메모리 공유
		> 기본적으로 안정성을 위해 각 프로세스는 서로 완전히 분리되어 독립적인 메모리 영역을 가지고 있음
		>> 따라서 OS는 프로세스 간 통신을 위해서는 공유되어지는 별도 메모리 공간을 마련해야 함
- 메일슬롯
	- 동작원리
		1. Receiver 프로세스가 특정 주소에 우체통(메모리 공간)을 마련함
		1. Sender 프로세스가 해당 주소로 데이터를 송신
		1. Receiver 프로세스가 해당 주소로 간접 접근을 통해 데이터 수신
			> Sender 로부터 Receiver 로 단방향 통신만 가능
			>> 1개의 Sender가 여러개의 Receiver로 보낼 수 있음(broadcast)
### 2. Signaled vs Non-Signaled
- 커널 오브젝트의 상태
	- 상태 : 리소스의 현재 상황을 알리기 위함
		> 프로세스가 동작중일때는 커널 오브젝트 Non-signaled 상태  
		> 프로세스가 종료되면 커널 오브젝트 Signaled 상태
