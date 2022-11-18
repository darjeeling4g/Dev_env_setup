# Operating System Chapter 8 : Memory Management

> 해당 챕터에 나오는 내용은 OS가 주요한 역할을 수행하지 않음
>
> 대부분 하드웨어 단에서 처리하는 사항들임
>
> > 물리적 주소에 매핑해주는 MMU
> >
> > 주소변환 시에도 운영체제의 도움없이 CPU가 메모리에 직접접근 하기 때문

### 1. Logical vs. Physical Address

- Logical address (= virtual address)

  - 프로세스마다 독립적으로 가지는 주소 공간

  - 각 프로세스마다 0번지부터 시작

  - **CPU가 보는 주소는 logical address임**

    > 컴파일과정에서의 생성된 주소는 동일한 물리적 주소로 올라가지 않지만, 각 instruction들은 논리주소에 대한 정보로 작성되어 있음
    >
    > 즉, CPU는 instruction을 수행할때 컴파일되면서 정의된 논리주소를 기반으로 작업을 처리해야 하므로 논리주소를 보는 것임

- Physical address

  - 메모리에 실제 올라가는 위치

- 주소 바인딩 : 주소를 결정하는 것

  Symbolic Address ==> Logical Address ==> Physical address

  > Symbolic Address : 프로그래머 입장에서 실제 숫자로 된 주소를 정의하지 않음( 컴파일 되는 과정에서 변환 )

### 2. 주소 바인딩(Address Binding)

- Compile time binding

  > 컴파일 시점에 물리적 주소 결정 : 논리주소가 곧 물리주소
  >
  > 비효율적인 방식으로 현재는 사용하지 않음

  - 물리적 메모리 주소(physical address)가 컴파일 시 알려짐
  - 시작 위치 변경시 재컴파일
  - 컴파일러는 절대 코드(absolute code)생성

- Load time binding

  > 프로세스가 실행될 때 논리주소가 물리적 주소에 남는 공간으로 바인딩

  - Loader의 책임하에 물리적 메모리 주소 부여
  - 컴파일러가 재배치가능코드(relocatable code)를 생성한 경우 가능

- Execution time binding (=Run time binding)

  > 실행 중에도 물리적 주소가 변경될 수 있음
  >
  > 현재 사용하는 일반적인 시스템에서 채용

  - 수행이 시작된 이후에도 프로세스의 메모리 상 위치를 옮길 수 있음
  - CPU가 주소를 참조할 때마다 binding을 점검 (address mapping table)
  - 하드웨어적인 지원이 필요(e.g., base and limit registers, MMU)

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 3.01.16 PM.png" alt="Screenshot 2022-11-17 at 3.01.16 PM" style="zoom:50%;" />

### 3. Memory-Management Unit(MMU)

- MMU(Memory-Management Unit)
  - logical address 를 physical address로 매핑해 주는 Hardware device
- MMU scheme
  - 사용자 프로세스가 CPU에서 수행되며 생성해내는 모든 주소값에 대해 base register(=relocation register)의 값을 더한다
- user program
  - logical address만을 다룬다
  - 실제 physical address를 볼 수 없으며 알 필요가 없다

### 4. Dynamic Relocation

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 3.20.15 PM.png" alt="Screenshot 2022-11-17 at 3.20.15 PM" style="zoom:50%;" />

> - MMU내부 동작
>   - 논리주소에서 물리적 주소 얻기 : 물리적 메모리 주소의 시작지점을 base register(=relocation register)에 저장해 놓은 상태에서 요청이 들어온 논리주소와 해당 register에 저장된 주소를 더함
>   - 해당 프로세스의 범위를 넘어서는 요청이 들어왔을 때 : limit register에 프로그램의 최대크기를 저장해 놓은 상태에서 해당 요청이 들어온 논리주소와 register 내부 값 비교

### 5. Hardware Support for Address Translation

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 3.21.24 PM.png" alt="Screenshot 2022-11-17 at 3.21.24 PM" style="zoom:50%;" />

- 운영체제 및 사용자 프로세스 간의 메모리 보호를 위해 사용하는 레지스터
  - Relocation register(=base register) : 접근할 수 있는 물리적 메모리 주소의 최소값
  - Limit register : 논리적 주소의 범위

### 6. Some Terminologies

#### Dynamic Loading

> OS에서 자체적으로 제공하는 것이 아닌 프로그래머 레벨에서 필요에 따라 구현

- 프로세스 전체를 메모리에 미리 다 올리는 것이 아니라 해당 루틴이 불려질 때 메모리에 load하는 것
- memory utilization의 향상
- 가끔씩 사용되는 많은 양의 코드의 경우 유용
  - 예 : 오류 처리 루틴
- 운영체제의 특별한 지원 없이 프로그램 자체에서 구현 가능(OS는 라이브러리를 통해 지원 가능)
- Loading : 메모리로 올리는 것

#### Overlays

> dynamic loading과 역사적인 측면에서 다름
>
> 운영체제에 의한 라이브러리 지원도 없음

- 메모리에 프로세스의 부분 중 실제 필요한 정보만을 올림
- 프로세스의 크기가 메모리보다 클 때 유용
- 운영체제의 지원없이 사용자에 의해 구현
- 작은 공간의 메모리를 사용하던 초창기 시스템에서 수작업으로 프로그래머가 구현
  - "Manual Overlay"
  - 프로그래밍이 매우 복잡

#### Swapping

- Swapping

  - 프로세스를 일시적으로 메모리에서 backing store로 쫓아내는 것

- Backing store(= swap area)

  - 디스크
    - 많은 사용자의 프로세스 이미지를 담을 만큼 충분히 빠르고 큰 저장 공간

- Swap in / Swap out

  - 일반적으로 중기 스케줄러(swapper)에 의해 swap out 시킬 프로세스 선정

  - priority-based CPU scheduling algorithm

    - priority가 낮은 프로세스를 swapped out 시킴
    - priority가 높은 프로세스를 메모리에 올려 놓음

  - Compile time 혹은 load time binding에서는 원래 메모리 위치로 swap in 해야 함

    > 반드시 기존에 사용중이던 위치로 올라가야 하면 비효율적인 측면이 있음

  - Execution time binding에서는 추후 빈 메모리 영역 아무 곳에나 올릴 수 있음

    > run time binding을 지원하면 바로 위의 문제를 해소할 수 있음

  - swap time은 대부분 transfer time (swap되는 양에 비례하는 시간)임

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 4.34.01 PM.png" alt="Screenshot 2022-11-17 at 4.34.01 PM" style="zoom:50%;" />

#### Dynamic Linking

- Linking을 실행 시간(execution time)까지 미루는 기법

- Static linking

  - 라이브러리가 프로그램의 실행 파일 코드에 포함됨

    > 실행파일이 만들어지는 컴파일 과정에서 라이브러리 코드가 포함됨

  - 실행 파일의 크기가 커짐

  - 동일한 라이브러리를 각각의 프로세스가 메모리에 올리므로 메모리 낭비(eg. printf 함수의 라이브러리 코드)

- Dynamic linking

  - 라이브러리가 실행시 연결(link)됨
  - 라이브러리 호출 부분에 라이브러리 루틴의 위치를 찾기 위한 stub이라는 작은 코드를 둠
  - 라이브러리가 이미 메모리에 있으면 그 루틴의 주소로 가고 없으면 디스크에서 읽어옴
  - 운영체제의 도움이 필요

### 7. Allocation of Physical Memory

- 메모리는 일반적으로 두 영역으로 나뉘어 사용

  - OS상주 영역
    - interrupt vector와 함께 낮은 주소 영역 사용
  - 사용자 프로세스 영역
    - 높은 주소 영역 사용

- 사용자 프로세스 영역의 할당 방법

  - Contiguous allocation : 각각의 프로세스가 메모리의 연속적인 공간에 적재되도록 하는 것

    > 프로세스 전체가 한번에 연속적인 공간에 올라감

    - Fixed partition allocation
    - Variable partition allocation

  - Noncontiguous allocation : 하나의 프로세스가 메모리의 여러 영역에 분산되어 올라갈 수 있음

    > 현대의 운영체제가 대부분 채택하는 방식

    - Paging
    
      > 프로세스를 주소영역을 동일한 크기의 page로 분할하는 방식
      >
      > 특정 프로세스가 종료되더라도 모두 동일한 크기의 page로 구성되어 있으므로 불필요한 hole이 생기지 않음
    
    - Segmentation
    
      > 의미있는 단위로 분할하는 방식
      >
      > > ex) code, date, stack을 각기 다른 공간에 위치
    
    - Paged Segmentation

### 8. Contiguous Allocation

- Contiguous allocation

  - 고정분할(Fixed partition)방식

    > 사전에 메모리의 공간을 분리해놓음

    - 물리적 메모리를 몇 개의 영구적 분할(partition)로 나눔
    - 분할의 크기가 모두 동일한 방식과 서로 다른 방식이 존재
    - 분할당 하나의 프로그램 적재
    - 융통성이 없음
      - 동시에 메모리에 load되는 프로그램의 수가 고정됨
      - 최대 수행 가능 프로그램 크기 제한
    - Internal fragmentation 발생 (external fragmentation도 발생)

  - 가변분할(Variable partition) 방식

    > 순서대로 차곡차곡 프로세스를 올리는 방식
    >
    > 프로그램이 종료되고 실행되면서 hole이 생기기도 함

    - 프로그램의 크기를 고려해서 할당
    - 분할의 크기, 개수가 동적으로 변함
    - 기술적 관리 기법 필요
    - External fragmentation 발생

  - External fragmentation(외부 조각)

    - 프로그램 크기보다 분할의 크기가 작은 경우
    - 아무 프로그램에도 배정되지 않은 빈 곳인데도 프로그램이 올라갈 수 없는 작은 분할

  - Internal fragmentation(내부 조각)

    - 프로그램 크기보다 분할의 크기가 큰 경우
    - 하나의 분할 내부에서 발생하는 사용되지 않는 메모리 조각
    - 특정 프로그램에 배정되었지만 사용되지 않는 공간

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 4.52.28 PM.png" alt="Screenshot 2022-11-17 at 4.52.28 PM" style="zoom:50%;" />

- Hole

  - 가용 메모리 공간
  - 다양한 크기의 hole들이 메모리 여러 곳에 흩어져 있음
  - 프로세스가 도착하면 수용가능한 hole을 할당
  - 운영체제는 다음의 정보를 유지
    - 할당 공간
    - 가용 공간(Hole)

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 5.00.48 PM.png" alt="Screenshot 2022-11-17 at 5.00.48 PM" style="zoom:50%;" />

#### Dynamic Storage-Allocation Problem

> 가변 분할 방식에서 size n인 요청을 만족하는 가장 적절한 hole을 찾는 문제

- First-fit

  - Size가 n 이상인 것 중 최초로 찾아지는 hole에 할당

- Best-fit

  - Size가 n 이상인 가장 작은 hole을 찾아서 할당
  - Hole들이 리스트가 크기순으로 정렬되지 않은 경우 모든 hole의 리스트를 탐색해야함
  - 많은 수의 아주 작은 hole들이 생성됨

- Worst-fit

  - 가장 큰 hole에 할당
  - 역시 모든 리시트를 탐색해야 함
  - 상대적으로 아주 큰 hole들이 생성됨

- First-fit과 best-fit이 worst-fit보다 속도와 공간 이용률 측면에서 효과적인 것으로 알려짐(실험적인 결과)

- Compaction

  > hole들을 한 공간으로 모으는 방식

  - external fragmentation 문제를 해결하는 한 가지 방법
  - 사용 중인 메모리 영역을 한군데로 몰고 hole들을 다른 한 곳으로 몰아 큰 block을 만드는 것
  - 매우 비용이 많이 드는 방법임
  - 최소한의 메모리 이동으로 compaction하는 방법(매우 복잡한 문제)
  - Compaction은 프로세스의 주소가 실행 시간에 동적으로 재배치 가능한 경우에만 수행될 수 있다

### 9. Paging

- Paging

  - Process의 virtual memory를 동일한 사이즈의 page단위로 나눔
  - Virtual memory의 내용이 page단위로 noncontigurous하게 저장됨
  - 일부는 backing storage에, 일부는 physical memory에 저장

- Basic Method

  - physical memory를 동일한 크기의 frame으로 나눔

  - logical memory를 동일 크기의 page로 나눔(frame과 같은 크기)

  - 모든 가용 frame들을 관리

  - page table을 사용하여 logical address를 physical address로 변환

  - External fragmentation발생 안함

  - Internal fragmentation발생 가능

    > 프로세스가 반드시 page의 배수단위로 구성되지는 않기때문

- Paging Example

  > 주소 변환 과정에서 기존 Contiguous allocation방식이 2개의 register를 사용했던 것과 다르게 page table을 이용
  >
  > > page table의 경우 자체적으로 상당한 크기를 가지므로 별도의 레지스터를 활용할 수 없음 / 메모리에 별도 공간을 할당하여 저장

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 5.32.20 PM.png" alt="Screenshot 2022-11-17 at 5.32.20 PM" style="zoom:50%;" />

- Address Translation Architecture

  > 위의 그림을 다른 방식으로 표현한 것

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 5.40.33 PM.png" alt="Screenshot 2022-11-17 at 5.40.33 PM" style="zoom:50%;" />

### 10. Implementation of Page Table

- Page table은 main memory에 상주

- Page-table base register(PTBR)가 page table을 가리킴

- Page-table length register(PTLR)가 테이블 크기를 보관

- 모든 메모리 접근 연산에서 2번의 memory access 필요

- page table 접근 1번, 실제 data/instruction 접근 1번

- 속도 향상을 위해 associative register 혹은 translation look-aside buffer(TLB)라 불리는 고속의 lookup hardware cache 사용

#### Paging Hardware with TLB

> page table의 전부를 가지고 있지 않고 자주 참조되는 일부만 가지고 있음

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 5.52.58 PM.png" alt="Screenshot 2022-11-17 at 5.52.58 PM" style="zoom:50%;" />

### 11. Associative Register

- Associative registers (TLB) : parallel search 가 가능

  - TLB에는 page table 중 일부만 존재

- Address translation

  - page table 중 일부가 associative register에 보관되어 있음

  - 만약 해당 page #가 associative register에 있는 경우 곧바로 frame #를 얻음

  - 그렇지 않은 경우 main memory에 있는 page table로부터 frame #를 얻음

  - TLB는 context switch 때 flush(remove old entries)

    > 프로세스마다 각기 다른 page table, TLB를 가지기 때문

### 12. Effective Access Time

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 7.09.36 PM.png" alt="Screenshot 2022-11-17 at 7.09.36 PM" style="zoom:50%;" />

### 13. Two-Level Page Table

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 7.15.54 PM.png" alt="Screenshot 2022-11-17 at 7.15.54 PM" style="zoom:50%;" />

- 현대의 컴퓨터는 address space가 매우 큰 프로그램 지원

  - 32 bit address 사용시 : 2^32B(4G)의 주소 공간

    - page size가 4k시 1M개의 page table entry 필요
    - 각 page entry가 4B시 프로세스당 4M의 page table 필요
    - 그러나, **대부분의 프로그램은 4G의 주소 공간 중 지극히 일부분만 사용**하므로 page table 공간이 심하게 낭비됨

      > 메모리 주소 영역상에 실제로 프로그램이 차지하는 부분은 일부분임을 의미
      >
      > 따라서, 이 모든 주소에 접근할 필요는 없음
    
    ==> page table 자체를 page로 구성
    
    ==> **사용되지 않는 주소 공간**에 대한 **outer page table의 엔트리 값**은 **NULL**(대응하는 inner page table이 없음)
    
    > page table을  한개만 쓰게 되면 이런식으로 안쓰는 영역을 NULL로 대응할 수 없음 : 쓰지 않더라도 테이블을 구성해야함

#### Two-Level Paging Example

- logical address (on 32-bit machine with 4K page size)의 구성

  - 20 bit의 page number

    > inner page table은 page화 되어 들어가서 실제 메모리상 page와 동일한 크기(4K)를 가짐
    >
    > 4K의 구성 : entry 크기(4B) * entry 개수(1K)
    >
    > 위처럼 entry 개수가 1K이므로 이를 구분하기 위해 2^10 : 10bit 필요

  - 12 bit의 page offset

    > page size : 4K이므로 이를 구분하기 위해서는 2^12개이므로 12bit필요

- page table 자체가 page로 구성되기 때문에 page number는 다음과 같이 나뉜다(각 page table entry가 4B)

  - 10-bit 의 page number
  - 10-bit 의 page offset

- 따라서, logical address 는 다음과 같다

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 8.22.52 PM.png" alt="Screenshot 2022-11-17 at 8.22.52 PM" style="zoom:50%;" />

- P1은 outer page table의 index이고

- P2는 outer page table의 page에서의 변위(displacement)

- 2단계 페이징에서의 Address-translation scheme
  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-17 at 8.29.01 PM.png" alt="Screenshot 2022-11-17 at 8.29.01 PM" style="zoom:50%;" />

### 14. Multilevel Paging and Performance

- address sapce가 더 커지면 다단계 페이지 테이블 필요

- 각 단계의 페이지 테이블에 메모리에 존재하므로 logical address의 physical address변환에 더 많은 메모리 접근 필요

- TLB를 통해 메모리 접근 시간을 줄일 수 있음

- 4단계 페이지 테이블을 사용하는 경우

  - 메모리 접근 시간이 100ns, TLB접근 시간인 20ns이고

  - TLB hit ratio가 98%인 경우

    effective memory address time = 0.98 x 120 + 0.02 x 520 = 128 nanoseconds

    결과적으로 주소변환을 위해 28ns만 소요

### 15. Valid(v) / Invalid(i) Bit in a page table

> page table내 frame number만 저장되어 있는 것이 아닌 부가적인 비트정보도 들어있음
>
> > v/i bit은 page화된 주소영역 중 연속적인 index번호를 부여하기 위해 테이블에 만들어졌지만 사용하지 않는 영역을 구분하기 위해 사용

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 9.36.25 AM.png" alt="Screenshot 2022-11-18 at 9.36.25 AM" style="zoom:50%;" />

### 16. Memory Protection

- Page table의 각 entry 마다 아래의 bit를 둔다

  - Protection bit

    > 연산에 대한 권한

    - page에 대한 접근 권한(read/write/read-only)

  - Valid-invalid bit

    - "valid"는 해당 주소의 frame에 그 프로세스를 구성하는 유효한 내용이 있음을 뜻함(접근 허용)

    - "invalid"는 해당 주소의 frame에 유효한 내용이 없음을 뜻함(접근 불가)

      > 1. 프로세스가 그 주소 부분을 사용하지 않는 경우
      > 2. 해당 페이지가 메모리에 올라와 있지 않고 swap area에 있는 경우

### 17. Inverted Page Table

- page table이 매우 큰 이유
  - 모든 process 별로 그 logical address에 대응하는 모든 page에 대해 page table entry가 존재
  - 대응하는 page가 메모리에 있는 아니든 간에 page table에는 entry로 존재
- Inverted page table
  - Page frame 하나당 page table에 하나의 entry를 둔 것(system-wide)
  - 각 page table entry는 각각의 물리적 메모리의 Page frame이 담고 있는 내용 표시(process-id, process의 logical address)
  - 단점
    - 테이블 전체를 탐색해야 함
  - 조치
    - associative register 사용(expensive)

#### Inverted page table architecture

> 시스템 내부에 단 한개의 page table이 존재
>
> 프로세서의 id, 논리적 주소를 저장
>
> > 해당 방식은 page table의 크기를 줄일 수 있지만, 시간이 오래걸림

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 9.51.45 AM.png" alt="Screenshot 2022-11-18 at 9.51.45 AM" style="zoom:50%;" />

### 18. Shared page

- Shared code
  - Re-entrance Code (=Pure code)
  - read-only 로 하여 프로세스 간에 하나의 code만 메모리에 올림(eg, text editors, compilers, window systems)
  - Shared code 는 모든 프로세스의 logical address space에서 동일한 위치에 있어야 함
- Private code and data
  - 각 프로세스들은 독자적으로 메모리에 올림
  - Private data는 logical address space의 아무 곳에 와도 무방

#### Shared pages example

> 공유할 수 있는 코드를 동일한 물리적 위치에 올림

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 11.04.47 AM.png" alt="Screenshot 2022-11-18 at 11.04.47 AM" style="zoom:50%;" />

### 19. Segmentation

- 프로그램은 의미 단위인 여러 개의 segment로 구성
  - 작게는 프로그램을 구성하는 함수 하나하나를 세크먼트로 정의
  - 크게는 프로그램 전체를 하나의 세그먼트롤 정의 가능
  - 일반적으로 code, data, stack 부분이 하나씩의 세그먼트로 정의됨
- Segment는 다음과 같은 logical unit들임
  - main()
  - function
  - global variables
  - stack
  - symbol table
  - arrarys

#### Segmentation Architecture

- Logical address는 다음의 두 가지로 구성

  - < segment-number, offset >

- Segment table

  - each table entry has:
    - base - starting physical address of the segment
    - limit - length of the segment

- Segment-table base register(STBR)

  - 물리적 메모리에서의 segment table의 위치

- Segment-table length register(STLR)

  - 프로그램이 사용하는 segment의 수

    > 프로그램이 사용하는 segment보다 초과되는 segment번호로 요청이 들어오면 비교를 통해서 trap을 발생시킴

    - segment number s is legal if s < STLR

- Protection

  - 각 세그먼트 별로 protection bit이 있음
  - Each entry:
    - Valid bit = 0 ==> illegal segment
    - Read/Write/Execution 권한 bit

- Sharing

  - shared segment

  - same segment number

  - segment는 의미 단위이기 때문에 공유(sharing)와 보안(protection)에 있어 paging보다 훨씬 효과적이다

    > page기법은 필요한 모든 page에 동일하게 권한등을 적용해야 하므로 비효율적

- Allocation

  - first fit / best fit

  - external fragmentation 발생

  - segment의 길이가 동일하지 않으므로 가변분할 방식에서와 동일한 문제점들이 발생

    > hole이 생김

#### Segmentation Hardware

> segment table 에 시작위치 외에 limit이 추가로 들어가게 됨 : segment별로 크기가 다르기 때문에 이를 구분하기 위해서
>
> > page과 다르게 frame단위로 균일하게 구분되지 않기 때문에 byte단위로 정확하게 기입되어야 함

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 11.39.41 AM.png" alt="Screenshot 2022-11-18 at 11.39.41 AM" style="zoom:50%;" />

#### Example of Segmentation

> page기법 대기 table크기에 대한 부담이 적음

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 11.55.32 AM.png" alt="Screenshot 2022-11-18 at 11.55.32 AM" style="zoom:50%;" />

#### Sharing of Segments

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 11.59.58 AM.png" alt="Screenshot 2022-11-18 at 11.59.58 AM" style="zoom:50%;" />

#### Segmentation with paging

- pure segmentation과의 차이점

  - segment-table entry가 segment의 base address를 가지고 있는 것이 아니라 segment를 구성하는 page table의 base address를 가지고 있음

    > page단위로 올라가므로 allocation문제가 발생하지 않음

    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-18 at 12.02.43 PM.png" alt="Screenshot 2022-11-18 at 12.02.43 PM" style="zoom:50%;" />

