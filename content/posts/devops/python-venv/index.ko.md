---
title: "Python 가상환경 설정(venv)"
date: 2021-08-27T10:00:23+09:00

tags: ["Devops", "backend"]
categories: ["installation"]
featuredImage: "python-venv.jpg"
featuredImagePreview: "python-venv.webp"
description: "특정 버전으로 Python 프로젝트 진행하기 위한 Solution 설명"

toc:
  auto: false
---

<!--more-->

## GOAL

Python 개발진행시, 프로젝트별 특정 version 및 Library를 관리하는 방법을 기술

### 프로젝트별 특정 version 및 Library관리가 필요한 이유

1. 각 프로젝트별 사용하는 Python version과 Library가 다름
2. Library version과 채용중인 python version과의 호환성 혹은 Library간의 호환성 \
   설치 & 운용중인 Python내 Global libraries에 모든 프로젝트의 library를 관리할 경우, 프로젝트간 호환성 문제도 발생
3. 프로젝트 완료 후에 불필요한 Library가 기본 Python 내에 존재(용량 차지)

### Solution

위 Issues를 해결하기 위해 python에서는 주로 가상환경이라는 설정을 이용해 개발진행하는 것을 추천

Python 가상환경 Libraries

- virtual environment(venv)
- pyenv

## PRECONDITION

- 본 post는 기본 MacOS에서 진행 (Linux환경에서는 동작가능하지만 Windows에서는 동작하지 않을가능성이 높음)
- 본 post에서는 가상환경 libraries중 `virtual environment`에 대해 기술

## HOW TO SET?

> Reference: https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/
> : X-code설치, brew 설치 등 앞으로 개발 등 Mac에서 주로 사용하는 Plugin 설치 방법이 대부분 기술 되어 있어 선정함.

1. [`Mac`만 해당] X-code 설치

   ```bash
   # 1. xcode 설치 여부 확인
   xcode-select -p

   # 설치 되어 있는 경우, 아래와 함께 출력되면, (2)실행 할 필요 없음.
   # /Library/Developer/CommandLineTools

   # 2. xcode 설치
   xcode-select --install
   ```

2. Homebrew 설치

   > Reference: https://brew.sh/index_ko

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Homebrew를 통한 Python설치

   ```bash
   # 설치 가능한 Module 확인(Python)
   brew search python

   # Python 3 설치
   brew install python3
   ## brew에서 Python 3 설치한 경우,
   ##   1. pip : Python Library 설치 관리 tool
   ##   2. setuptools : Python 프로젝트 패키징 Tool, 테스트 빌드 배포 때 사용
   ##   3. wheel : Compile시 필요한 횟수를 줄여줌 (속도 향상)

   # Python 3 설치 확인(아래 두 명령어 중 하나를 실행)
   python3 --version
   python3 -V
   ```

   ✨ pip사용법
   : Package 검색은 <https://pypi.org/>

   ```bash
   # 기본 사용법(Library 설치)
   pip3 install <package_name>
   ```

4. virtual environment 설치

   해당 Library는 Python Global 폴더내에 설치

   ```bash
   pip3 install venv
   ```

5. Python 가상환경 설정

   ```bash
   # Python Module venv 실행
   python3 -m venv .venv

   # 가상환경 폴더 생성 확인
   ls -al
   ## 출력 .venv 폴더 확인

   # Python 가상환경 실행
   . .venv/bin/activate

   # Terminal 표시 확인
   # (.venv) user@hostname:{path}

   # Python 가상환경 적용 확인
   python --version
   ## 출력 : {Python 버전}
   which python
   ## 출력 : Users/{Mac 유저명}/Documents/Develop/workspaces/Tutorial/.venv/bin/python

   # Python 가상환경이 설정된 상태로 프로젝트 진행

   # 가상환경 설정 해제
   deactive
   ```

   ✨ 해당 Directory에서 VSCode실행시 자동 적용됨 (설정에 따라 다를수 있음)

   ```bash
   # WORKSPACE: [.venv]가 배치되어 있는 directory
   cd ${WORKSPACE}
   code .
   ```

## CONCLUSION

- 필요한 python version 혹은 Library를 프로젝트별로 관리를 가능케 함으로 다른 프로젝트와의 호환성 충돌 Issue해소
- 프로젝트 이행시, 개발환경과 같은 python version, 필요한 libraries만을 설치함으로써 환경구축에 대한 issue를 보다 감소시킬 수 있음

  ✨ 가상환경 실행중에는 `pip home directory`가 가상환경내에 존재하기때문에 아래 Command로 현재 프로젝트에서만 사용중인 Library를 출력하여 이행시에 사용

  ```bash
  pip freeze >> requirement.txt
  ```
