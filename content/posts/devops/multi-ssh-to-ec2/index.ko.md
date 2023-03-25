---
title: "AWS Autoscaling 인스턴스 동시접속"
date: 2023-02-27T17:00:59+09:00

tags: ["Devops", "server"]
categories: ["installation"]
featuredImage: "multi-ssh-to-ec2.jpg"
featuredImagePreview: "multi-ssh-to-ec2.webp"
description: "AWS 내 Autoscaling 이용시, 모든 인스턴스내에 SSH 접속하는 방법과 스크립트를 제시"

toc:
  auto: false
---

<!--more-->

## BACKGROUD

1. AWS Autoscaling 을 통해 1개 이상의 Instance를 이용중
2. 동작중인 모든 Instance 내부확인이 필요한 상황

## PRECONDITION

1. 각 Instance는 제각각 Public IP를 가짐
2. 각 Instance는 동일한 Key pair 를 가짐

## GOAL

- Terminal(iTerm2) 를 통한 동적으로 변하는 EC2 정보를 받아와, 동시 SSH 접속을 가능케 함

## PREPARE

1. itermoxyl 설치

   > Reference: https://github.com/luciopaiva/itermoxyl

2. 최신 Bash 설치
   : 4버전 이상

## SUMMARY

- 스크립트 설명
  {{< gist Rick00Kim 249303647ce0c6bac217c0159ba8cacb >}}

- 스크립트 이용법
  ```bash
  ./multi-ssh.sh {api_name} {environment(Optional)}
  ```

## TODO

- [ ] Create Initializer
- [ ] Add Validation
