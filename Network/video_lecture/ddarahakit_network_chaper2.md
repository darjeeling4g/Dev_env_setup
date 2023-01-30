# Network Chapter 2 : 네트워크의 기준! 네트워크 모델

[TOC]

## 1. 네크워크 모델의 종류

### TCP/IP 모델

1960년대 말 미국방성의 연구에서 시작되어 1980년대 초 프로토콜 모델로 공개

현재의 인터넷에서 컴퓨터들이 서로 정보를 주고받는데 쓰이는 통신 규약(프로토콜)의 모음이다

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.11.18 PM.png" alt="Screenshot 2022-12-09 at 1.11.18 PM" style="zoom:50%;" />

### OSI 7계층 모델

1984년 네트워크 통신을 체계적으로 다루는 ISO에서 표준으로 지정한 모델

데이터를 주고받을 때 데이터 자체의 흐름을 각 구간별로 나눠 놓은 것

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.12.51 PM.png" alt="Screenshot 2022-12-09 at 1.12.51 PM" style="zoom:50%;" />

- 각 계층별 프로토콜

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.14.12 PM.png" alt="Screenshot 2022-12-09 at 1.14.12 PM" style="zoom:50%;" />

## 2. 두 모델 비교

### 공통점과 차이점

- 공통점
  - 계층적 네크워크 모델
  - 계층간 역할 정의
- 차이점
  - 계층의 수 차이
  - OSI는 역할 기반, TCP/IP는 프로토콜 기반
  - OSI는 통신 전반에 대한 표준
  - TCP/IP는 데이터 전송기술 특화

## 3. 네트워크를 통해 전달되는 데이터, 패킷

### 패킷이란?

> 여러 번 포장된 상자 / 여러 프로토콜로 캡슐화 되어 있음

패킷이란 네트워크 상에서 전달되는 데이터를 통칭하는 말로 네트워크에서 전달하는 데이터의 형식화된 블록이다

패킷을 제어 정보와 사용자 데이터로 이루어지며 사용자 데이터는 페이로드라고도 한다

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.24.29 PM.png" alt="Screenshot 2022-12-09 at 1.24.29 PM" style="zoom:50%;" />

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.25.36 PM.png" alt="Screenshot 2022-12-09 at 1.25.36 PM" style="zoom:50%;" />

> 위의 그림을 예시로 하면, HTTP를 페이로드로 하여 TCP 프로토콜을 헤더로 붙임
>
> > 위에 묶인 패킷을 페이로드로 해서 IPv4프로토콜을 헤더로 붙임
> >
> > > 다시 위의 묶인 패킷을 페이로드로 해서 Ethernet 프로토콜을 헤더로 붙임

### 패킷을 이용한 통신과정

- 캡슐화 : 여러 프로토콜을 이용해서 최종적으로 보낼 때 패킷을 만드는 과정

  > 반드시 상위 계층부터 하위 계층으로 내려가면서 프로토콜을 붙임

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.28.41 PM.png" alt="Screenshot 2022-12-09 at 1.28.41 PM" style="zoom:50%;" />

- 디캡슐화 : 패킷을 받았을 때 프로토콜들을 하나씩 확인하면서 데이터를 확인하는 과정

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.33.42 PM.png" alt="Screenshot 2022-12-09 at 1.33.42 PM" style="zoom:50%;" />

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.34.19 PM.png" alt="Screenshot 2022-12-09 at 1.34.19 PM" style="zoom:50%;" />

### 계층별 패킷의 이름 PDU

> 계층별로 이름이 다른 Protocol Data Unit

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.35.21 PM.png" alt="Screenshot 2022-12-09 at 1.35.21 PM" style="zoom:50%;" />

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.35.42 PM.png" alt="Screenshot 2022-12-09 at 1.35.42 PM" style="zoom:50%;" />

> 앞에 나온 패깃과 명칭은 동일하나 다른 의미임

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 1.35.58 PM.png" alt="Screenshot 2022-12-09 at 1.35.58 PM" style="zoom:50%;" />

## 4. 따라學it

- 프로토콜의 캡슐화 된 모습과 계층별 프로토콜들을 확인해보기
