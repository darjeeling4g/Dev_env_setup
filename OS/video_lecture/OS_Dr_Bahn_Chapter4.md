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

- fork() : create a child(copy)
- exec() : overlay new image
- wait() : sleep until child is done
- exit() : frees all the resources, notify parent

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
    
    // fork() 가 수행되면 현재 프로세스와 동일한 자식 프로세스가 생성됨
    // 자식은 부모의 context를 그대로 복사하므로 부모와 동일하게 pc가 fork() 실행 이후를 가르키고 있음
    // 따라서, 자식 프로세스는 fork() 이후 시점부터 작업을 수행함
    ```
    
    > Parent process : pid > 0
    >
    > Child process : pid = 0

#### exec() 시스템 콜

> fork() 와는 다르게 자식이 부모 프로세스와 다른 아예 새로운 프로세스를 생성가능함

- A process can execute a different program by the `exec()` system call

  - replaces the memory image of the caller with a new program

    ```c
    int main()
    {
      pid = fork();
      if(pid == 0)	/* this is child */
      {
        printf("\n Hello, I am child! Now I'll run date \n");
        execlp("/bin/date", "/bin/date", (char *)0);
      }
      else if(pid > 0)	/* this is parent */
        printf("\n Hello, I am parent\n");
    }
    
    // execlp() 가 실행됨에 따라 새로운 프로그램이 시작됨
    // 새롭게 프로세스가 생성되면 다시 원래 실행중이던 프로세스로 돌아올 수는 없음
    ```

#### wait() 시스템 콜

- 프로세스 A가 wait() 시스템 콜을 호출하면

  - 커널은 child가 종료될 때까지 프로세스 A를 sleep시킨다(block 상태)
  - child process가 종료되면 커널은 프로세스 A를 깨운다(ready 상태)

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-10 at 8.54.25 PM.png" alt="Screenshot 2022-11-10 at 8.54.25 PM" style="zoom:50%;" />

  > wait()가 실행되면 부모는 자식이 종료 될때까지 정지해 있음

#### exit() 시스템 콜

  - 프로세스의 종료
    - 마지막 statement 수행 후 exit() 시스템 콜을 통해
    - 프로그램에 명시적으로 적어주지 않아도 main함수가 리턴되는 위치가 컴파일러가 넣어줌
  - 비자발적 종료
    - 부모 프로세스가 자식 프로세스를 강제 종료시킴
      - 자식 프로세스가 한계치를 넘어서는 자원 요청
      - 자식에게 할당된 태스크가 더 이상 필요하지 않음
    - 키보드로 kill, break 등을 친 경우
    - 부모가 종료하는 경우
      - 부모 프로세스가 종료하기 전에 자식들이 먼저 종료됨

### 4. 프로세스 간 협력

- 독립적 프로세스(Independent process)
  - 프로세스는 각자의 주소 공간을 가지고 수행되므로 원칙적으로 하나의 프로세스는 다른 프로세스의 수행에 영향을 미치지 못함
- 협력 프로세스(Cooperating process)
  - 프로세스 협력 메커니즘(IPC)을 통해 하나의 프로세스가 다른 프로세스의 수행에 영향을 미칠 수 있음
- 프로세스 간 협력 메커니즘(IPC : interprocess communication)
  - 메시지를 전달하는 방법
    - message passing : 커널을 통해 메시지 전달
  - 주소 공간을 공유하는 방법
    - shared memory : 서로 다른 프로세스 간에도 일부 주소 공간을 공유하게 하는 shared memory 메커니즘이 있음
    - ***thread*** : thread는 사실상 하나의 프로세스이므로 프로세스 간 협력으로 보기는 어렵지만 동일한 process를 구성하는 thread들 간에는 주소 공간을 공유하므로 협력이 가능

### 5. Message Passing

> 운영체제 커널을 통해서 메시지를 전달

- Message system

  - 프로세스 사이에 공유변수(shared variable)를 일체 사용하지 않고 통신하는 시스템

- Direct Communication

  - 통신하려는 프로세스의 이름을 **명시적**으로 표시

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-10 at 9.12.28 PM.png" alt="Screenshot 2022-11-10 at 9.12.28 PM" style="zoom:50%;" />

- Indirect Communication

  - mailbox (또는 port)를 통해 메시지를 **간접 전달**

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-10 at 9.13.40 PM.png" alt="Screenshot 2022-11-10 at 9.13.40 PM" style="zoom:50%;" />

### 6. Interprocess communication

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-10 at 9.15.41 PM.png" alt="Screenshot 2022-11-10 at 9.15.41 PM" style="zoom:50%;" />
