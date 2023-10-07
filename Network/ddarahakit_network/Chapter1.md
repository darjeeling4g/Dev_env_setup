# Network Chapter 1 : 네트워크란 무엇인가?

## 1. 네크워크란 무엇인가?

### 네트워크란?

노드[^node] 들이 데이터를 공유할 수 있게 하는 디지털 전기통신망의 하나이다

즉, 분산되어 있는 컴퓨터를 통신망으로 연결한 것을 말한다

네트워크에서 여러 장치들은 노드 간 연결을 사용하여 서로에게 데이터를 교환한다

### 인터넷이란?

문서, 그림 영상과 같은 여러가지 데이터를 공유하도록 구성된 세상에서 가장 큰 전세계를 연결하는 네트워크

흔히 www를 인터넷으로 착각하는 경우가 많은데 www는 인터넷을 통해 웹과 관련된 데이터를 공유하는 것

## 2. 네트워크의 분류

### 크기에 따른 분류

- LAN(local area network)

  > 가까운 지역을 하나로 묶은 네트워크

- WAN(wide area network)

  > 멀리 있는 지역을 한데 묶은 네트워크 / LAN과 LAN을 다시 하나로 묶은 것

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 12.13.19 PM.png" alt="Screenshot 2022-12-09 at 12.13.19 PM" style="zoom:50%;" />

- MAN(metropolitan area network)

- 기타 : VLAN, CLAN, PAN 등

### 연결 형태에 따른 분류

- 중앙 장비에 모든 노드가 연결된 Star형

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 12.17.27 PM.png" alt="Screenshot 2022-12-09 at 12.17.27 PM" style="zoom:50%;" />

- 여러 노드들이 서로 그물처럼 연결된 Mesh형

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 12.21.52 PM.png" alt="Screenshot 2022-12-09 at 12.21.52 PM" style="zoom:50%;" />

- 마치 나무의 가치처럼 계층 구조로 연결된 Tree형

- 링형, 버스형, 혼합형 등 기타

  > 실제 인터넷은 여러 형태를 혼합한 형태(혼합형)

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 12.24.04 PM.png" alt="Screenshot 2022-12-09 at 12.24.04 PM" style="zoom:50%;" />

## 3. 네트워크의 통신방식

### 네트워크에서 데이터는 어떻게 주고받는가?

- 유니 캐스트 : 특정 대상이랑만 1:1로 통신
- 멀티 캐스트 : 특정 다수와 1:N으로 통신
- 브로드 캐스트 : 네트워크에 있는 모든 대상과 통신

## 4. 네트워크 프로토콜

### 프로토콜이란?

프로토콜은 일종의 약속, 양식

네트워크에서 노드와 노드가 통신할 때 어떤 노드가 어느 노드에게 어떤 데이터를 어떻게 보내는지 작성하기위한 양식

택배는 택배만의 양식, 편지는 편지만의 양식, 전화는 전화만의 양식

각 프로토콜들도 해당 프로토콜만의 양식

### 여러가지 프로토콜

- 가까운 곳과 연락할 때(MAC 주소)

  - Etherrnet 프로토콜

- 멀리 있는 곳과 연락할 때(IP 주소)

  - ICMP
  - IPv4
  - ARP

- 여러가지 프로그램으로 연락할 때(포트 번호)

  - TCP, UDP

- 여러 프로토콜들로 캡슐화 된 패킷

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-09 at 12.36.27 PM.png" alt="Screenshot 2022-12-09 at 12.36.27 PM" style="zoom:50%;" />

## 5. 따라學it

### 구글과 나는 어떻게 연결되어 있는지 확인

시작메뉴 &rarr; cmd 검색 &rarr; cmd 실행

cmd에서 `tracert 8.8.8.8` 로 확인

> 맥은 `traceroute`

> 8.8.8.8 : 구글 DNS 서버의 IP주소

### Wireshark 설치

### 프로토콜 직접 보기

-----

[^node]: 네트워크에 속한 컴퓨터 또는 통신 장비를 뜻하는 말

