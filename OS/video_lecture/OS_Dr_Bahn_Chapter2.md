# Operating System Chapter 2 : System Structure & Program Execution
### 1. 컴퓨터 시스템 구조
- Computer
	- CPU
		> register : CPU 내부에 존재하는 memory보다 빠른 속도를 가지는 저장공간  
		> mode bit : CPU에서 실행되는 것이 운영체제인지 사용자 프로그램인지 구분해줌  
		> interrupt line : memory의 instruction을 수행하는 도중 다른 디바이스에 대한 요청을 인식하기 위함
		>> CPU는 항상 instruction을 수행하고 다음 instruction을 수행하기 이전에 인터럽트 발생유무를 확인함
	- Memory
		> CPU의 작업공간
		>> OS, 사용자 프로그램 코드 등을 담고있음
- I/O device
	> device controller : 각 I/O device에는 device controller라고 하는 작은 CPU가 존재하여 제어를 한다  
	> local buffer : 각 I/O device의 작업공간
	- disk
	- input device
	- output device
- Timer : 특정 프로그램이 CPU를 독점하는 것을 방지하기 위해 존재
	> 사용자 프로그램은 CPU의 자원을 할당받을 때 timer에 설정된 시간만큼만 CPU의 사용권한을 얻게됨
	>> 설정된 시간이 되면 timer interrupt를 발생시킴
- DMA(direct memory access) controller
	> DMA : 메모리는 원칙적으로 CPU만 접근할 수 있으나, 너무 잦은 I/O interrupt의 발생으로 CPU가 원활한 동작을 수행하기 힘들어지기 때문에 이를 해소하기 위해서 I/O interrupt가 발생했을 때 DMA가 직접 local buffer의 데이터를 메모리로 복사하는 역할을 수행
	>> DMA controller : CPU, DMA가 동시에 메모리에 접근하는 것을 방지하기 위한 역할 수행
### 2. Mode bit
- 사용자 프로그램의 잘못된 수행으로 다른 프로그램 및 운영체제에 피해가 가지 않도록 하기 위한 보호 장치 필요
- Mode bit을 통해 하드웨어적으로 두가지 모드의 operation지원

		1	사용자 모드 : 사용자 프로그램 수행
		0	모니터 모드 : OS코드 수행

		// 모니터 모드 = 커널 모드 = 시스템 모드
	- 보안을 해칠 수 있는 중요한 명령어는 모니터 모드에서만 수행 가능한 **특권명령** 으로 규정
	- Interrupt나 Exception 발생시 하드웨어가 mode bit을 0으로 바꿈
	- 사용자 프로그램에게 CPU를 넘기기 전에 mode bit을 1로 셋팅
### 3. Timer
- 타이머
	- 정해진 시간이 흐른 뒤 운영체제에게 제어권이 넘어가도록 인터럽트를 발생시킴
	- 타이머는 매 클럭 틱 때마다 1씩 감소
	- 타이머 값이 0이 되면 타이머 인터럽트 발생
	- CPU를 특정 프로그램이 독점하는 것으로부터 보호
- 타이머는 time sharing을 구현하기 위해 널리 이용됨
- 타이머는 현재 시간을 계산하기 위해서도 사용
### 4. Device Controller
- I/O dievice controller
	- 해당 I/O장치유형을 관리하는 일종의 작은 CPU
	- 제어 정보를 위해 control register, status register를 가짐
	- local buffer를 가짐(일종의 data register)
- I/O는 실제 device와 local buffer사이에서 일어남
- Device controller는 I/O가 끝났을 경우 interrupt로 CPU에 그 사실을 알림

		divice driver(장치구동기)
		: OS 코드 중 각 장치별 처리루틴 --> software

		device controller(장치제어기)
		: 각 장치를 통제하는 일종의 작은 CPU --> hardware
### 5. 입출력(I/O)의 수행
- 모든 입출력 명령은 특권 명령
	> 즉 사용자 프로그램은 직접 수행할 수 없고, 운영체제를 통해서만 가능하다는 의미
- 사용자 프로그램은 어떻게 I/O를 하는가?
	- 시스템콜(system call)
		> 사용자 프로그램이 커널함수를 호출하는 것
		>> 프로그램 내에서 함수를 호출하는 것을 단순히 메모리 주소를 바꾸는 것으로 가능하지만 시스템콜을 위해서는 단순히 운영체제 코드로의 점프는 불가능함
		>>> 결국 프로그램이 직접 인터럽트를 발생시켜 mode bit을 0으로 바뀌고 커널모드가 되어 OS가 CPU제어권을 가진 상태에서 해당 커널함수를 수행
		- 사용자 프로그램은 운영체제에게 I/O요청
	- trap을 사용하여 인터럽트 벡터의 특정 위치로 이동
		> trap : 소프트웨어 인터럽트
	- 제어권이 인터럽트 벡터가 가리키는 인터럽트 서비스 루틴으로 이동
	- 올바른 I/O요청인지 확인 후 I/O수행
	- I/O완료 시 제어권을 시스템콜 다음 명령으로 옮김
### 6. 인터럽트(Interrupt)
- 인터럽트
	> 현대의 운영체제는 인터럽트에 의해 구동된다고 볼 수 있음
	>> 인터럽트가 없다면 운영체제가 CPU에 대한 제어권을 잡을 경우가 없음
	- 인터럽트 당한 시점의 레지스터와 program counter를 save한 후 CPU의 제어를 인터럽트 처리 루틴에 넘긴다
- Interrupt(넓은 의미)
	- Interrupt(하드웨어 인터럽트) : 하드웨어가 발생시킨 인터럽트
		> device controller, timer 등에 의한 인터럽트
	- Trap(소프트웨어 인터럽트)
		- Exception : 프로그램이 오류를 범한 경우
		- System Call : 프로그램이 커널 함수를 호출하는 경우
- 인터업트 관련 용어
	- 인터럽트 벡터
		> 다양한 인터럽트의 종류마다 어떤 함수를 수행해야 하는지를 정리한 테이블
		- 해당 인터럽트의 처리 루틴 주소를 가지고 있음
	- 인터럽트 처리 루틴(=Interrupt Service Routine, 인터럽트 핸들러)
		> 각 인터럽트마다 처리해야할 코드
		- 해당 인터럽트를 처리하는 커널 함수
### 7. 시스템콜(System Call)
- 시스템콜
	- 사용자 프로그램이 운영체제의 서비스를 받기 위해 커널 함수를 호출하는 것
### 8. 동기식 입출력과 비동기식 입출력
	
### 9. DMA(Direct Memory Access)
### 10. 서로 다른 입출력 명령어
### 11. 저장장치 계층 구조
### 12. 프로그램의 실행(메모리 load)
### 13. 커널 주소 공간의 내용
### 14. 사용자 프로그램이 사용하는 함수
### 15. 프로그램의 실행
