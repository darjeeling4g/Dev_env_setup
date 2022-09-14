# Make

## make 와 Makefile
`make` : Unix계열 운영 체제에서 주로 사용되는 프로그램 빌드도구
`Makefile` : 파일 간의 의존성, 프로그램 컴파일을 위한 명령등의 구조로 기술된 파일

## make사용에 따른 이점
> - 각 파일에 대한 반복적 명령의 자동화
> - 프로그램 종속 구조 파악, 관리에 용이
> - 반복 작업, 재작성 최소화

## Makefile - 구성
```make
[macro] = johndoe

[Target] : [...Dependencies...]
	[...Command...]
```
> - 목적파일(`Target`)
>	- 목적규칙(실행 파일, object파일, 라이브러리)를 정의
> - 의존성(`Dependency`)
>	- `Target`을 만들때, 의존성(연관관계)를 규정한다
>	- 의존관계로 정의되어있는 것과 동일한 이름을 가진 `Target`이 존재하고 의존파일이 존재하지 않는다면, 선행적으로 의존파일 생성을 위한  `Target`을 실행한다
>	- `Target`과 수정시간 비교를 통해서 `Target`보다 나중에 수정되었으면 `Target`을 다시 만든다
> - 명령어(`Command`)
>	- `Target`을 만들기 위한 명령어 집합
>	- 반드시 탭으로 들여쓰기 되어야 한다
> - 매크로(`macro`)
>	- 반복되는 구문을 줄이도록 지원
>	- 선언이후 참조시 `$(macro)`의 형태로 작성

## Makefile - 내부매크로
## Makefile - 조건문
## Makefile - function

## make - option

## make - issue

## References
- https://www.gnu.org/software/make/manual/html\_node/
- https://ko.wikipedia.org/wiki/Make_(%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4)
- https://bowbowbow.tistory.com/12 
- https://love-every-moment.tistory.com/47
