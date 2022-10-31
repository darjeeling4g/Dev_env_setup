" -----------------------------------------------
" 1. General settings.
" -----------------------------------------------

" 문법 하이라이트
if has("syntax")
	syntax on
endif
" / 검색으로 매칭되는 문자열 하이라이트
set hlsearch
" / 문자 입력시마다 문자 하이라이트
set incsearch
" 라인넘버 출력
set nu
" 매칭되는 괄호 하이라이트
set showmatch
" 커서위치 줄, 행번호 출력
set ruler
" 마우스 입력 허용
set mouse=a
" 수정 직후 buffer를 감춰지도록 함 = 저장없이 다른 버퍼로 이동 가능
set hidden
" 인코딩 방식 지정(devicons 플러그인 적용위해 사용) 
set encoding=UTF-8
" 무명 레지스터를 시스템 클립보드로 복사
set clipboard=unnamed
" list mode 활성 : 화면에 보이지 않는 문자 표시
set list
" showbreak : 문자길이가 윈도우를 초과하여 화면상 적용되는 줄바꿈
set showbreak=↪\ 
" tab :'탭의 첫머리''이후 뒷부분'
" eol : 개행문자(end of line)
" space : 공백문자
" nbsp : 줄바꿈 없는 공백(non-breaking space)
" trail : 구문이 끝난 뒤 불필요 공백문자
" extends : 'nowrap' 상태에서 화면 뚫고 넘어간 문장의 오른쪽 영역
" precedes: 'nowrap' 상태에서 화면 뚫고 넘어간 문장의 왼쪽 라인
set listchars=tab:\|\ ,eol:↲,space:·,nbsp:␣,trail:•,extends:»,precedes:«
" Nontext : eol, extends, precedes
" Specialkey : nbsp, tab, trail
" ctermfg : 컬러 터미널 적용 색상
" guifg : GUI 적용 색상
hi NonText ctermfg=7 guifg=gray
hi SpecialKey ctermfg=7 guifg=gray
" insert모드에서 한글입력 중 명령모드로 나왔을때 자동으로 한영 전환을 해주기위함, 아래 input-source-switcher.git 설치가 선행되어야 함
" git clone git@github.com:vovkasm/input-source-switcher.git
" cd input-source-switcher
" mkdir build
" cd build
" cmake ..
" make
" make install
if has('mac') && filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
  autocmd InsertLeave * call libcall('/usr/local/lib/libInputSourceSwitcher.dylib', 'Xkb_Switch_setXkbLayout', 'com.apple.keylayout.US')
endif

" -----------------------------------------------
" 2. Key mapping.
" -----------------------------------------------

" (n : nomal mode / nore : non-recursive / map : mapping)
" <BAR> : '|' vertical bar / <CR> : carriage return / <C-...> : control-key
" <leader> : default로 '\'되어 있음, 이를 변경하기 위해서는 let mapleader=""
" <silent> : Key mapping sequence가 실행될때, 별도 메시지 표출하지 않음
" 신규 buffer 생성 = ctrl+t
nnoremap <C-t> :enew<CR>
" 현재 버퍼 종료 후 이전 버퍼로 이동 = ctrl+x
nnoremap <C-x> :bp <BAR> bd #<CR>
" 이전 buffer로 이동 = ctrl+j
nnoremap <C-j> :bprevious<CR>
" 다음 buffer로 이동 = ctrl+k
nnoremap <C-k> :bnext<CR>
" 왼쪽 윈도우로 이동 = ctrl+h
nnoremap <C-h> <C-w>h
" 오른쪽 윈도우로 이동 = ctrl+l
nnoremap <C-l> <C-w>l

" -----------------------------------------------
" 3. Plugins(vim-plug).
" -----------------------------------------------

call plug#begin('~/.vim/plugged')
	" nerdtree : 파일 관리자(트리 형태로 파일목록 출력)
	Plug 'preservim/nerdtree'
	" tagbar : ctags로 생선된 결과 표시(ctags설치 필요)
	Plug 'preservim/tagbar'
	" airline : 하단 및 상단 상태파 표시
	Plug 'vim-airline/vim-airline'
	" airline : airline 테마
	Plug 'vim-airline/vim-airline-themes'
	" ctrlp : 하위 디렉토리 파일 찾기(ctrl+p로 파일 접근)
	Plug 'kien/ctrlp.vim'
	" diminacitve : 커서가 위치하지 않는 윈도우 표시
	Plug 'blueyed/vim-diminactive'
	" 42header : 42header생성(stdheader)
	Plug '42Paris/42header'
	" devicons : 폴더, 파일 icon표시
	Plug 'ryanoasis/vim-devicons'
	" markdown preview : 마크다운 파일 미리보기
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" -----------------------------------------------
" 4. Plugins setting. 
" -----------------------------------------------

let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
:hi ColorColumn ctermbg=8
" set to 1, vim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
" set default theme (dark or light)
let g:mkdp_theme = 'dark'
