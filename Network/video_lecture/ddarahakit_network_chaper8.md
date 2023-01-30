# Network Chapter 8 : 비연결지향형 UDP 프로토콜

[TOC]

## 1. UDP 프로토콜

### UDP가 하는 일

사용자 데이터그램 프로토콜(User Datagram Protocol, UDP)은 유닙버설 데이터그램 프로토콜(Universal Datagram Protocol)이라고 일컫기도 한다

UDP의 **전송 방식은 너무 단순**해서 서비스의 **신뢰성이 낮고**, 데이터그램 도착 순서가 바뀌거나, 중복되거나, 심지어는 통보 없이 누락시키기도 한다

UDP는 일반적으로 **오류의 검사와 수정이 필요 없는** 프로그램에서 수핼할 것으로 가정한다

### UDP 프로토콜의 구조

안전한 연결을 지향하지 않는 UDP프로토콜

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-29 at 11.52.24 PM.png" alt="Screenshot 2022-12-29 at 11.52.24 PM" style="zoom:50%;" />

- Source Port(2byte) : 출발지 포트번호
- Destination Port(2byte) : 목적지 포트번호
- length(2byte) : 헤더 페이로드까지 전부 포함한 전체 길이
- Checksum(2byte) : 프로토콜 이상유무 확인에 사용

## 2. UDP 프로토콜을 사용하는 프로그램

### UDP 프로토콜을 사용하는 대표적인 프로그램들

- 도메인을 물으면 IP를 알려주는 **DNS서버**

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-29 at 11.58.44 PM.png" alt="Screenshot 2022-12-29 at 11.58.44 PM" style="zoom:50%;" />

- UDP로 파일을 공유하는 **tftp서버**
- 라우팅 정보를 공유하는 **RIP프로토콜**

## 3. 따라學it

### tftpd를 사용하여 데이터 공유해보기

### 패킷 캡쳐 및 분석해보기