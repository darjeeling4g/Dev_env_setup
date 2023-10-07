# Network Chapter 4 : 실제로 컴퓨터끼리는 IP주소를 사용해 데이터를 주고 받는다

## 1. 3계층의 기능

### 3계층에서 하는 일

3계층은 다른 네트워크 대역 즉, 멀리 떨어진 곳에 존재하는 네트워크까지 어떻게 데이터를 전달할지 제어하는 일을 담당

> WAN : LAN과 LAN을 연결, 라우터와 같은 3계층 장비가 필요

발신에서 착신까지의 패킷의 경로를 제어

### 3계층에서 쓰는 주소

WAN에서 통신할 때 사용하는 IP주소

> Window 기준 `ipconfig`로 확인가능
>
> IPv4 주소 : 현재 PC에 할당된 IP주소
>
> 서브넷 마스크 : IP주소에 대한 네트워크의 대역을 규정하는 것
>
> 게이트웨이 주소 : 외부와 통신할 때 사용하는 네트워크의 출입구

### 3계층 프로토콜

- IP주소를 이용해 MAC주소를 알아오는 **ARP프로토콜**

- WAN에서 통신할 때 사용하는 **IPv4프로토콜**

  > IPv6로 넘어가는 추세임

- 서로가 통신되는지 확인할 때 사용하는 **ICMP프로토콜**

## 2. 일반적인 IP주소

### Internet Protocol Address Version 4

전체 32bit(4byte)이며, 각각을 10진수로 표시함

192.168.0.100과 같이 '.'으로 필드를 구분하며 각 필드는 0 ~ 255까지 올 수 있음

- 네트워크 ID : 해당 네트워크 대역에서 가장 작은 IP주소
- 브로드캐스트 주소 : 해당 네트워크 대역에서 가장 큰 IP주소
- 호스트 할당 가능한 주소 : 해당 네트워크 대역에서 가장 작은 IP주소 + 1 ~ 해당 네트워크 대역에서 가장 큰 IP주소 - 1
- 게이트웨이 주소 : 해당 네트워크 대역에서 가장 작은 IP주소 + 1 or 해당 네트워크 대역에서 가장 큰 IP주소 -1
- IP주소의 역사 : Classful &rarr; Classless &rarr; 사설IP와 공인IP &rarr; IPv6

### Classful

낭비가 심한 Classful IP 주소

초창기의 형식은 아래와 같음

- A클래스
  10진수로 표시 : 0.0.0.0 ~ 127.255.255.255
  2진수로 표시 : 0 0000000.00000000.00000000.00000000 ~ 0 1111111.11111111.11111111.11111111
  첫번째 필드는 네트워크를 구분하는 주소, 나머지는 호스트를 구분
- B 클래스 10진수로 표시 : 128.0.0.0 ~ 191.255.255.255
  2진수로 표시 : 10 000000.00000000.00000000.00000000 ~ 10 111111.11111111.11111111.11111111
  두번째 필드는 네트워크를 구분하는 주소, 나머지는 호스트를 구분
- C 클래스 10진수로 표시 : 192.0.0.0 ~ 223.255.255.255
  2진수로 표시 : 110 00000.00000000.00000000.00000000 ~ 110 11111.11111111.11111111.11111111
  세번째 필드는 네트워크를 구분하는 주소, 나머지는 호스트를 구분
- D 클래스 10진수로 표시 : 224.0.0.0 ~ 239.255.255.255
  2진수로 표시 : 1110 0000.00000000.00000000.00000000 ~ 1110 1111.11111111.11111111.11111111
  멀티캐스트용으로 사용하는 주소
- E 클래스 10진수로 표시 : 240.0.0.0 ~ 255.255.255.255
  2진수로 표시 : 11110 000.00000000.00000000.00000000 ~ 11111 111.11111111.11111111.11111111
  연구목적으로 사용하지 않는 IP주소

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-22 at 1.36.13 PM.png" alt="Screenshot 2022-12-22 at 1.36.13 PM" style="zoom:50%;" />

> 현재는 위의 형식을 알 필요는 없음 
>
> > 초창기에는 문제가 없었으나 IP가 낭비되는 문제점이 발생함

특수한 IP 주소

- 네트워크 IDIP주소 및 서브넷 마스크를 2진수로 표현 두 주소를 AND 연산
- 브로드캐스드 주소호스트를 구분하는 주소 부분을 모두 1로 채움
- 사용 가능 IP 범위네트워크 ID + 1 ~ 브로드캐스트 주소 -1 까지

### Classless

낭비되지 않도록 아껴쓰는 Classless IP주소

- 서브넷 마스크

  클래스풀한 네트워크 대역을 나눠주는데 사용하는 값

  어디까지난 네트워크 대역을 구분하는데 사용하고 어디서부터 호스트를 구분하는데 사용하는지 지정

  32bit(4바이트)

  255.255.255.192 &rarr; 11111111.11111111.11111111.11000000

  > 2진수로 표기했을 때 1로 시작, 1과 1사이에는 0이 올 수 없다는 규칙을 가지고 있다
  
  - ex) 192.168.100.68 / 255.255.255.192와 같이 IP주소와 서브넷마스크를 쓰면? &rarr; 192.168.100.0와 같이 C클래스에 해당하는 네트워크를 192.168.100.0, 192.168.100.64, 192.168.100.128, 192.168.100.192와 같이 4개의 작은 네트워크 대역으로 나눈 것이고 해당 IP 주소는 2번째 네트워크에 해당하는 것이다

### 사설IP와 공인IP

공인 IP 1개당 2^32개의 사설 IP

- 공인 IP 하나에 새로운 네트워크 대역인 사설 네트워크 대역을 생성(0.0.0.0 ~ 255.255.255.255)

- 사설 IP는 외부 네트워크 대역에서는 보이지 않는다

  > 외부에서 봤을 때는 내부 장비는 전부 공유기의 IP로 보이게 됨

- 사설 IP는 내부에서 외부로 나갔다가 들어오는 것만 가능

  > 공유기는 외부로 요청이 나갈때 해당 요청에 대한 정보를 NAT에 기록, 이후 응답이 오면 NAT를 참조해 요청했던 내부 장비로 전달해줌

- 외부에서 내부로 직접 통신은 따로 설정을 통해서만 가능(포트포워딩)

  > 포트는 4계층에서 쓰는 용어임

- 장점 : 내부 네트워크의 보안 기능

- 내부 네트워크에 있는 호스트들은 사설 IP를 할당 받고 외부 네트워크와 통신할 때는 공인 IP로 변경되서 통신한다

- 통신할 때 NAT table에 해당하는 사설 IP로 데이터를 전달

  > NAT(Network Address Translation) 특정 IP를 특정 IP로 바꿔주는 것

- 현재 거의 대부분의 일반용, 가정용 PC에서는 사설 IP를 사용

## 3. 특수한 IP주소

### 0.0.0.0

wildcard

> **나머지** 모든 IP를 의미

### 127.X.X.X

나 자신을 나타내는 주소

### 게이트웨이 주소

어딘가로 가려면 일단 여기로

> 일반적으로 공유기의 IP를 사용

## 4. 따라學it

### 내 PC의 IP주소 알아보기

윈도우에서 간단하게 내 PC의 IP주소를 확인하는 방법 알아보기

### 네이버가 보는 내 IP주소 알아보기

네이버 서버와 통신할 때 네이버 서버가 알고 있는 나의 IP주소를 알아보고 1. 에서 확인한 IP와 비교해보기