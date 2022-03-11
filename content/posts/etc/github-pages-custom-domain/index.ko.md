---
title: "Github pages - 커스텀 도메인연동"
date: 2022-01-17T10:00:23+09:00

tags: ["Devops"]
categories: ["etc", "deploy", "tech"]
featuredImage: "github-pages-custom-domain.jpg"
featuredImagePreview: "github-pages-custom-domain.webp"
description: "Github pages에서 특정 도메인으로 호스팅 하는 방법을 기술"

toc:
  auto: false
---

<!--more-->

## BACKGROUND

- Github pages롤 통해 호스팅할 경우에 특정 도메인으로 연동하고 싶음

## GOAL

Github page 호스팅을 특정 도메인과 연동

## PRECONDITION

- 개인 구매한 도메인이 존재
- github pages를 사용중

## CONTENTS

#### 도메인설정

구매한 도메인내 아래 설정을 진행

1. A Record에 아래 IP Address를 추가

   | Type | Name |      Value      |
   | :--: | :--: | :-------------: |
   |  A   |  @   | 185.199.108.153 |
   |  A   |  @   | 185.199.109.153 |
   |  A   |  @   | 185.199.110.153 |
   |  A   |  @   | 185.199.111.153 |

2. CNAME에 [github pages 호스팅시 default 도메인]을 설정

   Example) `rick00kim.github.io`

#### Github repository 설정

Repository 루트폴더내 CNAME파일을 추가

이후 github pages로 호스팅 될시 루트폴더내 CNAME파일에 작성되어있는 도메인으로 연결이 됨

- 파일명: CNAME

- 파일내용

  ```text
  {구매한 도메인}
  ```

#### 도메인 연동 확인

1. 도메인 접속
2. dig command를 통한 통신확인
   ```bash
   # Example
   # dig {구매한 도메인}
   dig rick00kim.github.io
   ```

## REFERENCES

- https://hackernoon.com/how-to-set-up-godaddy-domain-with-github-pages-a9300366c7b

## TODO

- [ ] 실제 사용사례 업데이트 예정
