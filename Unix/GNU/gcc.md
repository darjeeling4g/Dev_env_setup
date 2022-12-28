# GCC(GNU Compiler Collection)

## Options
- `-l` : 링크할 라이브러리를 명시하는 옵션
	> 정적 라이브러리를 링크시키는데 사용되며 대상 라이브러리 파일의 이름 앞의 `lib`, 뒤의 `.a`를 때고 인식함
	>> ex) `libmylib.a`을 링크 시키기 위해서는 `-lmylib`형태로 작성
- `-L` : 라이브러리 위치를 명시하는 옵션
	> 기본적으로 리눅스는 `/lib`, `/usr/lib`, `/usr/local/lib`경로에서 라이브러리 탐색
	>> ex) `-L <디렉토리명>`형태로 작성
