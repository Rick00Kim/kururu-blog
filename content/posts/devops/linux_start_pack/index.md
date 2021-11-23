---
title: "[Linux] 초기개발도구 환경설정"
date: 2021-08-25T10:00:23+09:00

tags: ["Devops"]
categories: ["documentation"]
featuredImage: "linux_start_pack.jpg"
featuredImagePreview: "linux_start_pack.webp"
description: "Linux 환경내 초기개발도구 설치"

toc:
  auto: false
---

<!--more-->

## GOAL

Linux환경내 개발도구 초기설정

## SUMMARY

- 본 Post내 모든 Command는 Ubuntu 20.04.1 LTS (Debian)에서 진행 \
  ✨ Linux계열이 Debian외 OS인 경우, Command가 다른 경우가 있음.
- 다음 Tool을 초기설정대상으로 함
  - Java
  - Maven
  - Python
  - NodeJS
  - Yarn
  - Docker
  - Docker-compose
  - Kubernetes
  - ETC

## HOW TO SET?

### 1. Java

1. JDK 다운로드

   - 아래 공식홈페이지에서 필요한 JDK버젼을 Download
     : <https://www.oracle.com/java/technologies/downloads/>
   - 본 post에서는 JDK 8u271(64bit Compressed Archive)로 진행
     : file name: jdk-8u271-linux-x64.tar.gz

2. 다운받은 JDK 폴더 압축해제 및 System관리 폴더로 이동

   ```bash
   # 다운받은 JDK가 있는 폴더로 이동
   cd Download/

   # JDK Archive파일을 압축풀기
   # Expected: 같은 directory내에 jdk1.8.0_271 폴더가 생성됨
   tar -xvzf jdk-8u271-linux-x64.tar.gz

   # 압축해제된 폴더를 아래 시스템 폴더로 이동
   # 이동 directory: /usr/local
   # (해당 directory는 시스템 폴더이기때문에, 이동시에는 root권한이 필요)
   sudo mv jdk1.8.0_271 /usr/local
   ```

3. 환경변수설정 (기타 profile 수정)
   (시스템 전체 사용자 적용)
   : file path: /etc/profile

   ```bash
   # (해당 파일은 시스템 파일이기때문에, 수정시root권한이 필요)
   sudo vi /etc/profile
   ```

   아래 Linux 실행시 적용할 JDK설정을 File 끝단에 추가

   ```bash
   JAVA_HOME=/usr/local/jdk1.8.0_271
   CLASSPATH=$JAVA_HOME/lib/tools.jar
   PATH=$PATH:$JAVA_HOME/bin
   export JAVA_HOME CLASSPATH PATH
   ```

   수정된 `/etc/profile` 적용

   ```bash
   source /etc/profile
   ```

4. 적용 확인
   ```bash
   # Java home directory가 출력되는지 확인
   echo $JAVA_HOME
   # Class path가 출력되는지 확인
   echo $CLASSPATH
   # Path에 JAVA_HOME내 bin이 포함되어있는지 확인
   echo $PATH
   ```
   java 버전 확인
   ```bash
   # 설치한 Java 버전이 출력되는지 확인
   java -version
   # 설치한 Java 버전이 출력되는지 확인
   javac -version
   ```

### 2. Maven

1. Maven 압축 파일 다운로드 & 압축해제 및 폴더 이동
   본 post에서는 maven 3.6.3로 진행

   ```bash
   # 해당 버전 maven 압축파일 다운로드
   curl -O https://ftp.yz.yamagata-u.ac.jp/pub/network/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

   # 압축해제
   # Expected: 같은 directory내에 apache-maven-3.6.3 폴더가 생성됨
   tar -xvzf apache-maven-3.6.3-bin.tar.gz

   # 압축해제된 폴더를 아래 시스템 폴더로 이동
   # 이동 directory: /opt
   sudo mv apache-maven-3.6.3 /opt/

   # Maven 전용 link 작성
   sudo ln -S /opt/apache-maven-3.6.3 /opt/maven
   ```

2. 환경변수설정 (기타 profile 수정)
   (시스템 전체 사용자 적용)
   : file path: /etc/profile

   ```bash
   # (해당 파일은 시스템 파일이기때문에, 수정시root권한이 필요)
   sudo vi /etc/profile
   ```

   아래 Linux 실행시 적용할 JDK설정을 File 끝단에 추가

   ```bash
   M2_HOME=/opt/maven
   MAVEN_HOME=/opt/maven
   PATH=$PATH:$MAVEN_HOME/bin
   export M2_HOME MAVEN_HOME PATH
   ```

   수정된 `/etc/profile` 적용

   ```bash
   source /etc/profile
   ```

3. 적용 확인
   ```bash
   # maven 설정이 출려되는지 확인
   mvn -version
   ```

### 3. Python (pip)

Ubuntu 20.04.1 LTS에 Python3는 기본 설치 되어 있기때문에 본 post에서는 pip 설치방법만 다룸
pip: <https://pip.pypa.io/en/stable/>

1. pip.py 다운로드

   ```bash
   curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
   ```

2. 실행

   ```bash
   python3 get-pip.py
   ```

3. 설치 확인

   ```bash
   pip3 --version
   ```

### 4. NodeJS

1. NodeJS 최신버젼 확인
   https://nodejs.org/en/

2. PPA repository 갱신
   ```bash
   curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   ```
3. nodeJS 설치
   ```bash
   sudo apt-get install -y nodejs
   ```
4. 설치 확인
   ```bash
   node --version
   npm --version
   ```

### 5. Yarn

[4.NodeJS] 설치가 전제

1. PPA repository 갱신
   ```bash
   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
   echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
   ```
2. yarn 설치
   ```bash
   sudo apt update && sudo apt install yarn
   ```
3. 설치 확인
   ```bash
   yarn --version
   ```

### 6. Docker

1. Docker 설치
   ```bash
   curl -fsSL https://get.docker.com/ | sudo sh
   ```
2. 현재 User를 `docker` group에 포함
   ```bash
   sudo usermod -aG docker $USER
   ```
3. 설치 및 권한 확인
   ```bash
   # docker 설치정보 및 docker server정보가 표시되는지 확인
   docker version
   ```

### 7. Docker-compose

1. docker-compose 설치
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```
2. 설치 파일에 Permission 부여
   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```
3. Linux내 명령어 폴더에 `docker-compose` Symbolic link 생성
   ```bash
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
   ```
4. 설치 확인
   ```bash
   docker-compose --version
   ```

### 8. Kubernetes

업데이트 예정

### 9. ETC

#### Vim 설정

> Reference
> https://sybarits.github.io/2019/12/24/vim-plugin.html

주로 CUI환경에서 코드작성을 많이 하기때문에 vim에 필요한 plugin을 설치해서 사용중 (선택사항)

1. vim 환경설정 폴더에 Vundle plugin 설치
   ```bash
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   ```
2. vim 설정파일에 초기설정
   ```bash
   vim ~/.vimrc
   ```
   ⬇️ 아래 내용을 paste
   사용자 작업에 맞춰 수정가능
   ```bash
   set nocompatible              " be iMproved, required
   filetype off                  " required
   " set the runtime path to include Vundle and initialize
   set rtp+=~/.vim/bundle/Vundle.vim
   call vundle#begin()
   " alternatively, pass a path where Vundle should install plugins
   "call vundle#begin('~/some/path/here')
   " let Vundle manage Vundle, required
   Plugin 'VundleVim/Vundle.vim'
   " The following are examples of different formats supported.
   " Keep Plugin commands between vundle#begin/end.
   " plugin on GitHub repo
   Plugin 'tpope/vim-fugitive'
   " plugin from http://vim-scripts.org/vim/scripts.html
   " Plugin 'L9'
   " Git plugin not hosted on GitHub
   Plugin 'git://git.wincent.com/command-t.git'
   " git repos on your local machine (i.e. when working on your own plugin),
   "Plugin 'file:///home/jjeaby/Dev/tools/vim-plugin'
   " The sparkup vim script is in a subdirectory of this repo called vim.
   " Pass the path to set the runtimepath properly.
   Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
   " Install L9 and avoid a Naming conflict if you've already installed a
   " different version somewhere else.
   " Plugin 'ascenator/L9', {'name': 'newL9'}
   " All of your Plugins must be added before the following line
   Plugin 'vim-airline/vim-airline'
   Plugin 'scrooloose/nerdtree'
   Plugin 'airblade/vim-gitgutter'
   Plugin 'scrooloose/syntastic'
   Plugin 'ctrlpvim/ctrlp.vim'
   Plugin 'nanotech/jellybeans.vim'
   call vundle#end()            " required
   "filetype plugin indent on    " required
   "NERDTree ON shortcut ("\nt")
   map <Leader>nt <ESC>:NERDTree<CR>
   let NERDTreeShowHidden=1
   " let NERDTreeQuitOnOpen=1
   let g:ctrlp_custom_ignore = {
   \ 'dir':  '\.git$\|vendor$',
    \ 'file': '\v\.(exe|so|dll)$'
   \ }
   color jellybeans
   " Settings (Tag List)
   filetype on                                 "vim filetype on
   " Settings (Source Explorer)
   nmap <F8> :SrcExplToggle<CR>                "F8 Key = SrcExpl Toggling
   nmap <C-H> <C-W>h                           "Move to left window
   nmap <C-J> <C-W>j                           "Move to bottom window
   nmap <C-K> <C-W>k                           "Move to upper window
   nmap <C-L> <C-W>l                           "Move to right window
   " Settings(Detail information)
   set nu
   set title
   set showmatch
   set ruler
   " Highlight Syntax
   if has("syntax")
   syntax on
   endif
   " Color
   set t_Co=256
   " About Indent
   set autoindent
   set smartindent
   set tabstop=4
   set shiftwidth=4
   set softtabstop=4
   set smarttab
   set expandtab
   " About Paste
   set paste
   set mouse-=a
   " UTF-8
   set encoding=utf-8
   set termencoding=utf-8
   " Highlight Cursor
   set cursorline
   " Show Status bar
   set laststatus=2
   set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
   " About search
   set ignorecase
   " Focus Cursor modified
   au BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \ exe "norm g`\"" |
   \ endif
   " Markdown syntax
   augroup markdown
    " remove previous autocmds
    autocmd!
    " set every new or read *.md buffer to use the markdown filetype
    autocmd BufRead,BufNew *.md setf markdown
   augroup END
   ```
   저장
   ```bash
   <esc>입력후
   :wq
   ```
3. Plugin install

   ```bash
   vim
   :PluginInstall
   ```
