# Chapter01 : 컴퓨터 시스템의 소개

## 01. 컴퓨터 하드웨어의 구성

> 컴퓨터 시스템 = hardware + software
>
> 운영체제(OS) = hardware를 관리하는 sofeware

### 1. 프로세서

> 중앙처리장치(CPU : Central Processing unit)라고도 함

- 연산장치, 제어장치, 레지스터로 구성되며 이들 사이는 내부 버스로 연결된다<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 12.22.12 PM.png" alt="Screenshot 2022-11-04 at 12.22.12 PM" style="zoom:50%;" />

- 레지스터의 분류

  - 용도에 따른 분류

    - 전용 레지스터
    - 범용 레지스터

  - 사용자 정보 변경 가능여부에 따른 분류

    - 사용자 가시 레지스터(user-visible register) 
    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 12.23.25 PM.png" alt="Screenshot 2022-11-04 at 12.23.25 PM" style="zoom:50%;" />
    - 사용자 비가시 레지스터(user-invisible register)
    <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 12.24.40 PM.png" alt="Screenshot 2022-11-04 at 12.24.40 PM" style="zoom:50%;" />
    
  -  저장하는 정보의 종류에 따른 분류
  
    - 데이터 레지스터
    
    - 주소 레지스터
    
    - 상태 레지스터
    
### 2. 메모리

> 메모리의 속도와 가격은 비례하므로 메모리 계층 구조를 구성하여 비용, 속도, 용량. 접근시간 등을 상호 보완한다

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 12.48.37 PM.png" alt="Screenshot 2022-11-04 at 12.48.37 PM" style="zoom:50%;" />

1. 레시스터

   - 프로세서 내부에 위치하며, <u>프로세서가 사용할 데이터</u>를 보관하는 **가장 빠른 메모리**

2. 메인 메모리

   > 주기억장치 or 1차 기억장치라고도 하며, 저장밀도가 높고 가격이 싼 DRAM을 주로 사용

   - 프로세서 외부에 위치하며, 프로세서가 즉각 수행할 프로그램과 데이터를 저장하거나 프로세서가 처리한 결과를 저장

   - 입출력장치와도 데이터를 주고받음

   - 메인 메모리는 다수의 셀(cell)로 구성되며, 각 셀은 비트로 구성된다

   - 매핑(mapping) or 메모리 맵(memory map)

     > 메모리의 물리적 주소와 프로그램의 논리적 주소를 컴파일하는 과정에서 변환하는 작업

   - 메모리 속도는 메모리 접근시간과 메모리 사이클 시간으로 표현가능

     - 메모리 접근시간 : 명령 발생 이후 목표 주소를 검색하여 데이터 쓰기(읽기)를 시작할 때까지 걸린 시간
     
     - 메모리 사이클 시간 : 두 번의 연속적인 메모리 동작  사이에 필요한 최소 지연시간
       <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 1.22.10 PM.png" alt="Screenshot 2022-11-04 at 1.22.10 PM" style="zoom:50%;" />
     
     - 프로세서와 보조기억장치 사이에서 디스크 입출력 병목 현상 해결의 역할도 수행
     
       > 프로세서와 메인 메모라 간에도 속도 차이가 나면서 메인메모리의 부담을 줄이기위해 프로세서 내외부에 캐시를 구현하기도 함

3. 캐시

   >  프로세서 내외부에 위치하여 처리 속도가 빠른 프로세서와 상대적으로 느린 메인 메모리의 속도 차이를 보완하는 고속 버퍼

   - 캐시의 역할
     <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 1.34.41 PM.png" alt="Screenshot 2022-11-04 at 1.34.41 PM" style="zoom:50%;" />

     - 메인 메모리의 데이터를 블록 단위로 가져와 프로세서에 워드 단위로 전달하여 속도를 높임
     
     
       - 데이터가 이동하는 통로(대역폭)를 확대하여 프로세서와 메모리 사이 속도 차이를 줄임
         
   
   
   - 캐시의 기본 동작
     <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-11-04 at 1.39.54 PM.png" alt="Screenshot 2022-11-04 at 1.39.54 PM" style="zoom:50%;" />
     
     - 