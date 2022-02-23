---
title: "생각공유 웹 서비스"
date: 2022-01-15T10:00:23+09:00
lastmod: 2021-09-14T17:45:33+09:00

draft: true

tags: ["Devops", "Backend", "Frontend", "projects"]
categories: ["private_projects"]
featuredImage: "debate-project.jpg"
featuredImagePreview: "debate-project.webp"
description: "Description"

toc:
  auto: false
---

<!--more-->

##### Project 진행 시기: 2021/11/10 - 2022/01/03

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

   🪄 구축 및 관리방법은 [Gihub pages 커스텀 도메인 연동](../../cloud/oci-basics) 참조

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

### 2. Design

#### 기본설계



## CONCLUSION

## TODO

## REFERENCES
