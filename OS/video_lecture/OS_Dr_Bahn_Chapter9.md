# Operating System Chapter 9 : Virtual Memory

> 이전 챕터와는 다르게 전적으로 운영체제가 관여하고 있음

### 1. Demand paging

- 실제로 필요할 때 page를 메모리에 올리는 것
  - I/O 양의 감소
  - Memory 사용량 감소
  - 빠른 응답 시간
  - 더 많은 사용자 수용
- Valid / Invalid bit의 사용
  - Invalid 의 의미
    - 사용되지 않는 주소 영역인 경우
    - 페이지가 물리적 메모리에 없는 경우
  - 처음에는 모든 page entry가 invalid로 초기화
  - address translation시에 invalid bit이 set되어 있으면 ==> "page fault"
  
  > CPU가 해당 주소에 접근하고 했을 때 메모리에 올라가 있지 않은 경우, 디스크에 있는 상태이므로 이에 접근하기 위해서 I/O작업을 수행하기 위해 운영체제로 제어가 넘어감

### 2. Memory에 없는 page의 page table

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.10.08 AM.png" alt="Screenshot 2022-11-25 at 3.10.08 AM" style="zoom:50%;" />

> B, D, E 는 물리적 메모리에 올라가지 않아 invalid로 표시
>
> G, H는 사용하지 않는 영역이기 때문에 invalid로 표시

### 3. Page Fault

- invalid page를 접근하면 MMU가 trap을 발생시킴(page fault trap)

- Kernel mode로 들어가서 page fault handler가 invoke됨

- 다음과 같은 순서로 page fault를 처리한다

  1. Invalid reference? (eg. bad address, protection violation) ==> abort process

  2. Get an empty page frame(없으면 뺏어온다 : replace)

  3. 해당 페이지를 disk에서 memory로 읽어온다

     1. disk I/O가 끝나기까지 이 프로세스는 CPU를 preempt당함(block)
     2. Disk read가 끝나면 page tables entry 기록, valid/invalid bit = "valid"
     3. ready queue에 process 를 insert ==> dipatch later

  4. 이 프로세스가 CPU를 잡고 다시 running

  5. 아까 중단되었던 instruction을 재개

### 4. Steps in Handling a page fault

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.24.09 AM.png" alt="Screenshot 2022-11-25 at 3.24.09 AM" style="zoom:50%;" />

### 5. Performance of Demand Paging

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.25.41 AM.png" alt="Screenshot 2022-11-25 at 3.25.41 AM" style="zoom:50%;" />

> 일반적인 경우 page fault는 많이 일어나지 않는다고 함
>
> page fault가 일어났을 경우 굉장히 큰 overhead가 발생함

### 6. Free frame이 없는 경우

- page replacement

  - 어떤 frame을 빼앗아올지 결정해야 함
  - 곧바로 사용되지 않을 page를 쫓아내는 것이 좋음
  - 동일한 페이지가 여러 번 메모리에서 쫓겨났다가 다시 들어올 수 있음

- Replacement Algorithm

  - page-fault rate을 최소화하는 것이 목표

  - 알고리즘의 평가

    - 주어진 page reference string에 대해 page fault를 얼마나 내는지 조사

  - reference string의 예

    - 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5

    > 시간 순대로 페이지가 참조된 순서를 나열한 것
    >
    > 위의 예시를 바탕으로 아래에 replacement algorithm이 설명될 것

### 7. Page Replacement

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.33.33 AM.png" alt="Screenshot 2022-11-25 at 3.33.33 AM" style="zoom:50%;" />

### 8. Optimal Algorithm

> page fault를 가장 적게하는 알고리즘
>
> 실제 시스템에서는 미래를 알 수 없으므로 사용될 수 없음

- MIN(OPT) : 가장 먼 미래에 참조되는 page를 replace

- 4 frames example

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.36.37 AM.png" alt="Screenshot 2022-11-25 at 3.36.37 AM" style="zoom:50%;" />

- 미래의 참조를 어떻게 아는가 ?

  - Offline algorithm

- 다른 알고리즘의 성능에 대한 upper bound 제공

  > 다른 알고리즘이 이 알고리즘 보다 좋을 수는 없으므로 참고로 사용

  - Belay's optimal algorithm, MIN, OPT 등으로 불림

### 9. FIFO(first in first out) algorithm

- FIFO : 먼저 들어온 것을 먼저 내쫓음

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.43.37 AM.png" alt="Screenshot 2022-11-25 at 3.43.37 AM" style="zoom:50%;" />

- FIFO Anomaly(Belady's Anomaly)

  - more frames ==> less page faults

### 10. LRU(Least Recently Used) Algorithm

- LRU : 가장 오래 전에 참조된 것을 지움

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.47.15 AM.png" alt="Screenshot 2022-11-25 at 3.47.15 AM" style="zoom:50%;" />

### 11. LFU(Least Frequently Used) Algorithm

- LFU : 참조 횟수(reference count)가 가장 적은 페이지를 지움
  - 최저 참조 횟수인 page가 여럿 있는 경우
    - LFU알고리즘 자체에서는 여러 page중 임의로 선정한다
    - 성능 향상을 위해 가장 오래 전에 참조된 page를 지우게 구현할 수도 있다
  - 장단점
    - LRU처럼 직전 참조 시점만 보는 것이 아니라 장기적인 시간 규모를 보기 때문에 page의 인기도를 좀 더 정확히 반영할 수 있음
    - 참조 시점의 최근성을 반영하지 못함
    - LRU보다 구현이 복잡함

### 12. LRU와 LFU알고리즘 예제

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 3.57.55 AM.png" alt="Screenshot 2022-11-25 at 3.57.55 AM" style="zoom:50%;" />

### 13. LRU와 LFU알고리즘의 구현

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 4.06.16 AM.png" alt="Screenshot 2022-11-25 at 4.06.16 AM" style="zoom:50%;" />

> LFU 는 링크드 리스트로 구현하면 위처럼 높은 시간복잡도를 가짐
>
> 새로운 참조를 했을 때 LRU는 맨 아래로 보내면 되지만, LFU는 중간에 어느지점에 들어갈지 탐색해야함

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 4.07.38 AM.png" alt="Screenshot 2022-11-25 at 4.07.38 AM" style="zoom:50%;" />

> heap을 이용해서 LFU구현: 시간복잡도 O(log n)

### 14. 다양한 캐슁 환경

- 캐슁 기법
  - 한정된 빠른 공간(=캐쉬)에 요청된 데이터를 저장해 두었다가 후속 요청시 캐쉬로부터 직접 서비스하는 방식
  - paging system외에도 cache memory, buffer cashing, web caching등 다양한 분야에서 사용
- 캐쉬 운영의 시간 제약
  - 교체 알고리즘에서 삭제할 항목을 결정하는 일에 지나치게 많은 시간이 걸리는 경우 실제 시스템에서 사용할 수 없음
  - buffer caching 이나 web caching의 경우
    - O(1)에서 O(log n) 정도까지 허용
  - paging system인 경우
    - page fault인 경우에만 OS가 관여함
    - 페이자가 이미 메모리에 존재하는 경우 참조사각등의 정보를 OS가 알 수 없음
    - O(1)인 LRU의 list 조작조차 불가능

### 15. Paging System에서 LRU, LFU 가능한가?

> 이미 메모리에 올라와 있는 page는 지속적으로 참조하더라도 운영체제가 알 수가 없음
>
> page fault가 발생했을 때만 디스크에서 언제 올라갔는지만 확인가능
>
> > 결론적으로 불가능하다

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 12.53.37 PM.png" alt="Screenshot 2022-11-25 at 12.53.37 PM" style="zoom:50%;" />

### 16. Clock Algorithm

- Clock algorithm

  - LRU의 근사(approximation)알고리즘
  - 여러 명칭으로 불림
    - second chance algorithm
    - NUR(Not Used Recently) 또는 NRU(Not Recently Used)
  - Reference bit을 사용해서 교체 대상 페이지 선정(circular list)

    > reference bit은 하드웨어에서 세팅

  - reference bit가 0인 것을 찾을 때까지 포인터를 하나씩 앞으로 이동
  - 포인터 이동하는 중에 reference bit 1은 모두 0으로 바꿈
  - Reference bit이 0인 것을 찾으면 그 페이지를 교체
  - 한 바퀴 되돌아와서도(=second chance) 0이면 그때에는 replace당함
  - 자주 사용되는 페이지라면 second chance가 올 때 1

- Clock algorithm의 개선

  - reference bit과 modified bit (dirty bit)을 함께 사용
  - reference bit = 1 : 최근에 참조된 페이지
  - modified bit =1 : 최근에 변경된 페이지(I/O를 동반하는 페이지)

    > 메모리에 올라온 이후로 write동작을 수행했는지 여부를 확인
    >
    > 1이면 내용이 수정되었으므로, 메모리에서 나갈때 수정부분을 반영
  
  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 12.52.58 PM.png" alt="Screenshot 2022-11-25 at 12.52.58 PM" style="zoom:50%;" />
  
### 17. Page Frame의 Allocation

- Allocation problem : 각 process 에 얼마만큼의 page frame을 할당할 것인가?
- Allocation 의 필요성
  - 메모리 참조 명령어 수행시 명령어, 데이터 등 여러 페이지 동시 참조
    - 명령어 수행을 위해 최소한 할당되어야 하는 frame의 수가 있음
  - Loop를 구성하는 page들은 한꺼번에 allocate되는 것이 유리함
    - 최소한의 allocation이 없으면 매 loop마다 page fault
- Allocation Scheme
  - Equal allocation : 모든 프로세스에 똑같은 갯수 할당
  - Proportional allocation : 프로세스 크기에 비례하여 할당
  - Priority allocation : 프로세스의 priority에 따라 다르게 할당

  ### 18. Global va. Local Replacement

- Global replacement
  - Replace 시 다른 process에 할당된 frame을 빼앗아 올 수 있다
  - process별 할당량을 조절하는 또 다른 방법임
  - FIFO, LRU, LFU등의 알고리즘을 global replacement로 사용시에 해당
  - Working set, PFF알고리즘 사용
- Local replacement
  - 자신에게 할당된 frame 내에서만 replacement
  - FIFO, LRU, LFU등의 알고리즘을  process별로 운영시

### 19. Thrashing

- Thrashing
  - 프로세스의 원활한 수행에 필요한 최소한의 page frame수를 할당 받지 못한 경우 발생
  - page fault rate이 매우 높아짐
  - CPU utilization 이 낮아짐
  - OS는 MPD(Multiprogramming degree)를 높여야 한다고 판단
  - 또 다른 프로세스가 시스템에 추가됨(higher MPD)
  - 프로세스 당 할당된 frame의 수가 더욱 감소
  - 프로세스는 page의 swap in/ swap out으로 매우 바쁨
  - 대부분의 시간에 CPU는 한가함
  - low throughput

#### Thrashing diagram

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 1.15.12 PM.png" alt="Screenshot 2022-11-25 at 1.15.12 PM" style="zoom:50%;" />

> 메모리에 프로세스가 많이 올라갈수록 일부가 I/O작업을 하더라도 CPU는 다른 프로세스를 처리할 수 있음
>
> > 어느 지점에 도달 했을 때 utilization이 뚝 떨어짐 ==> thrashing

### 20. Working-Set Model

- Locality of reference
  - 프로세스는 특정 시간 동안 일정 장소만을 집중적으로 참조한다
  - 집중적으로 참조되는 해당 page들의 집합을 locality set이라 함
- Working-set Model
  - Locality에 기반하여 프로세스가 일정 시간 동안 원활하게 수행되기 위해 한꺼번에 메모리에 올라와 있어야 하는 page들의 집합을 **working set** 이라 정의함
  - working set 모델에서는 process의 working set 전체가 메모리에 올라와 있어야 수행되고 그렇지 않을 경우 모든 frame을 반납한 후 swap out(suspend)
  - Thrashing 을 방지함
  - Multiprogramming degree를 결정함

### 21. Working-Set Algorithm

> 과거 데이터를 통해 추정

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 1.24.43 PM.png" alt="Screenshot 2022-11-25 at 1.24.43 PM" style="zoom:50%;" />

### 22. PFF(Page-Fault Frequency) Scheme

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-25 at 1.28.31 PM.png" alt="Screenshot 2022-11-25 at 1.28.31 PM" style="zoom:50%;" />

- page-fault rate의 상한값과 하한값을 둔다
  - page fault rate이 상한값을 넘으면 frame을 더 할당한다
  - page fault rate이 하한값 이하이면 할당 frame 수를 줄인다
- 빈 frame이 없으면 일부 프로세스를 swap out

### 23. Page Size의 결정

- page size를 감소시키면 
  - 페이지 수 증가
  - 페이지 테이블 크기 증가
  - internal fragmentation 감소
  - disk transfer의 효율성 감소
    - seek/rotation vs. transfer
  - 필요한 정보만 메모리에 올라와 메모리 이용이 효율적
    - Locality 의 활용 측면에서는 좋지 않음
- Trend
  - Larger page size
