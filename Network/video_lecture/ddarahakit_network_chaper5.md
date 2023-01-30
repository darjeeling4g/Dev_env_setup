# Network Chapter 5 : 통신하기 전 반드시 필요한 ARP 프로토콜

[TOC]

## 1. ARP 프로토콜

### ARP가 하는 일

ARP 프로토콜은 같은 네트워크 대역에서 통신을 하기 위해 필요한 MAC주소를 IP주소를 이용해서 알아오는 프로토콜이다.

같은 네트워크 대역에서 통신을 한다고 하더라도 데이터를 보내기 위해서는 7계층부터 캡슐화를 통해 데이터를 보내기 때문에 IP주소와 MAC주소가 모두 필요하다

이때, IP주소는 알고 MAC주소는 모르더라도 ARP를 통해 통신이 가능하다

### ARP 프로토콜의 구조

IP주소를 이용해 MAC주소를 알아오는 ARP프로토콜

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-22 at 7.13.40 PM.png" alt="Screenshot 2022-12-22 at 7.13.40 PM" style="zoom:50%;" />

> Hardware Type(2byte) : 2계층 주소의 타입 / 대부분의 경우 0x0001(이더넷을 뜻하는 고유의 값)
>
> Protocol type(2byte) : 3계층 주소의 타입 / 대부분의 경우 0x0800(IPv4를 뜻하는 고유의 값)
>
> Hardware Address Length(1byte) : 맥 주소의 길이는 6byte이므로 0x06이 들어감
>
> Protocol Address Length(1byte) : IP주소의 길이는 4byte이르모 0x04이 들어감
>
> Opcode(2byte) : 현재 작업이 요청인지, 요청에 대한 응답인지를 구분해줌 &rarr; 0x0001(요청) or 0x0002(응답)
>
> Source Hardware Address(6byte) : 출발지의 MAC주소
>
> Source Protocol Address(4byte) : 출발지의 IP주소
>
> Destination Hardware Address(6byte) : 목적지의 MAC주소
>
> Destination Protocol Address(4byte) : 목적지의 IP주소

## 2. ARP 프로토콜의 통신 과정

### IP주소로 MAC주소를 알아오는 과정

A 가 B 와 통신하기 위해 맥주소를 필요한 상황으로 가정

1. A는 \[Eth프로토콜]\[ARP프로토콜]로 구성된 ARP요청 (ARP가 Eth로 캡슐화된 상태) 패킷을 생성 (opcode : 1)

   > 목적지 MAC주소를 모르기 때문에 ARP에 목적지 MAC 주소에는 0값이 들어감
   >
   > Eth의 목적지 MAC주소에는 0xFFFFFFFFFF 값이 들어감
   >
   > > 0xFFFFFFFFFF : 브로드캐스트로 통신하겠다는 의미

2. 해당 패킷을 스위치로 보냄

   > 스위치는 2계층 장비이므로 2계층까지만 확인을 함

3. 스위치는 목적지 MAC주소가 브로드 캐스트로 설정되어 있으므로 해당 대역 내 모두에게 패킷을 전송

4. 해당 패킷을 받은 장비들은 디캡슐레이션 과정을 통해서 3계층까지 확인

5. 본인의 IP주소와 목적지 IP주소가 일치하지 않는 장비들은 해당 패킷을 버림

6. 일치하는 장비(B)는 ARP응답 프로토콜을 생성 후 발송 (opcode : 2)

7. A는 해당 응답을 통해 얻은 결과를 ARP 캐시 테이블에 저장해둠

## 3. ARP 테이블

### 나와 통신했던 컴퓨터들

통신 했던 컴퓨터들의 주소는 **ARP테이블**에 남는다

> `arp -an`을 통해서 확인가능
>
> > 일정 시간이 지나면 해당 정보는 지워짐

## 4. 따라學it

### ARP 테이블 확인해보기

윈도우에서 간단하게 내 PC의 ARP테이블을 확인해보기

### ARP 프로토콜 분석하기

wireshark를 이용해서 ARP프로토콜을 캡쳐하고 분석해보기

> 패킷 분석 간 padding이라고 붙은 부분은 frame의 최소 크기(60byte)를 맞추기 위해서 붙은 값임
>
> > 최대크기는 일반적으로 1514byte(바뀔 수도 있음)
