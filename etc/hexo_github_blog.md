# Hexo로 Github Blog 만들기
> 온라인 특강 by. 김루비 m-ruby 멘토

### 1. Hexo 란?
- Node.js기반의 정적 사이트 생성기(static site generator)의 일종
- 주요 사용자 : 중국인
- Markdown으로 글 작성
- 빠른 빌드 및 배포
- 일반적으로 2개의 github repository필요
	1. 빌드 및 배포가 이루어지는 실질적으로 보이는 repository(... github.io)
	1. 실제 소스가 들어있는 repository(블로그 설정 파일 및 블로그 글)
	1. 테마 소스가 들어있는 repository

### 2. Hexo 설치 및 기본 세팅
- nvm으로 npm 설치하기

```zsh
# nvm 설치하기
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# npm 설치하기
nvm install node # 가장 최신버전 node 설치

or

nvm install 14.7.0 # 특정 node 버전 설치

# nvm에서 node 활성화하기
nvm use node

or

nvm use 15.11.0 # 특정 node 버전 활성화
```

- github repository 생성 : `자신의 github 계정명.github.io`
> 이미 해당 repository가 존재하고 추가적으로 생성하기를 희망할 경우
>> 다른 이름으로 생성 후 config에서 url 란에 `자신의 github 계정명.github.io/repository이름`으로 기입
>>> repository설정 ->> pages ->> bransh ->> 브랜치 설정 후 save
- 터미널에서 npm을 이용하여 hexo-cil 설치 및 hexo folder생성

```zsh
npm install hexo-cli -g

hexo init "원하는 폴더명"

cd "원하는 폴더명"
```

### 3. Hexo 폴더 구조 설명
- `source`  : 블로그 글 관리
- `theme` : 블로그 테마/디자인

### 4. Hexo 기본 명령어(서버 실행, 글 생성, 글쓰기, static file생성, 배포)

#### Hexo server 실행시키기

```zsh
hexo s

or

hexo server
```
> `http://localhost:4000/` 로컬호스트에서 확인가능

#### Hexo 글 작성하기
```zsh
hexo new "글제목"

or

# /source/_post/ 내에 직접 md파일 생성
```

#### github블로그로 배포하기
- hexo에서 github repository로 배포하기 위해서는 `hexo-deployer-git`플러그인과 `_config.yml`에서 기본 세팅이 필요
- 다음의 명령어로 배포 플러그인 설치
```zsh
npm install hexo-deployer-git --save
```

- `_config.yml`을 다음과 같이 수정한다 (repo주소가 .git으로 끝나는지 확인한다)
```yml
deploy:
  type: git
  repo: "자신의 github.io repository 주소"
  branch: master
```

- 아래의 명령어로 블로그 배포
```zsh
hexo d -g

or

hexo deploy -generate
```
> `자신의 github닉네임.github.io` 로 접속하여 local과 동일하게 확인
>> 수정이 반영되지 않았다면 `hexo clean`입력 후 다시 배포 시도

### 5. Hexo 테마 변경하기

> 테마 설치의 경우 아래의 방식을 이용하기 보다는 각 테마마다 제공하는 공식 문서 installation 방식으로 설치할 것을 권장
#### ~~원하는 테마파일 clone및 dependencies 설치~~
- git clone 명령어를 통해 파일을 다운받는다 `theme/다운받은_테마_파일명`로 설정
> ex) `theme/icarus`
```zsh
git clone https://github.com/ppoffice/hexo-theme-icarus.git icarus
```
- dependencies 설치: 각 테마마다 요구하는 dependencies가 다르니 확인할 것
```zsh
npm install cheerio share-this hexo-generator-json-content -g
```

#### `_config.yml` 파일을 수정하여 theme를 icarus로 세팅
- icarus가 아닌, hexo 블로그(hexo 디렉토리 구조)의 `_config.yml`에서 theme수정
```yml
theme: icarus
```
- 이후 서버를 실행하여 테마 적용결과 확인

### 6. Hexo 블로그 글 백업하기

#### 백업 repository 생성하기
각자의 github에 접속하여 2개의 repository를 생성한다
- theme를 저장할 repository
- .md 파일을 저장할 repository

#### theme 백업하기
```zsh
# 원격 저장소 변경(theme url로 된 세팅을 자신의 repository url로 재세팅)
git remote set-url origin "theme를 저장할 repository 주소"

# 테마 내용 백업
git commit -m "theme backup"
git push origin
```

#### .md 파일 백업하기
hexo blog 디렉토리에서 .md파일을 저장할 repository를 세팅해준다
```zsh
# git 초기화
git init

# 원격 저장소 등록
git remote add origin ".md파일을 저장할 repository 주소"

# 현재 내용 백업
git add .
git commit -m "blog backup"
git push origin
```

#### (선택) theme폴더 submodule추가
- 위의 백업까지 마치면 해당 repo들을 클론하여 .md파일과 theme를 그대로 유지할 수 있다
- 다만, 두 개의 repo를 각각 clone해야 한다는 문제가 있음
	- backup repo만 클론해도 내부 theme repo도 클론할 수 있도록 아래와 같이 설정한다
```zsh
# 기존의 <themes/테마명>를 삭제
rm -rf themes/테마명

# 백업해둔 theme repository를 submodule로 추가
git submodule add "theme를 저장한 repository 주소"

# 현재 내용 백업
git add .
git commit -m "blog theme submodule"
git push origin
```

- 새로운 환경에서 블로그를 운영할 때는 아래와 같이 입력한다
```zsh
git clone --recursive ".md파일을 저장한 repository 주소" blog
cd blog
npm install
```

#### tips
- github에서 IDE환경 사용하기 : 특정 repo url에서 .com ->> .dev로 변경하기
> 단순히 '.'을 누르는 것만으로도 가능

### Reference
[Hexo로 github blog 만들기 by. rubykim](https://ruby-kim.github.io/2022/04/07/Hexo/Install/)
