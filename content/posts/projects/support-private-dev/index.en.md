---
title: "사내 Private project(운영지원)"
date: 2021-11-15T10:00:23+09:00
lastmod: 2021-12-05T17:45:33+09:00

tags: ["Devops", "projects"]
categories: ["private_projects"]
featuredImage: "support-private-dev.jpg"
featuredImagePreview: "support-private-dev.webp"
description: "사내 Private project진행에 따른 Devops 업무지원"

toc:
  auto: false
---

<!--more-->

##### Project 진행 시기: 2021/11/15 - 2021/11/20

## BACKGROUND

- 사내 일부 팀원들간 private project가 진행
- Project는 요구사항, UI Design, 기능설계가 진행중인 상황
- 설계가 완료된 시점에서 바로 개발에 착수할수 있도록 환경구축 및 Module Release pipeline작성에 대한 의뢰를 받음

### 개발 Stacks

- Server: Ubuntu 20.04.02 (사내 운용중)
- Web server: NGINX
- Language & Framework
  1. Frontend
     ReactJS
  2. Backend
     Node.js (express)
  3. Database
     MongoDB
  4. Tools
     - Slack
     - Git
     - Docker
     - docker-compose
     - Jenkins

### project내 역할

- 초기개발환경 구축
- Live server로의 Release용 pipeline 작성 및 테스트

## GOAL

본 project내 역할을 완료

## CONTENTS

### 초기개발환경 구축

1. 개발용 MongoDB Container를 운영서버에 실행

   - Dockerfile생성 [아래 코드는 Template]

   ```
   FROM mongo

    # Environment variables for Initializing DB
    # Mongodb Global variables
    ENV MONGO_INITDB_ROOT_USERNAME 'dev_admin'
    ENV MONGO_INITDB_ROOT_PASSWORD 'dev2140'

    # Development environment variables
    ENV DEV_DATABASE 'dev_web'
    ENV DEV_USERNAME 'dev_manager'
    ENV DEV_PASSWORD 'devPasswd1@#'

    # Copy Initialize file
    COPY ./users_init.sh /docker-entrypoint-initdb.d/

    EXPOSE 27017
   ```

   - Initialize Shell script 생성

   ```bash
   #!/bin/bash
    set -e

    echo ">>>>>>> trying to create database and users"
    if \
    [ -n "${MONGO_INITDB_ROOT_USERNAME:-}" ] && \
    [ -n "${MONGO_INITDB_ROOT_PASSWORD:-}" ] && \
    [ -n "${DEV_DATABASE:-}" ] && \
    [ -n "${DEV_USERNAME:-}" ] && \
    [ -n "${DEV_PASSWORD:-}" ]; then
    mongo -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD <<EOF
    db=db.getSiblingDB('$DEV_DATABASE');
    use $DEV_DATABASE;
    db.createUser({
      user: '$DEV_USERNAME',
      pwd: '$DEV_PASSWORD',
      roles: [{
        role: 'readWrite',
        db: '$DEV_DATABASE'
      }]
    });
    EOF
    else
        echo "Not exists environment variables..."
        exit 403
    fi
   ```

   - 원격 서버에 개발용 DB server 실행

   ```bash
   # docker 컨테이너실행에 필요한 환경변수 설정
   export mongoImageName=aacs_mongo_img
   export mongoContainerName=aacs_mongo_dev

   # docker build
   docker build -f DockerfileForMongo -t ${mongoImageName} .

   # docker run
   docker run --name ${mongoContainerName} -p 27017:27017 --rm -d ${mongoImageName}
   ```

2. Git repository내 Frontend & Backend 모듈 생성

   - Git repository clone

   ```bash
   git clone {project repository URL}
   ```

   - Backend folder 생성 & NodeJS init

   ```bash
   # 폴더 생성
   mkdir backend

   # NodeJS init
   cd backend && npm init
   ```

3. React module 생성

   ```bash
   yarn create react-app frontend
   ```

✨ Github 운영 rules
{{< admonition type=info title="Github flow" open=false >}}
![Gitflow-1](git-flow_1.png)
![Gitflow-2](git-flow_2.png)
{{< /admonition >}}

### Github actions 생성

Update 예정

### Live server release용 pipeline생성

Update 예정

## CONCLUSION

- 개발 Team의 의뢰 달성, 현재 개발진행중
- Jenkins Pipeline 생성완료
