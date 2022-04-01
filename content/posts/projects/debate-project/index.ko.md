---
title: "생각공유 웹 서비스"
date: 2022-01-15T10:00:23+09:00
lastmod: 2021-09-14T17:45:33+09:00

tags: ["Devops", "Backend", "Frontend", "projects"]
categories: ["private_projects"]
featuredImage: "debate-project.jpg"
featuredImagePreview: "debate-project.webp"
description: "자기생각을 자유롭게 공유할수 있는 웹서비스를 구축"

lightgallery: true

toc:
  auto: false
---

<!--more-->

##### Project 진행 시기: 2021/11/10 - 2022/01/03

##### REPOSITORY: https://github.com/Rick00Kim/Debate_project

## BACKGROUND

국적불문하고 하나의 주제를 가지고 여러 사람이 의견을 공유하는 토론의 장이 있으면 어떨까?

혹은 자신의 고민거리를 여러사람에게 공유하여 공감을 받을 기회가 있으면 어떨까?

## GOAL

자기생각을 자유롭게 공유할 수 있는 토론의 장을 웹 서비스로서 구축 및 관리

## PRECONDITION

1. Frontend, Backend 구분해서 모듈을 작성할것
2. Container기술을 적극활용하여 구축할것

## PROJECT FLOW

### 1. Infra & Stack

1. Compute Instance (원격서버)

   Oracle Cloud Infrastructure 채용

   🪄 구축 및 관리방법은 [Oracle Cloud Infrastructure 학습하기](../../cloud/oci-basics) 참조

   ⚙️ 서버내 설치 툴

   1. [Docker](https://www.docker.com/): Container 이용목적
   2. [docker-compose](https://docs.docker.com/compose/): Docker이용 복수 Container 관리목적 \
      🔆 이후 복수 Container 관리는 [Kubenetes](https://kubernetes.io/) 채용 예정

2. Web server

   [NGINX](https://www.nginx.com/)

3. Database

   [MongoDB](https://www.mongodb.com/)

4. Language & tool

   - [React](https://reactjs.org/): Frontend 모듈용 Javascript Framework
   - [NodeJS](https://nodejs.org/): Javascript runtime, Package관리목적
   - [Python 3.8](https://www.python.org/): Backend 모듈용 언어
   - [Flask](https://flask.palletsprojects.com/en/2.0.x/): Python web framework
   - [VSCode](https://code.visualstudio.com/): Text editor
   - [Github](https://github.com/): Source 관리
   - [Github actions](https://github.com/features/actions): CI/CD 이용

{{< admonition info "환경구축" >}}

1. [초기개발도구 환경설정](../../devops/linux-start-pack)내 이하 항목을 설치

   - Python
   - NodeJS
   - Yarn
   - Docker
   - Docker-compose

2. 개발용 MongoDB 설치방법

   1. Dockerfile 작성

      ```dockerfile
      FROM mongo

      # Environment variables for Initializing DB
      # Mongodb Global variables
      ENV MONGO_INITDB_ROOT_USERNAME 'dev_debate_admin'
      ENV MONGO_INITDB_ROOT_PASSWORD 'debate1234'

      # Environment variables
      ENV TARGET_DATABASE 'debate_web'
      ENV TARGET_USERNAME 'debate_manager'
      ENV TARGET_PASSWORD 'manDEV1234'

      # Copy Initialize file
      COPY ./init.sh /docker-entrypoint-initdb.d/

      EXPOSE 27017
      ```

   2. init.sh 작성

      ```bash
      #!/bin/bash
      set -e

      echo ">>>>>>> trying to create database and users"
      if \
      [ -n "${MONGO_INITDB_ROOT_USERNAME:-}" ] && \
      [ -n "${MONGO_INITDB_ROOT_PASSWORD:-}" ] && \
      [ -n "${TARGET_DATABASE:-}" ] && \
      [ -n "${TARGET_USERNAME:-}" ] && \
      [ -n "${TARGET_PASSWORD:-}" ]; then
      mongo -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD <<EOF
      db=db.getSiblingDB('$TARGET_DATABASE');
      use $TARGET_DATABASE;
      db.createUser({
      user: '$TARGET_USERNAME',
      pwd: '$TARGET_PASSWORD',
      roles: [{
         role: 'readWrite',
         db: '$TARGET_DATABASE'
      }]
      });
      EOF
      else
         echo "Not exists environment variables..."
         exit 403
      fi
      ```

   3. Docker image 생성 및 Run

      1. Set environment variables

         ```bash
         # Image name
         export mongoImageName=dev_debate_mongo_img
         # Container name
         export mongoContainerName=dev_debate_mongo
         ```

      2. Build

         ```bash
         docker build -f DockerfileForMongo -t ${mongoImageName} .
         ```

      3. Run Container
         ```bash
         docker run --name ${mongoContainerName} -p 27017:27017 --rm -d ${mongoImageName}
         ```

{{< /admonition >}}

### 2. Design

#### 화면 레이아웃(초판)

1.  Index

    초기화면

    {{< image src="layout-index.png" alt="layout-index" width="40%">}}

2.  Login

    로그인화면

    {{< image src="layout-login.png" alt="layout-login" width="40%">}}

3.  Signup

    회원가입화면

    {{< image src="layout-signup.png" alt="layout-signup" width="40%">}}

4.  Main

    토론메인화면

    {{< image src="layout-main.png" alt="layout-main" width="40%">}}

#### API Endpoint

|  No | Category | End point                | Function name       | Method | description                            |
| --: | -------- | ------------------------ | ------------------- | ------ | -------------------------------------- |
|   1 | Auth     | /api/auth                | Authorize           | POST   | Login                                  |
|   2 | Users    | /api/signup              | Sign up             | POST   | Sign up user                           |
|   3 | Users    | /api/users               | Get all users       | GET    | get all users (Manage)                 |
|   4 | Topics   | /api/topic               | Get topic           | GET    | Get all topics                         |
|   5 | Topics   | /api/topic/{topic_num}   | Get specific topic  | GET    | Get specific topic (Use path variable) |
|   6 | Topics   | /api/topic               | Resister topic      | POST   | Register new topic                     |
|   7 | Topics   | /api/topic               | Modify topic        | PUT    | Modify topic                           |
|   8 | Topics   | /api/topic/{topic_num}   | Delete topic        | DELETE | Delete topic                           |
|   9 | Debates  | /api/debates/{topic_num} | Get Debate List     | GET    | Get Debate list by topic               |
|  10 | Debates  | /api/debates             | Resister Debate     | POST   | Register debate linked topic           |
|  11 | Debates  | /api/debates/{debate_id} | Delete Debate       | DELETE | Delete specific debate                 |
|  12 | Debates  | /api/debates             | Modify Debate       | PUT    | Modify debate                          |
|  13 | Like     | /api/like/{debate_num}   | Get Like and Unlike | GET    | Get like list and unlike list          |
|  14 | Like     | /api/like                | Resister like       | POST   | Register like(Include delete)          |
|  15 | Like     | /api/unlike              | Resister unlike     | POST   | Register unlike (Include delete)       |

### 3. Dockerize

1. Web server, Frontend, Backend, DB 관리용 Dockerfile, docker-compose(yaml)을 작성

   - Project docker-compose: [Link](https://github.com/Rick00Kim/Debate_project/blob/main/docker-compose.yml)
     - NGINX Config file: [Link](https://github.com/Rick00Kim/Debate_project/blob/main/server_config/debate_nginx.conf)
     - Dockerfile for Frontend : [Link](https://github.com/Rick00Kim/Debate_project/blob/main/frontend/Dockerfile)
     - Dockerfile for Backend: [Link](https://github.com/Rick00Kim/Debate_project/blob/main/backend/Dockerfile)
     - Dockerfile for MongoDB: [Link](https://github.com/Rick00Kim/Debate_project/blob/main/db/Dockerfile)

2. Automate Build and Deploy

   - github workflow 작성

   - docker repository 구축

## CONCLUSION

- Docker내 네트워크 설정에 대해 학습이 가능하였음
- React 모듈내 Responsive 디자인 학습이 가능하였음
- React 모듈내 Proxy관련 설정에 대한 학습이 가능하였음
- CI/CD관련
  - Github actions를 통한 Oracle Cloud Infrastruct 연계학습

## TODO

- [x] SP화면 수정(UX/UI관점 개선) \
       Issue URL: [issues-3](https://github.com/Rick00Kim/Debate_project/issues/3)
- [ ] Dockerize and automating Release \
      Pull request: [pull request-9](https://github.com/Rick00Kim/Debate_project/pull/9)
- [ ] 현재 Docker로 생성되어있는 모듈을 Microservice로의 Architecture 구상
- [ ] Microservice내 변경이 이루어진 모듈만 이행이 가능하도록 학습
