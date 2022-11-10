# Operating System Chapter 4 : Process Management

### 1. 프로세스 생성(Process Creation)
- 부모 프로세스(Parent process)가 자식 프로세스(children process)생성

- 프로세스의 트리(계층 구조) 형성

- 프로세스는 자원을 필요로 함
	- 운영체제로부터 받는다
	- 부모와 공유한다
	
- 자원의 공유
	
	> Copy-on-write(COW) 기법 : 부모와 자식간의 동일한 내용일 경우, 바로 프로세스를 복사하지 않고 자원을 공유하다가 달라지는 부분이 생겼을 때 복사하여 새로운 프로세스를 생성하는 방식
	
	- 부모와 자식이 모든 자원을 공유하는 모델
	- 일부를 공유하는 모델
	- 전혀 공유하지 않는 모델
	
	  > 대부분의 경우 프로세스간에는 자원을 공유하지 않음
	
- 수행(Execution)
	- 부모와 자식은 공존하며 수행되는 모델
	- 자식이 종료(terminate)될 때까지 부모가 기다리는(wait) 모델
	
- 주소 공간(Address space)
	
	- 자식은 부모의 공간을 복사함 (binary and OS data)
	- 자식은 그 공간에 새로운 프로그램을 올림
	
- 유닉스의 예
	
	- fork() 시스템 콜이 새로운 프로세스를 생성
	  - 부모를 그대로 복사(OS data except PID + binary)
	  - 주소 공간 할당
	- fork 다음에 이어지는 exec() 시스템 콜을 통해 새로운 프로그램을 메모리에 올림
### 2. 프로세스 종료(Process Termination)

- 프로세스가 마지막 명령을 수행한 후 운영체제에게 이를 알려줌(exit)

  - 자식이 부모에게 output data를 보냄 (via wait)

    > 프로세스는 기본적으로 자식이 먼저 종료되어야 함

  - 프로세스의 각종 자원들이 운영체제에게 반납됨

- 부모 프로세스가 자식의 수행을 종료시킴(abort)

  - 자식이 할당 자원의 한계치를 넘어섬
  - 자식에게 할당된 태스크가 더 이상 필요하지 않음
  - 부모가 종료(exit)하는 경우
    - 운영체제는 부모 프로세스가 종료하는 경우 자식이 더 이상 수행되도록 두지 않는다
    - 단계적인 종료

### 3. 프로세스와 관련한 시스템콜

#### fork() 시스템 콜

- A process is created by fork() system call.

  - creates a new address space that is a duplicate of the caller.

    ```c
    int main()
    {
      int pid;
      pid = fork();
      if(pid == 0)	/* this is child */
        printf("\n Hello, I am child\m\n");
      else if (pid > 0)	/* this is parent */
        printf("\n Hello, I am parent\n");
    }
    ```

    

### 4. 프로세스 간 협력
### 5. Message Passing
### 6. Interprocess communication
### 7. CPU and I/O Bursts in Program Execution
### 8. CPU burst Time의 분포
### 9. 프로세스의 특성 분류
### 10. CPU Scheduler & Dispatcher
