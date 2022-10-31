# Vim(Vi IMproved)
### 1. Motion Commands
### 2. Text Objects
1. Structure of an Editing Command
	- vim에서의 편집 명령 구조는 아래와 같다

			[숫자] [명령] [텍스트 개체 or 모션]

			또는

			[명령] [숫자] [텍스트 개체 or 모션]

		- 숫자(number) : 여러 텍스트 개체 또는 모션에 걸쳐 명령을 실행, 숫자는 선택사항이며 명령의 앞이나 뒤에 쓸 수 있다
		- 명령(command) : 변경, 삭제(잘라내기), yank(복사) 등의 작용, 명령도 선택사항이마 없으면 편집 명령이 아닌 모션 명령만 쓸 수 있다
		- 텍스트 개체 or 모션(text object or motion) : 하나의 단어, 문장, 문단 등의 텍스트 구성 / 순방향 한 줄, 역방향 한 페이지, 줄의 끝과 같은 모션
		- 편집 명령(editing command) : 명령에 텍스트 개체 or 모션을 더한 것 / 단어 지우기, 다음 문장 변경, 문단 복사 등
2. Plaintext Text Objects
	> vim은 일반 텍스트의 세가지 빌딩 블록(building blocks)을 제공한다 : 단어(words), 문장(sentences), 문단(paragraphs)
	1. 단어(Words)
		- `aw` : 한 단어(a word)(뒤따르는 여백 whitespace포함)
		- `iw` : inner 단어(inner word)(뒤따르는 여백 미포함)
		```vim	
		Lorem ipsum dolor sit amet...
		" 편집 명령 실행 전

		Lorem dolor sit amet...
		" daw 실행 후
		```
		> 모션 `w`와 텍스트 개체 `aw`는 비슷하나, 실행을 허용하는 커서 위치가 다르다
		>> `dw`로 실행할 경우 커서는 단어의 시작에 있어야 한다, 다른 위치에서는 단어의 부분만 지움  
		>> `daw`는 커서가 단어의 어떤 위치에 있어도 무방하다
	2. 문장(sentences)
		- `as` : 한 문장
		- `is` : inner 문장
		```vim
		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt
		ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
		nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
		" 편집 명령 실행 전

		Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
		nisi ut aliquip ex ea commodo consequat.
		"cis 실행 후
		```
		> `as`는 모션 쌍인 `(`와`)` 를 넘어 `aw`와 같이 커서 위치의 장점을 제공한다
		>> 이전 문장 전체에 적용하려면 `(`는 문장 끝에 커서가 있어야 하고, 다음 문장 전체에 작동하려면 `)`는 문장 처음에 있어야 함
	3. 문단(paragraphs)
		- `ap` : 한 문단
		- `ip` : inner 문단
		```vim
		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
		eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis 
		nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

		Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
		pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
		mollit anim id est laborum.
		" 편집 명령 실행 전

		Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
		pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia desrunt
		mollit anim id est laborum.
		"dap 실행 후
		```
		> 동일하게 커서 위치 장점을 가진다 : 문단의 어느 곳에서도 작동한다
3. Programming Language Text Objects
	> vim은 일반적인 프로그래밍 언어 구성체에 기반한 여러 텍스트 개체를 제공한다
	1. Strings
		- `a"` : 인용부호 문자열
		- `i"` : inner 인용부호 문자열
		- `a'` : 작은 인용부호 문자열
		- `i'` : inner 작은 인용부호 문자열
		- `a`+` : 백틱 문자열
		- `i`+` : inner 백틱 문자열
		```vim
		puts 'Hello "world"'
		" 편집 명령 실행 전
		puts 'Hello ""'
		" ci'' 실행 후
		puts ''
		" ci' 실행 후
		```
		> 첫 `'`에 커서를 위치하고 `ct'` 를 실행하면 동일한 동작을 수행하나 커서 위치에서 덜 유연하다  
		> `/'` 검색 패턴도 사용할 수 있지만 시작 `'`에 커서가 위치해야 하고, 닫는 `'`를 지우는 문제가 있다
		>> 검색 명령은 편집에는 사용하지 않는 것이 좋다
	2. Parentheses
		- `a)` : 괄호 블록
		- `i)` : inner 괄호 블록
		```vim
		Project.all(:conditions => { :published => true })
		" 편집 명령 실행 전
		Project.all
		" ci'' 실행 후
		```
		> `ab` 와 `ib`도 가능하지만, 괄호문자를 포함하는 것이 더 직관적이다  
		> `%`모션(괄호쌍 매치) 역시 가능하지만 커서 위치에서 덜 유연하다
		>> 또한 `a)`와 동일한 동작을 수행하지만 `i)`와 대치되는 동작을 수행할 방법이 없다
	3. Brackets
		- `a]` : 대괄호 블록
		- `i]` : inner 대괄호 블록
		```vim
		(defn sum [x y]
		  (+ x y))
		" 편집 명령 실행 전
		(defn sum []
		  (+ x y))
		" di] 실행 후
		```
	4. Braces
		- `a}` : 중괄호 블록
		- `i}` : inner 중괄호 블록
		```vim
		puts "Name: #{user.name}"
		" 편집 명령 실행 전
		puts "Name: #{}"
		" ci} 실행 후
		```
		> `aB` 와 `iB`도 가능하지만, 직관적이지 않다
	5. Markup Language Tags
		- `at` : 태그 블록
		- `it` : inner 태그 블록
		```vim
		<h2>Sample Title</h2>
		" 편집 명령 실행 전
		<h2></h2>
		" cit 실행 후
		```
		- `a>` : 싱글 태그
		- `i>` : inner 싱글 태그
		```vim
		<div id="content"></div>
		" 편집 명령 실행 전
		<></div>
		" cit 실행 후
		```
4. Reference : [Vim Text Objects : The Definitive Guide](https://blog.carbonfive.com/vim-text-objects-the-definitive-guide/)
