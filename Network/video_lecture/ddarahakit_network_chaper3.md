# Network Chapter 3 : 가까이 있는 컴퓨터끼리는 이렇게 데이터를 주고 받는다

[TOC]

## 1. 2계층에서 하는 일

### 2계층의 기능

2계층은 하나의 네트워크 대역 즉, 같은 네트워크 상에 존재하는 여러 장비들 중에서 어떤 장비가 어떤 장비에게 보내는 데이터를 전달

추가적으로 **오류제어, 흐름제어** 수행

### 2계층의 네트워크 크기

2계층은 **하나의 네트워크 대역 LAN**에서만 통신할 때 사용한다.

다른 네트워크와 통신할 때는 항상 3계층이 도와주어야 한다

3계층의 주소와 3계층의 프로토콜을 이용하여야만 다른 네트워크와 통신이 가능하다

## 2. 2계층에서 사용하는 주소

### 물리적인 주소(MAC 주소)

LAN에서 통신할 때 사용하는 MAC주소

> 16진수로 표기됨(12개의 16진수로 표시됨 = 6byte)

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-17 at 7.24.23 PM.png" alt="Screenshot 2022-12-17 at 7.24.23 PM" style="zoom:50%;" />

> 하드웨어에 직접 부여되는 주소이므로 일반적으로 임의 수정이 불가하며 고유한 값을 가짐

## 3. 2계층 프로토콜

### Ethernet 프로토콜

LAN에서 통신할 때 사용하는 Ethernet프로토콜

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-17 at 7.30.28 PM.png" alt="Screenshot 2022-12-17 at 7.30.28 PM" style="zoom:50%;" />

- Destination address(6byte)

  > 목적지의 MAC주소 (6byte가 할당되는 것는 MAC주소가 6byte이기 때문)

- Source Address(6byte)

  > 출발지의  MAC주소

- Ethernet type(2byte)

  > 페이로드 안의 상위 프로토콜 정보를 담고있음
  >
  > ex) IPv4(0x0800), ARP(0x0806)

- DATA : 해당 프로토콜의 페이로드에 해당하는 부분

## 4. 따라學it

### 내 MAC주소 알아보기

윈도우에게 간단하게 내 PC의 MAC주소를 확인하는 방법 알아보기

windows : ipconfig /all &rarr; 물리적주소

linux/unix : ifconfig &rarr; ether

### Ethernet 프로토콜 캡쳐

Ethernet프로토콜이 어떻게 생겼는지 직접 보기 위해 Wireshark를 이용해 캡쳐해보기

### Ethernet 프로토콜 분석

캡쳐한 Ethernet프로토콜이 내 MAC주소가 있는지 목적지는 어디인지 분석해보기