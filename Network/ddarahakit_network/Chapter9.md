# Network Chapter 9 : 연결지향형 TCP 프로토콜

## 1. TCP 프로토콜

### TCP가 하는 일

전송 제어 프로토콜(Transmission Control Protocol, TCP)은 인터넷에 연결된 컴퓨터에서 실행되는 프로그램 간에 통신을 **안정적으로, 순서대로, 에러없이** 교환할 수 있게 한다

TCP의 안정성을 필요로 하지 않는 애플리케이션의 경우 일반적으로 TCP 대신 비접속형 사용자 데이터그램 프로토콜(User Datagram Protocol)을 사용한다

TCP는 UDP보다 안전하지만 느리다

### TCP 프로토콜의 구조

안전한 연결을 지향하는 TCP프로토콜

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 12.32.06 AM.png" alt="Screenshot 2022-12-30 at 12.32.06 AM" style="zoom:50%;" />

> TCP Options의 경우, IP프로토콜에서 나온 옵션과 동일한 성격을 지님
>
> 일반적으로 없으며, 4byte씩 최대 10개가 붙을 수 있음
>
> 따라서 TCP역시 20byte ~ 60byte의 크기를 가짐

- Source Port(2byte) : 출발지 포트번호
- Destination Port(2byte) : 목적지 포트번호
- Sequence Number(4byte)
- Acknowledgment Number(4byte)
- Offser(4bit) : 헤더의 길이 / 4로 나눈값이 들어감
- Reserved(4bit) : 예약된 필드로 사용하지 않음
- TCP Flags(1byte)
- Window(2byte) : 남아있는 TCP buffer의 공간을 명시
- Checksum(2byte) : 프로토콜 이상유무 점검에 사용
- Urgent Pointer(2byte) 

## 2. TCP 플래그

### TCP 플래그의 종류

C E U A P R S F

> C, E를 제외한 나머지만 알면 충분함

- 

### 각 플래그의 기능

## 3. TCP를 이용한 통신과정

### 연결 수립 과정

### 3WayHandshake

### 데이터 송수신 과정

## 4. TCP 상태전이도

### TCP 연결 상태의 변화

### 3Way Handshaking과 함께보기

## 5. 따라學it

### TCP 3Way Handshake과정 계산해보기

### TCP 프로토콜 분석하기