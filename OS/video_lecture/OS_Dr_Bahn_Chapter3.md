# Operating System Chapter 3 : Process
### 1. 프로세스의 개념
- **"Process is a program in execution"**
- 프로세스의 문맥(context)
	> 현재 시점에 프로세스 진행상태를 규명할 수 있게 함
	>> CPU가 프로세스를 한번에 수행하지 않기 때문에 백업용으로 필요함
	- CPU 수행 상태를 나타내는 하드웨어 문맥
		- Program Counter
		- 각종 register
	- 프로세스의 주소 공간
		- code, data, stack
	- 프로세스 관련 커널 자료 구조
		- PCB(Process Control Block)
		- Kernel stack
### 2. 프로세스의 상태(Process State)
> CPU가 하나밖에 없는 시스템으로 가정
- 프로세스는 상태(state)가 변경되며 수행된다
	- Running
		- CPU를 잡고 instruction을 수행중인 상태
	- Ready
		- CPU를 기다리는 상태(메모리 등 다른 조건을 모두 만족하고)
	- Blocked(wait, sleep)
		- CPU를 주어도 당장 instruction을 수행할 수 없는 상태
		- Process 자신이 요청한 event(예 : I/O)가 즉시 만족되지 않아 이를 기다리는 상태
		- (예) 디스크에서 file을 읽어와야 하는 경우
	- New : 프로세스가 생성중인 상태
	- Terminated : 수행(execution)이 끝난 상태
### 3. 프로세스 상태도
		admitted		interupt		exit
	[New] ----------->> | R | <<------------------- | R | ------->> [Terminated]
			    | e |		        | u |
			    | a | ------------------->> | n |
			    | d |   scheduler dispatch  | n |
			    | y |		        | i |
			    |   |		        | n |
			    |   | <<--- [Waiting] <<--- | g |
				 I/O or		    I/O or
				event completion    event completion

### 4. Process Control Block(PCB)
### 5. 문맥교환(Context Switch)
### 6. 프로세스를 스케줄링하기 위한 큐
### 7. Ready Queue와 다양한 Device Queue
### 8. 스케줄러(Scheduler)
### 9. 프로세스 스케줄링 큐의 모습
### 10. Thread
### 11. Single and Multithreaded Processes
### 12. Benefits of Thread
### 13. Implemetation of Threads
