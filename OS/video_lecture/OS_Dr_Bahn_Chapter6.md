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

- Mutual Exclusion
  - 프로세스 Pi가 critical section 부분을 수행 중이면 다른 모든 프로세스들은 그들의 critical section에 들어가면 안 된다
- Progress
  - 아무도 critical section에 있지 않은 상태에서 critical section에 들어가고자 하는 프로세스가 있으면 critical section에 들어가게 해주어야 한다
- Bounded Waiting
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
