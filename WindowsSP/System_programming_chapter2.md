# System Programming Chapter 2 : 아스키 코드 vs 유니 코드
### 1. Windows 에서의 유니코드(UNICODE)
- 문자셋의 종류와 특성
	- SBCS(single byte character set)
		- 문자를 표현하는데 1바이트 사용
		- ex) 아스키 코드
	- MBCS(multi byte charater set)
		> 문자열을 구성하는 내용에 따라서 각기 다른 바이트를 사용
		- 한글은 2바이트, 영문은 1바이트 사용
	- WBCS(wide byte charater set)
		> MBSC에 비해서 데이터 크기는 커지나 안정성에서 유리함
		>> 데이터 크기 역시 최근 디바이스 메모리 용량이 충분한 크기이기 때문에 일반적으로 문제되지 않음
		- 문자를 표현하는데 2바이트 사용
		- 유니코드
	```c
	// MBSC를 사용했을 때 발생하는 문제점
	int main(void)
	{
		char str[] = "ABC한글"
		int size = sizeof(str);
		// 1*3 + 2*2 + 1 = 8
		int len = strlen(str);
		// 1*3 + 2*2 = 7

		printf ("배열의 크기 : %d \n", size);
		printf ("문자열 크기 : %d \n", len);

		return 0;
	}

	// 실행결과
	배열의 크기 : 8
	문자열 크기 : 7
	```
- WBCS기반의 프로그래밍
	- WBCS를 위한 두가지
		- 첫째 : char를 대신하는 wchar_t
			> 2바이트로 정의되어 있음 즉, 유니코드 기반으로 하는 자료형
		- 둘째 : "ABC"를 대신하는 L"ABC"
	- WBCS기반 문자열 선언 예
		- wchar_t str[] = L"ABC";
	```c
	int main(void)
	{
		wchar_t str[] = L"ABC"
		int size = sizeof(str);
		int len = wcslen(str);
		// strlen의 경우 SBCS(or MBCS)기반 함수이므로 사용시 컴파일 에러가 남(내부적으로 매개변수가 1바이트 자료형으로 되어있음)

		wprintf (L"배열의 크기 : %d \n", size);
		// printf역시 아스키코드 기반으로 처리하므로, wprinf를 사용하여 유니코드 기반으로 처리
		wprintf (L"문자열 크기 : %d \n", len);

		return 0;
	}

	// 실행결과
	배열의 크기 : 8
	문자열 크기 : 3
	```
- 매개변수 전달인자 유니코드화
	- `c:\> test.exe. AAA BBB` 의 형태로 인자를 받는다고 했을 때, 아래와 같이 정의
		- 아스키코드 기반의 경우 `int main(int argc, char* argv[])`
		- 유니코드 기반의 경우 `int wmain(int argc, wchar_t* argv[])`

### 2. MBCS와 WBCS의 동시지원
- MBCS 와 WBCS 동시 지원 매크로
```c
#ifdef UNICODE
	typedef	wchar_t		TCHAR;
	typedef	wchar_t*	LPTSTR;
	typedef	const wchar_t*	LPCTSTR;
#else
	typedef	char		TCHAR;
	typedef	char*		LPTSTR;
	typedef	const char*	LPCTSTR;
#endif
/*
 windows.h상 내부적으로 아래처럼 정의되어 있어 매크로 선언시 아래 자료형의 형태로 써도 무방
 typdef char	CHAR;
 typdef wchar_t	WCHAR;
*/
```
```c
#ifdef _UNICODE
	#define __T(x)	L##x
	//##의 의미는 앞(L)과 뒤(x)를 붙이라는 의미
	// ex) __T("ABC") --> L"ABC"
#else
	#define __T(x)	x
#endif

#define _T(x)		__T(x)
#define _TEXT(x)	__T(x)
//위아래 어떤 것을 써도 동일
```
```c
// 실제 예시
#define UNICODE
#define _UNICODE

int wmain(void)
{
	TCHAR str[] = _T("1234567");
	int size = sizeof(str);
	printf("string length : %d\n", size);
	return 0;
}
```
- MBCS 와 WBCS 동시 지원 함수
```c
#ifdef _UNICODE
	#define	_tmain		wmain
	#define	_tcslen		wcslen
	#define	_tpirnft	wprintf
	#define	_tscanf		wscanf
#else
	#define	_tmain		main
	#define	_tcslen		strlen
	#define	_tpirnft	printf
	#define	_tscanf		scanf
#endif
```
