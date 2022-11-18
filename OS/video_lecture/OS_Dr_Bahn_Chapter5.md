# Operating System Chapter 5 : CPU Scheduling

### 1. CPU and I/O Bursts in Program Execution

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-11 at 12.47.30 PM.png" alt="Screenshot 2022-11-11 at 12.47.30 PM" style="zoom:50%;" />

> 어떤 프로그램이든 동작하는 동안 CPU작업과 I/O를 번갈아 가며 수행

### 2. CPU burst Time의 분포

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-11 at 12.50.47 PM.png" alt="Screenshot 2022-11-11 at 12.50.47 PM" style="zoom:50%;" />

> 여러 종류의 jop(=process)이 섞여 있기 때문에 CPU스케줄링이 필요하다
>
> > I/Obound job : I/O작업이 많은 부분(빈도가 많음)
> >
> > CPU bound job : I/O작업이 없어 CPU가 지속적으로 작업을 수행하는 시간이 긴 부분(빈도가 비교적 적음)

- Interactive job에게 적절한 response 제공 요망
- CPU와 I/O장치 등 시스템 자원을 골고루 효율적으로 사용

### 3. 프로세스의 특성 분류

- 프로세스는 그 특성에 따라 다음 두 가지로 나눔
  - I/O bound process
    - CPU를 잡고 계산하는 시간보다 I/O에 많은 시간이 필요한 job
    - (many short CPU bursts)
  - CPU bound process
    - 계산 위주의 job
    - (few very long CPU bursts)

### 4. CPU Scheduler & Dispatcher

- CPU Scheduler

  > 별도의 H/W, S/W가 아니며 운영체제 내부에 별도로 구현되어 있음

  - Ready상태의 프로세스 중에서 이번에 CPU를 줄 프로세스를 고른다

- Dispatcher

  > 스케줄러와 동일하게 운영체제 내부에 구현되어 있음
  >
  > 실제로 CPU제어권을 넘기는 역할을 수행

  - CPU의 제어권을 CPU scheduler에 의해 선택된 프로세스에게 넘긴다
  - 이 과정을 context switch(문맥 교환)라고 한다

- CPU 스케줄링이 필요한 경우는 프로세스에게 다음과 같은 상태 변화가 있는 경우이다

  1. Running --> Blocked (예: I/O요청하는 시스템 콜)
  2. Running --> Ready(예 : 할당시간만료로 timer interrupt)
  3. Blocked --> Ready(예 : I/O완료 후 인터럽트)
  4. Terminate

  > - 1, 4 에서의 스케줄링은 nonpreemptive(=강제로 빼앗지 않고 자진 반납)
  >
  > - All other scheduling is preemptive(=강제로 빼앗음)

### 5. Scheduling Algorithms

> 크게 nonpreemprive한 방식(비선점형)과 preemprive한 방식(선점형)으로 나눌 수 있음

#### FCFS(first-come first-served)

> 비선점형 방식, 한 프로세스가 CPU를 오래 점유하므로 효율적이지 않음

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-11 at 1.37.35 PM.png" alt="Screenshot 2022-11-11 at 1.37.35 PM" style="zoom:50%;" />

  - waiting time for 
$$
    P1 = 0; P2 = 24; P3 =27
$$

  - Average waiting time 
$$
(0 + 24 + 27) / 3 = 17
$$

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-11 at 1.51.00 PM.png" alt="Screenshot 2022-11-11 at 1.51.00 PM" style="zoom:50%;" />

  - Waiting time for
    $$
    P1 = 6; P2 = 0; P3 =3
    $$

- Average waiting time
  $$
  (6 + 0 + 3) / 3 = 3
  $$

- Much better than previous case

- **Convoy effect** :  short process behind long process

#### SJF(Shortest-Job-First)

> average waiting time이 가장 짧음

- 각 프로세스의 다음번 CPU burst time 을 가지고 스케줄링에 활용

- CPU burst time이 가장 짧은 프로세스를 제일 먼저 스케줄

- Two schemes:
  - Nonpreemptive
    - 일단 CPU를  잡으면 이번 CPU burst가 완료될 때까지 CPU를 선점(preemption)당하지 않음
  - Preemptive
    - 현재 수행중인 프로세스의 남은 burst time 보다 더 짧은 CPU burst time을 가지는 새로운 프로세스가 도착하면 CPU를 빼앗김
    - 이 방법을 shortest-remaining-time-first(SRTF)이라고도 부른다
  
- SJF is optimal
  
  > preemptive 한 버전에 대한 설명
  
  - 주어진 프로세스들에 대해 minimum average waiting time을 보장
  
- Example of Non-Preemptive SJF

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-11 at 2.06.29 PM.png" alt="Screenshot 2022-11-11 at 2.06.29 PM" style="zoom:50%;" />

- Average waiting time = 
  $$
  (0 + 6 + 3 + 7) / 4 = 4
  $$

- Example of Preemptive SJF

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 6.20.51 PM.png" alt="Screenshot 2022-11-16 at 6.20.51 PM" style="zoom:50%;" />

- Average waiting time =
  $$
  (9 + 1 + 0 + 2) / 4 = 3
  $$

> 가장 빠른 알고리즘이지만 특정 작업(Long process)은 평생 CPU를 얻지 못하는 starvation(기아 현상) 문제가 발생할 수 있음
>
> CPU burst time을 알 수 없는 문제도 있음

#### Priority Scheduling

- A priority number (integer) is associated with each process

  > 정수값으로 우선순위 표현

- highest priority를 가진 프로세스에게 CPU할당( smallest integer = highest priority)

  > 일반적으로 낮은 정수값이 높은 우선순위를 의미

  - Preemptive
  - nonpreemptive

- SJF는 일종의 priority scheduling이다

  - priority = predicted next CPU burst time

- Problem

  - Starvation(기아 현상) : low priority processes may never execute

- Solution

  - Aging(노화) : as time progresses increase the priority of the process

    > 우선순위가 낮더라도 오래 기다리면 우선순위를 높혀주는 방식

#### Round Robin(RR)

> 응답시간이 빠르다는 장점이 있음

- 각 프로세스는 동일한 크기의 할당 시간(time quantum)을 가짐(일반적으로 10 -100 milliseconds)

- 할당 시간이 지나면 프로세스는 선점(preempted)당하고 ready queue의 제일 뒤에 가서 다시 줄을 선다

- n개의 프로세스가 ready queue에 있고 할당 시간이 q time unit인 경우 각 프로세스는 최대 q time unit단위로 CPU 시간의 1/n을 얻는다

  - 어떤 프로세스도 (n-1)q time unit이상 기다리지 않는다

- Performance

  - q large ==> FCFS
  - q small ==> context switch 오버헤드가 커진다

- Example : RR with time quantum = 20

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 6.59.13 PM.png" alt="Screenshot 2022-11-16 at 6.59.13 PM" style="zoom:50%;" />

  > 일반적으로 SJF보다 average turnaround time이 길지만 response time은 더 짧다
  >
  > 모든 동작이 시간이 동일하다면, 모든 동작들이 늦게 완료된다는 단점이 있음(RR은 각 동작들의 시간이 들쭉날쭐하며 예측되지 않을 때 사용하기 좋음)

- Turnaround Time Varies With Time Quantum

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 7.01.28 PM.png" alt="Screenshot 2022-11-16 at 7.01.28 PM" style="zoom:50%;" />

#### Multilevel Queue

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 7.11.50 PM.png" alt="Screenshot 2022-11-16 at 7.11.50 PM" style="zoom:50%;" />

- Ready queue를 여러 개로 분할

  > 해당 예시는 queue가 2개인 경우에 대해서 기술 (foreground, background)

  - foreground(interactive)
  - background(batch - no human interaction)

- 각 큐는 독립적인 스케줄링 알고리즘을 가짐

  - foreground - RR
  - background - FCFS

- 큐에 대한 스케줄링이 필요

  - Fixed priority scheduling
    - serve all from foreground then from background
    - Possibility of starvation
  - Time slice
    - 각 큐에 CPU time을 적절한 비율로 할당
    - eg., 80% to foreground in RR, 20% to background in FCFS

#### Multilevel Feedback Queue

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 7.14.46 PM.png" alt="Screenshot 2022-11-16 at 7.14.46 PM" style="zoom:50%;" />

> CPU burst time이 짧은 프로세스에게 더 많이 할당하도록 구성되어 있음

- 프로세스가 다른 큐로 이동 가능
- 에이징(aging)을 이와 같은 방식으로 구현할 수 있다
- Multilevel-feedback-queue scheduler를 정의하는 파라미터들
  - Queue의 수
  - 각 큐의 scheduling algorithm
  - Process를 상위 큐로 보내는 기준
  - Process를 하위 큐로 내쫓는 기준
  - 프로세스가 CPU 서비스를 받으려 할 때 들어갈 큐를 결정하는 기준
- Example of Multilevel Feedback Queue
  - Three queues : 
    - Q0 - time quantum 8 milliseconds
    - Q1 - time quantum 16 milliseconds
    - Q2 - FCFS
  - Scheduling
    - new job이 queue Q0로 들어감
    - CPU를 잡아서 할당 시간 8 milliseconds 동안 수행됨
    - 8 milliseconds 동안 다 끝내지 못했으면 queue Q1으로 내려감
    - Q1 에 줄서서 기다렸다가 CPU를 잡아서 16ms동안 수행됨
    - 16ms에 끝내지 못한 경우 queue Q2로 쫓겨남

### 6. Scheduling Criteria

> Performance Index(= Performance Measure : 성능 척도)
>
> 스케줄링 알고리즘의 성능을 파악하는데 적용
>
> > 이용률과 처리량은 시스템 입장에서의 척도 / 나머지 소요, 대기, 응답 시간은 프로그램 입장에서의 척도

- CPU utilization(이용률)

  > 전체 시간에서 CPU가 동작한 시간의 비율(높을수록 좋음)
  >
  > 예) 주방장이 일한 시간

  - keep the CPU as busy as possible

- Throughput(처리량)

  > 주어진 시간동안 얼마나 많은 작업을 처리했는지
  >
  > 예) 얼마나 많은 손님들이 음식을 먹고 나갔는지

  - #of processes that complete their execution per time unit

- Turnaround time (소요시간, 반환시간)

  > CPU얻기 위해 기다린 시간부터 작업을 완료하고 나갈때까지 걸린 시간
  >
  > 예) 손님이 들어와 주문하고 식사를 마치고 나갈때까지 걸리는 시간

  - amount of time to execute a particular process

- Waiting time(대기 시간)

  > ready queue에서 CPU를 얻을 때까지 기다린 시간
  >
  > > 중간에 CPU제어권을 잃고 다시 기다리는 시간들을 모두 포함한 개념
  >
  > 예) 손님이 기다린 시간

  - amount of time a process has been waiting in the ready queue

- Responce time(응답 시간)

  > ready queue에 들어와서 **최초**로 CPU를 얻기까지 걸린시간
  >
  > 예) 손님에게 첫번째 음식이 나올때까지 걸린 시간

  - amount of time it takes from when a request was submitted until the first response is produced, not output(for time-sharing environment)

### 7. 다음 CPU Burst time의 예측

- 다음범 CPU burst time을 어떻게 알 수 있는가? (input data, branch, user ...)

- 추정(estimate) 만이 가능하다

- 과거의 CPU burst time을 이용해서 추정 (exponential averaging)

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 6.39.20 PM.png" alt="Screenshot 2022-11-16 at 6.39.20 PM" style="zoom:50%;" />

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 6.39.50 PM.png" alt="Screenshot 2022-11-16 at 6.39.50 PM" style="zoom:50%;" />

### 8. Multiple-Processor Scheduling

- CPU가 여러 개인 경우 스케줄링은 더욱 복잡해짐

- Homogeneous processor인 경우

  - Queue에 한줄로 세워서 각 프로세서가 알아서 꺼내가게 할 수 있다
  - 반드시 특정 프로세서에서 수행되어야 하는 프로세스가 있는 경우에는 문제가 더 복잡해짐

- Load sharing

  - 일부 프로세서에 job이 몰리지 않도록 부하를 적절히 공유하는 메커니즘 필요
  - 별개의 큐를 두는 방법 vs. 공동 큐를  사용하는 방법

- Symmetric Multiprocessing(SMP)

  > 모든 CPU가 대등함

  - 각 프로세서가 각자 알아서 스케줄링 결정

- Asymmetric Multiprocessing

  - 하나의 프로세서가 시스템 데이터의 접근과 공유를 책임지고 나머지 프로세서는 거기에 따름

### 9. Real-Time Scheduling

- Hard real-time systems
  - Hard real-time task는 정해진 시간 안에 반드시 끝내도록 스케줄링해야 함
- Soft real-time computing
  - Soft real-time task는 일반 프로세스에 비해 높은 priority를 갖도록 해야 함

### 10. Thread Scheduling

- Local Scheduling
  - User level thread의 경우 사용자 수준의 thread library에 의해 어떤 thread를 스케줄 할지 결정
- Global scheduling
  - Kernel level thread의 경우 일반 프로세스와 마찬 가지로 커널의 단기 스케줄러가 어떤 thread를 스케줄할지 결정

### 11. Algorithm Evaluation

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-16 at 7.56.12 PM.png" alt="Screenshot 2022-11-16 at 7.56.12 PM" style="zoom:50%;" />

- Queueing models
  - 확률 분포로 주어지는 arrival rate와 service rate등을 통해 각종 performance index값을 계산
- Implementation(구현) & Measurement(성능 측정)
  - 실제 시스템에 알고리즘을 구현하여 실제 작업(workload)에 대해서 성능을 측정 비교
- Simulation(모의 실험)
  - 알고리즘을 모의 프로그램으로 작성후 trace를 입력으로 하여 결과 비교