# Operating System Chapter 6 : Process Synchronization

### 1. 데이터의 접근

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 9.46.53 PM.png" alt="Screenshot 2022-11-16 at 9.46.53 PM" style="zoom:50%;" />

- Race Condition

  <img src="/Users/yangsiseon/Library/Application Support/typora-user-images/Screenshot 2022-11-16 at 9.48.36 PM.png" alt="Screenshot 2022-11-16 at 9.48.36 PM" style="zoom:50%;" />

  > 일반적으로 CPU가 1개일 경우에는 문제가 없으나 Multiproceseeor일 경우 race condition이 생길 수 있음
  >
  > 프로세스 역시 고유의 주소 공간을 사용하므로 일반적으로 문제가 없으나, 공유 메모리를 사용하거나 시스템 콜 등을 수행할 때 race condition가능성이 있음

### 2. OS에서 race condition은 언제 발생하는가?

1. kernel 수행 중 인터럽트 발생 시
2. Process가 system call을 하여 kernel mode로 수행 중인데 context switch가 일어나는 경우
3. Multiprocessor에서 shared memory 내의 kernel data

#### (1/3) Interrupt handler v.s. Kernel

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 9.58.22 PM.png" alt="Screenshot 2022-11-16 at 9.58.22 PM" style="zoom:50%;" />

> count수행중 인터럽트 발생 시 race condition을 발생시킴 ==> 따라서, race condition을 발생시킬 수 있는 동작 수행중에는 interrupt가 들어오더라도 수행하지 않는 방식으로 문제해결

- 커널 모드 running 중 interrupt가 발생하여 인터럽트 처리루틴이 수행
  - 양쪽 다 커널 코드이므로 kernel address space공유


#### (2/3) Preempt a process running in kernel?

<img src="/Users/yangsiseon/Library/Application Support/typora-user-images/Screenshot 2022-11-16 at 10.04.44 PM.png" alt="Screenshot 2022-11-16 at 10.04.44 PM" style="zoom:50%;" />

- 두 프로세스의 address space 간에는 data sharing이 없음
- 그러나 system call을 하는 동안에는 kernel address space의 data를 access하게 됨(share)
- 이 작업 중간에 CPU를 preempt해가면 race condition발생 (아래 그림 참조)

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 10.07.04 PM.png" alt="Screenshot 2022-11-16 at 10.07.04 PM" style="zoom:50%;" />

- 해결책 : 커널 모드에서 수행 중일 때는 CPU를 preempt하지 않음
  - 커널 모드에서 사용자 모드로 돌아갈 때 preempt

#### (3/3) Multiprocessor

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 10.11.08 PM.png" alt="Screenshot 2022-11-16 at 10.11.08 PM" style="zoom:50%;" />

- 어떤 CPU가 마지막으로 count를 store했는가? ==> race condition

  multiprocessor의 경우 interrupt enable/disable로 해결되지 않음

- (방법 1) 한번에 하나의 CPU만이 커널에 들어갈 수 있게 하는 방법

  > 커널에 대한 접근이 막히므로 비교적 비효율적인 방법일 수 있음

- (방법 2) 커널 내부에 있는 각 공유 데이터에 접근할 때마다 그 데이터에 대한 Lock/unlock을 하는 방법

### 3. Process Synchronization 문제

- 공유 데이터(shared data)의 동시 접근(concurrent access)은 데이터의 불일치 문제(inconsistency)를 발생시킬 수 있다
- 일관성(consistency) 유지를 위해서는 협력 프로세스(cooperating process)간의 실행 순서(orderly execution)를 정해주는 메커니즘 필요
- Race condition
  - 여러 프로세스들이 동시에 공유 데이터를 접근하는 상황
  - 데이터의 최종 연산 결과는 마지막에 그 데이터를 다룬 프로세스에 따라 달라짐
- race condition을 막기 위해서는 concurrent process는 동기화(sychronize)되어야 한다

### 4. Example of a Race Condition

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 11.28.25 AM.png" alt="Screenshot 2022-11-17 at 11.28.25 AM" style="zoom:50%;" />

> 사용자 프로세스 P1수행중 timer interrupt가 발생해서 context switch가 일어나서 P2가 CPU를 잡으면?
>
> > 일반적으로는 문제가 없는 상황이지만, 공유 데이터에 접근하는 상황이거나 커널함수가 동작중일때는 문제가 될 수 있음

### 5. The Critical-Section Problem

> 임계구역 : 공유 데이터에 접근하는 코드를 의미

- n개의 프로세스가 공유 데이터를 동시에 사용하기를 원하는 경우

- 각 프로세스의 code segment에는 공유 데이터를 접근하는 코드인 critical section이 존재

- Problem

  - 하나의 프로세스가 critical section에 있을 때 다른 모든 프로세스는 critical section에 들어갈 수 없어야 한다

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 11.33.26 AM.png" alt="Screenshot 2022-11-17 at 11.33.26 AM" style="zoom:50%;" />

### 6. 프로그램적 해결법의 충족 조건

- Mutual Exclusion (상호 배제)
  - 프로세스 Pi가 critical section 부분을 수행 중이면 다른 모든 프로세스들은 그들의 critical section에 들어가면 안 된다
- Progress (진행)
  - 아무도 critical section에 있지 않은 상태에서 critical section에 들어가고자 하는 프로세스가 있으면 critical section에 들어가게 해주어야 한다
- Bounded Waiting (유한 대기)
  - 프로세스가 critical section에 들어가려고 요청한 후부터 그 요청이 허용될 때까지 다른 프로세스들이 critical section에 들어가는 횟수에 한계가 있어야 한다
- 가정
  - 모든 프로세스의 수행 속도는 0보다 크다
  - 프로세스들 간의 상대적인 수행 속도는 가정하지 않는다

### 7. Initial Attempts to Solve Problem

- 두 개의 프로세스가 있다고 가정 P0, P1

- 프로세스들의 일반적인 구조

  ```c
  do{
    entry section
    critical section
    exit section
    remainder section
  } while(1);
  ```

- 프로세스들은 수행의 동기화 (synchronize)를 위해 몇몇 변수를 공유할 수 있다 ==> synchronization variable

### 8. Algorithm 1

- Synchronization variable

  int turn;

  initially turn = 0;	=>	Pi can enter its ciritical section if (turn == i)

- Process P0

  ``` c
  do {
    while (turn != 0);	/* My turn? */
    critical section
    turn = 1;						/* Now it's your turn */
    remainder section
  } while (1);
  ```
  
- Satisfies mutual exclusion, but not progress

  즉, 과잉양보: 반드시 한번씩 교대로 들어가야만 함(swap-turn)
  
  그가 turn을 내값으로 바꿔줘야만 내가 들어갈 수 있음
  
  특정 프로세스가 더 빈번히 critical section을 들어가야 한다면?

> 자기 turn이 아닐때는 while문 안에 갇혀있다가, 상대 쪽에서 ciritical section을 벗어나면 turn을 1로 만들어줌
>
> > Mutual exclusion 조건은 만족하나, Progress는 만족하지 못함

### 9. Algorithm 2

- Synchronization variables

  - boolean flag[2];

    initially flag[모두] = false;	/* no one is in CS */

  - "Pi ready to enter its ciritical section" if (flag[i] == true)

- Process Pi

  ```c
  do {
    flag[i] = true;		/* Pretend I am in */
    while (flag[j]);	/* Is he also in? then wait */
    critical section
    flag[i] = false;	/* I am out now */
    remainder section
  } while(1);
  ```

- Satisfies mutual exclusion, but not progress requirement.

- 둘 다 2행까지 수행 후 끊임 없이 양보하는 상황 발생 가능

> 둘다 flag가 true일 때 둘 다 못 들어가는 상황 발생
>
> > Mutual exclution 조건은 만족하나, Progress 조건은 만족하지 못함

### 10. Algorithm 3 (Peterson's Algorithm)

> 앞에서 사용했던 turn과 flag를 모두 사용하는 알고리즘

- Combined synchronization variables of algoritms 1 and 2.

- Process Pi

  ```c
  do {
    flag[i] = true;			/* My intention is to enter ... */
    turn = j;						/* Set to his turn */
    while (flag[j] && turn == j);	/* wait only if ... */
    critical section
    flag[i] = false;
    remainder section
  } while (1);
  ```

- Meets all three requirements; solves the critical section problem for two processes.

  > Mutual Exclusion, Progress, Bounded Waiting을 모두 만족

- Busy Waiting(=spin lock)! (계속 CPU와 memory를 쓰면서 wait)

  > 비효율적인 방식으로 동작한다고 볼 수 있음

### 11. Synchronization Hardware

- 하드웨어적으로 Test & modify를 atomic하게 수행할 수 있도록 지원하는 경우 앞의 문제는 간단히 해결

  > 일반적으로 데이터에 접근하고 값을 변경하는 동작이 여러 instruction을 통해 수행되기 때문에 문제가 생김, 하나의 instruction에서 처리된다면 간단하게 해결 가능

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-05 at 5.25.21 PM.png" alt="Screenshot 2023-04-05 at 5.25.21 PM" style="zoom:50%;" />

- Mutual Exclusion with Test & Set

  > Test & set : 데이터를 읽음과 동시에 특정 값으로 세팅하는 동작을 하나의 instruction에서 처리

  ```c
  Synchronization variable:
  	boolean lock = false;
  Process Pi
    do {
      while (Test_and_Set(lock));
      critical section
      lock = false;
      remainder section
    }
  ```

### 12. Semaphores

- 앞의 방식들을 추상화시킴

- Semaphore S

  - integer variable

  - 아래의 두 가지 atomic 연산에 의해서만 접근 가능

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-06 at 2.49.00 PM.png" alt="Screenshot 2023-04-06 at 2.49.00 PM" style="zoom:50%;" />

    > P 연산 : 공유데이터를 획득하는 과정
    >
    > V 연산 : 자원을 다 사용하고 반납하는 과정

### 13. Critical Section of n Processes

```c
Synchronization variable
  semaphore mutex;	/* initially 1 : 1개가 CS에 들어갈 수 있다 */

Process Pi
do {
  P(mutex);					/* If positive, dec-&-enter, Otherwise, wait */
  critical section
  V(mutex);					/* Increment semaphore */
  remainder section
} while (1);
```

busy-wait는 효율적이지 못함(=spin lock)

Block & Wakeup 방식의 구현 (=sleep lock)

### 14. Block / Wakeup Implementation

- Semaphore를 다음과 같이 정의

  ```c
  typedef struct
  {
    int value;			/* semaphore */
    struct process *L	/* process wait queue */
  } semaphore;
  ```

- block과 wakeup을 다음과 같이 가정

  - block : 커널은 block을 호출한 프로세스를 suspend 시킴

    ​			이 프로세스의 PCB를 semaphore에 대한 wait queue에 넣음

  - wakeup(P) : block된 프로세스 P를 wakeup시킴

    ​					이 프로세스의 PCB를 ready queue로 옮김

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-06 at 3.24.47 PM.png" alt="Screenshot 2023-04-06 at 3.24.47 PM" style="zoom:50%;" />

### 15. Implementation
> block/wakeup version of P() & V()

- Semaphore 연산이 이제 다음과 같이 정의됨

  ```c
  P(S) :
  S.value--;			/* prepare to enter */
  if (S.value < 0)	/* Oops, negative, I cannot enter */
  {
    add this process to S.L;
    block();
  }
  ```

  ```c
  V(S) :
  S.value++;
  if (S.value <= 0) {
    remove a process P from S.L;
    wakeup(P);
  }
  ```

  > 여기에서 S.value가 자원의 개수를 의미하지는 않음
  >
  > 먼저 value값을 감소시키고 block되기 때문에 V연산에서 value가 음수를 가지면 특정 프로세스들이 자원의 사용을 기다리고 있다는 의미

### 16. Which is better?

- Busy-wait v.s. Block/wakeup
- Block/wakeup overhead v.s. Critical section길이
  - Critical section의 길이가 긴 경우 Block/Wakeup이 적당
  - Critical section의 길이가 매우 짧은 경우 Block/Wakeup 오버헤드가 busy-wait 오버헤드보다 더 커질 수 있음
  - 일반적으로는 Block/wakeup 방식이 더 좋음

### 17. Two Types of Semaphores

- Counting semaphore
  - 도메인이 0이상인 임의의 정수값
  - 주로 resource counting에 사용
- Binary semaphore( = mutex)
  - 0또는 1값만 가질 수 있는 semaphore
  - 주로 mutual exclution (lock/unlock)에 사용

### 18. Deadlock and Starvation

- Deadlock

  - 둘 이상의 프로세스가 서로 상대방에 의해 충족될 수 있는 event를 무한히 기다리는 형상

- S와 Q가 1로 초기화된 semaphore라 하자

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 2.40.36 PM.png" alt="Screenshot 2023-04-08 at 2.40.36 PM" style="zoom:50%;" />

- Starvation

  - indefinite blocking : 프로세스가 suspend된 이유에 해당하는 세마포어 큐에서 빠져나갈 수 없는 현상

### 19. Classical Problems of Synchronization

- Bounded-Buffer Problem(Producer-Consumer-Problem)

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 2.51.06 PM.png" alt="Screenshot 2023-04-08 at 2.51.06 PM" style="zoom:50%;" />

  > 주황색은 producer가 데이터를 생성하여 넣어놓은 상태
  >
  > 회색은 데이터가 없이 비어있는 상태

  - Shared data

    - buffer 자체 및 buffer 조작 변수 (empty/full buffer의 시작 위치)

  - Synchronization variables

    - mutual exclusion ==> Need binary semaphore(shared data의 mutual exclusion을 위해)
    - resource count ==> Need integer semaphore(남은 full/empty buffer의 수 표시)

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 3.04.05 PM.png" alt="Screenshot 2023-04-08 at 3.04.05 PM" style="zoom:50%;" />

- Readers and Writers Problem

  - 한 process가 DB에 write 중일 때 다른 process가 접근하면 안됨
  - read는 동시에 여럿이 해도 됨
  - solution
    - writer가 DB에 접근 허가를 아직 얻지 못한 상태에서는 모든 대기중인 Reader들을 다 DB에 접근하게 해준다
    - Writer는 대기 중인 Reader가 하나도 없을 때 DB접근이 허용된다
    - 일단 Writer가 DB에 접근 중이면 Reader들은 접근이 금지된다
    - Writer가 DB에서 빠져나가야만 Reader의 접근이 허용된다
  - Shared data
    - DB 자체
    - readcount;	/* 현재 DB에 접근 중인 Reader의 수 */
  - Synchronization variables
    - mutex	/* 공유 변수 readcount를 접근하는 코드 (critical section)의 mutual exclusion 보장을 위해 사용 */
    - db	/* Reader와 writer가 공유 DB 자체를 올바르게 접근하게 하는 역할 */

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 3.14.56 PM.png" alt="Screenshot 2023-04-08 at 3.14.56 PM" style="zoom:50%;" />

  > 처음 들어온 Reader, 마지막으로 나가는 Reader가 각각 db에 대한 lock/unlock을 진행

- Dining-Philosophers Problem

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 3.57.17 PM.png" alt="Screenshot 2023-04-08 at 3.57.17 PM" style="zoom:50%;" />

  - 앞의 solution의 문제점

    - Deadlock 가능성이 있다
    - 모든 철학자가 동시에 배가 고파져 왼쪽 젓가락을 집어버린 경우

  - 해결 방안

    - 4명의 철학자만이 테이블에 동시에 앉을 수 있도록 한다
    - 젓가락을 두 개 모두 잡을 수 있을 때에만 젓가락을 집을 수 있게 한다
    - 비대칭
      - 짝수 (홀수) 철학자는 왼쪽 (오른쪽) 젓가락부터 집도록

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 4.04.50 PM.png" alt="Screenshot 2023-04-08 at 4.04.50 PM" style="zoom:50%;" />

    > semaphore self : 1이면 해당 철학자가 젓가락을 모두 잡을 수 있다는 의미

### 20. Monitor

- Semaphore의 문제점

  - 코딩하기 힘들다

  - 정확성(correctness)의 입증이 어렵다

  - 자발적 협력(voluntary cooperation)이 필요하다

  - 한번의 실수가 모든 시스템에 치명적 영향

  - 예

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 4.15.51 PM.png" alt="Screenshot 2023-04-08 at 4.15.51 PM" style="zoom:50%;" />

  - 동시 수행중인 프로세스 사이에서 abstract data type의 안전한 공유를 보장하기 위한 high-level synchronization construct

    ```c
    monitor monitor-name
    {
      shared variable declarations
      procedure body P1 (...) {
        ...
      }
      procedure body P1 (...) {
        ...
      }
      procedure body Pn (...) {
        ...
      }
      {
        initialization code
      }
    }
    ```

    ​    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 4.20.49 PM.png" alt="Screenshot 2023-04-08 at 4.20.49 PM" style="zoom:50%;" />

- 모니터 내에서는 한번에 하나의 프로세스만이 활동 가능

- 프로그래머가 동기화 제약 조건을 명시적으로 코딩할 필요없음

- 프로세스가 모니터 안에서 기다릴 수 있도록 하기 위해 condition variable사용 `condition x, y;`

- condition variable은 wait와 signal 연산에 의해서만 접근 가능

  - x.wait();
    - x.wait()을 invoke한 프로세스는 다른 프로세스가 x.signal()을 invoke하기 전까지 suspend된다
  - x.signal();
    - x.signal()은 정확하게 하나의 suspend된 프로세스를 resume한다
    - suspend된 프로세스가 없으면 아무 일도 일어나지 않는다

- Bounded-Buffer Problem

  ```c
  monitor bounded_buffer
  {
    int buffer[N];
    condition full, empty;
    /* condition var.은 값을 가지지 않고 자신의 큐에 프로세스를 매달아서 sleep 시키거나 큐에서 프로세스를 깨우는 역할만 함 */
    
    void produce(int x)
    {
      if there is no empty buffer
        empty.wait();
      add x to an empty buffer
        full.signal();
    }
    
    void consume(int *x)
    {
      if there is no full buffer
        full.wait();
      remove an item from buffer and store it to *x
        empty.signal();
    }
  }
  ```

- Dining Philosophers Example

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2023-04-08 at 6.19.07 PM.png" alt="Screenshot 2023-04-08 at 6.19.07 PM" style="zoom:50%;" />
