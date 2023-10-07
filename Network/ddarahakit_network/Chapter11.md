# Network Chapter 11 : 7계층 프로토콜 HTTP

## 1. HTTP 프로토콜

### 웹을 만드는 기술들

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.00.58 PM.png" alt="Screenshot 2022-12-30 at 1.00.58 PM" style="zoom:50%;" />

> 가장 기본적인 기술들 위주로 작성되어 있음

- HTML : 웹 페이지를 채울 내용

- Javascript : 웹 페이지를 들어갈 기능

- CSS : 웹 페이지를 예쁘게 꾸밀 디자인

- 위의 3가지 일반적으로 웹표준이라고 하며, 클라이언트 단에서 동작하는 코드

  > frontend developer

- HTTP : 웹표준 데이터(HTML, CSS, JS)를 웹 서버에 요청하고 받아오는 프로토콜 / HTTP : 보안요소가 추가됨

- ASP/ASP.NET, JSP, PHP : 웹 서버 컴퓨터에서 동작하는 코드

  > backend developer

### HTTP프로토콜의 특징

HyterText Transfer Protocol(하이퍼 텍스트 전송 프로토콜)

www에서 쓰이는 핵심 프로토콜로 문서의 전송을 위해 쓰이며, 오늘날 거의 모든 웹 애플리케이션에서 사용되고 있다 &rarr; 음성, 화상 등 여러 종류의 데이터를 MIME로 정의하여 전송 가능

HTTP 특징 : Request / Response (요청/응답) 동작에 기반하여 서비스 제공

- HTTP 1.0의 특징

  - "연결 수립, 동작, 연결 해제" 의 단순함이 특징 &rarr; 하나의 URL은 하나의 TCP 연결
  - HTML문서를 전송 받은 뒤 연결을 끊고 다시 연결하여 데이터를 전송한다

- HTTP 1.0의 문제점

  - 단순 동작(연결 수립, 동작, 연결 해제)이 반복되어 통신 부하 문제 발생

### HTTP프로토콜의 통신과정

- HTTP 1.0 : 네트워크 부하가 심함

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.20.13 PM.png" alt="Screenshot 2022-12-30 at 1.20.13 PM" style="zoom:50%;" />

- HTTP 1.1 : 1.0의 문제점을 보완

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.22.05 PM.png" alt="Screenshot 2022-12-30 at 1.22.05 PM" style="zoom:50%;" />

## 2. HTTP 요청 프로토콜

### HTTP요청 프로토콜의 구조

요청하는 방식을 정의 하고 클라이언트의 정보를 담고 있는 요청 프로토콜 구조

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.26.50 PM.png" alt="Screenshot 2022-12-30 at 1.26.50 PM" style="zoom:50%;" />

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.27.49 PM.png" alt="Screenshot 2022-12-30 at 1.27.49 PM" style="zoom:50%;" />

> 실제 구조를 확인해보면 위와 같은 형태

- Request Line은 기본적으로 아래와 같은 구조를 가진다

  <img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.29.42 PM.png" alt="Screenshot 2022-12-30 at 1.29.42 PM" style="zoom:50%;" />

### 요청 타입

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.31.11 PM.png" alt="Screenshot 2022-12-30 at 1.31.11 PM" style="zoom:50%;" />

> GET방식의 경우 문서를 요청하는데 사용하지만, POST처럼 데이터를 전송할 수도 있음
>
> > POST방식과의 차이점
> >
> > GET은 보내고자 하는 데이터를 URL에 포함시켜 보내게 됨
> >
> > POST는 body에 보내고자 하는 데이터를 포함시켜 보냄
> >
> > > GET방식은 URL에 데이터가 노출되기 때문에 보안상 문제가 있을 수 있음

### URI

Uniform Resource Identifier(URI)

인터넷 상에서 특정 자원(파일)을 나타내는 유일한 주소

<img src="/Users/yangsiseon/Desktop/TIL/asset/img/Screenshot 2022-12-30 at 1.44.02 PM.png" alt="Screenshot 2022-12-30 at 1.44.02 PM" style="zoom:50%;" />

> http/https통신을 할때 포트는 일반적으로 생략됨
>
> > 경로는 해당 서버에 저장되어있는 리소스의 위치경로

## 3. HTTP 응답 프로토콜

### HTTP응답 프로토콜의 구조

### 상태 코드

## 4. HTTP 헤더 포맷

### HTTP 헤더 구조

### 일반 헤더

### 요청 헤더

### 응답 헤더

## 5. 따라學it

### HTTP 작성 실습

Netcat을 이용하여 HTTP 프로토콜을 직접 작성해보기

### HTTP 수정 실습

HTTP 요청과 응답 프로토콜을 각각 캡쳐해보고 수정해보기
