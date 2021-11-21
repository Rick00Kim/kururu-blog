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

3. 환경변수설정 (기타 profile 수정) \
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

2. 환경변수설정 (기타 profile 수정) \
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

### 3. Python

### 4. NodeJS

### 5. Yarn

### 6. Docker

### 7. Docker-compose

### 8. Kubernetes

### 9. ETC

#### Vim 설정
