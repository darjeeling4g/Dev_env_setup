# [목요 특강] Git과 더 친해져봅시다 by. 박성민 멘토

#### commit

- 커밋 : 파일 변경사항 묶음

- 커밋에는 고유 해시값이 존재

#### tag & branch

- tag

  - 커밋의 alias

    ```git
    git tag v0.0.1
    ```

- branch

    - 커밋의 alias

      ``` git
      git branch branch1
      ```


- branch vs tag

  - branch : 새로 생성된 커밋을 가리킴
  -  tag : 커밋을 이동하지 않음

#### .git/refs

- git에 대한 메타정보들이 담겨있음

#### HEAD

- 여러 브랜치 중 내가 현재 보고 있는건 어떤 브랜치인가를 나타냄

#### merge

  - 서로 다른 branch를 병합하여 새로운 커밋을 생성

    > 2개의 branch를 합치게 되므로 log상 부모가 2개가 됨


- merge conflict


    - 서로 다른 커밋이 동일한 파일을 수정했을 경우 발생
      
      > 직접 파일을 수정해주어야 함
      
        ```git
        <<<<<<HEAD
        text1
        ===========
        text2
        >>>>>>branch1
        ```
      
        > 위와 같이 변경된 파일을 원하는대로 수정후에 `git add` , `git commit` 을 진행하면됨



#### cherry-pick

- 다른 branch에서 현재 branch로 특정  commit을 가져오고 싶을 때 사용

- 해당 commit을 복사하여 **새로운 커밋**을 생성 후 현재 브랜치에 붙이게 됨

  ```git
  git cherry-pick b1
  // b1만 가져오고 싶을때
  
  git cherry-pick b1 b2 b3
  // 여러개를 가져오고 싶을때
  
  git cherry-pick b2 ... b4
  // 연속된 커밋들을 다량으로 가져오고 싶을 때
  // b2< .. <= b4
  ```

#### rebase

> 베이스를 변경한다

1. 두 브랜치 공통 부모를 찾는다
2. a1부터 현재까지 커밋 수집
3. main을 새 베이스로
4. 커밋을 새로 쌓는다

> 최종 rebase된 커밋들은 해시값이 바뀜
>
> > 즉, cherry-pick을 여러번 수행한 것과 같음

- rebase conflict
  - merge confilct와 동일하게 충돌나는 지점을 직접 수정해줘야 한다

- merge vs rebase
  - 완료한 시점에서 봤을 때, 두 개의 branch를 합친다는 점은 동일함
  - merge : merge를 진행한 별도의 새로운 커밋이 생김
  - rebase : 생성한 커밋을들 순차적으로 정렬할 수 있음
    - 정렬된 커밋들의 해시값이 바뀌므로 다른 사용자 입장에서는 아예 다른 작업이 됨
    - 강제로 푸쉬해야 한다
    - 여러 사람과 함께 사용할때는 merge를 사용하는 것이 바람직
    - `git push -f`

#### checkout & switch
  - switch : branch만 이동 가능
  - checkout : branch, tag, commit등으로 이동 가능(다양한 기능을 수행 )

#### 원격 저장소 변경하기

- `git remote remove origin`  : 현재 원격저장소 연결 끊기
- `git remote -v` : 현재 연결된 원격저장소 확인
- `git remote []` : 새로운 원격저장소 연결

#### git command

- glog?

  - oh my zsh사용 시 `alias glog='git log --oneline --decorate --graph'` 로 사전 정의  되어있음

    > 그 외에도 다른 commad들에 대해서도 alias 설정되어 있음
    >
    > > 저장위치는 `/$HOME/.oh-my-zsh/plugins/git`에서 확인 가능

- git log --oneline --decorate --graph --all
  - --all : 모든 브랜치에 대해서 표시
- git alias 설정예시
  - git config --global alias.l "log --oneline --decorate --gragh"
  - git config --global alias.la "log --oneline --decorate --gragh --all"

-----

#### 임시로 변경사항 저장하기

- git stash

  > 변경 사항에 대해서 임시로 저장을 수행함
  >
  > 스택의 형태로 순차적으로 저장

- git stash pop

- 파일 작업하다가 다른 브랜치로 이동할 경우

#### 이전 커밋으로 잠시 돌아가기

- git checkout {commit의 해시값}

  > 다시 앞으로 돌아가려고 할때는 앞의 커밋로그를 확인할 수 없으므로 `git checkout {branch 이름}` 로 맨앞으로 이동

#### 이전 커밋을 삭제하기

- git revert : 커밋을 반대로 돌려놓은 "커밋"이 쌓인다

- git reset (--mixed) : 파일의 내용을 변경하지 않음

  > commit만 제거하고 현재 상태의 파일들은 변경없이 남아있음
  >
  > default 옵션이 mixed로 설정되어 있음

- git reset --hard : 파일의 내용까지 변경함

#### 삭제한 커밋 다시 되돌리기

- git reflog : 현재까지 수행한 모든 작업에 대한 log가 남아있음

  > 위의 log로 다시 되돌리고 싶은 해시값을 찾아 git reset --hard {해시값}으로 되돌릴 수 있음

#### 커밋을 수정하기

- 커밋 메시지 변경하기
  - git rebase -i
  - reword : 커밋 메시지 변경
    1. 바꾸고자 하는 커밋의 시작점 - 보다 앞에 있는 커밋 해시값 복사
    2. git rebase -i (해시값)
    3. pick --> reword 후 저장
    4. 커밋 메시지 변경 후 저장
- 서로 다른 커밋을 묶기
  - git rebase -i
  - fixup : 이전 커밋 메시지를 그대로 사용
  - squash : 합칠 커밋의 새로운 메시지 작성

- 중간 커밋을 삭제하기

  > revert로 삭제 가능하지만 삭제했다는 새로운 커밋이 생성됨
  >
  > reset으로 삭제할 경우 해당 커밋 시점이후 모든 커밋이 삭제됨

  - git rebase -i
  - drop : 로그 상 중간에 특정 커밋만 삭제

- 커밋 순서를 변경하기

  - git rebase -i
  - 표신된 문서에서 커밋의 줄 순서를 바꿈

#### 유용한 Reference

- Learn git branching
