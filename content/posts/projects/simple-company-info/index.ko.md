---
title: "회사소개 홈페이지 개발, 배포"
date: 2022-02-15T17:45:33+09:00

tags: ["Devops", "frontend", "projects"]
categories: ["private_projects"]
featuredImage: "simple-company-info.jpg"
featuredImagePreview: "simple-company-info.webp"
description: "오프라인 사업체의 간단한 회사, 상품소개 홈페이지 개발 및 서비스 구축"

toc:
  auto: false
---

<!--more-->

##### Project 진행 시기: 2022/01/15 - 2022/02/12

## BACKGROUND

오프라인으로 운영중인 사업체로부터 홈페이지 제작을 의뢰받음

## GOAL

기존 오프라인 사업체의 홈페이지 개발 및 배포를 통해 온라인 서비스를 오픈

## PROJECT FLOW

### 1. 요구사항 정의

Client로부터 받은 요구사항은 아래와 같음.

| No  | 항목명      | 설명                                                                                        | 비고                                            |
| --- | ----------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| 1   | 상품소개    | 판매상품별 카테고리를 분류하여 상품소개를 가능하도록 함                                     | 상품리스트가 정해져있으며, 변동될 가능성은 희박 |
| 2   | 회사문의    | 홈페이지에서 회사문의(견적의뢰, 기타문의)를 전화, 메일, 메신져로 가능하도록 함              | -                                               |
| 3   | 모바일버전  | 스마트폰 이용이 가능하도록 함                                                               | -                                               |
| 4   | 블로그 연동 | 홈페이지로부터 회사 블로그로 바로가기 기능을 넣고 싶음                                      | -                                               |
| 5   | 도메인 연결 | 회사측에서 [Godday](https://www.godaddy.com)를 통해 구매한 특정 도메인으로 연결을 하고 싶음 | -                                               |

#### 설계전 전제조건

1. 홈페이지의 주 목적은 `취급상품 및 회사소개`
2. 상품 리스트는 정해져 있으며, 이후 변동이 극히 적음
3. 많은 Traffic에 대한 고려는 불필요

### 2. 인프라설계

1. 서버(호스팅)

   `Github pages`를 통한 호스팅 방식을 채용
   {{< admonition question "Why?" >}}

   1. 여러 호스팅 사이트가 존재하나, 이용시 발생하는 비용을 고려할 필요없음
   2. 대량 Traffic에 대한 고려가 불필요하기때문에 소량 Trafiic에 대응 가능하며, 쉽게 호스팅할 수 있는 `Github pages`가 가장 적합하다고 판단

   {{< /admonition >}}

2. 데이터베이스

   없음
   {{< admonition question "Why?" >}}

   정적페이지 구축만으로 홈페이지를 작성하기때문에 데이터베이스 구축, 이용 및 관리가 필요없음

   {{< /admonition >}}

3. 언어 & 툴

   - 정적사이트 생성 Framework: [Hugo](https://gohugo.io/)
   - Text editor: [VSCode](https://code.visualstudio.com/)
   - Tools: [Github](https://github.com/), [Github pages](https://pages.github.com/), [Github actions](https://github.com/features/actions)

### 3. 프로젝트 설계 및 개발

#### 기본설계

홈페이지의 업데이트 빈도수가 드물기때문에 정적 사이트 제작

##### 디자인

Client와 의견을 조율한 결과, Hugo 템플릿중에서 아래 템플릿을 선정

{{< admonition info "템플릿관련 정보" >}}

- 템플릿 명: [hugo-universal-theme](https://themes.gohugo.io/themes/hugo-universal-theme/)

- 템플릿 라이센스 관련: [UNIVERSAL - BUSINESS & E-COMMERCE TEMPLATE](https://bootstrapious.com/p/universal-business-e-commerce-template)

{{< /admonition >}}

##### 화면설계

전체화면 list

1. Common
   : 화면공통
   : ⚡️ 종류: `메뉴바`, `body내 헤더`, `Footer`, `HTML header`
2. Index
   : 홈페이지 초기화면
   : ✨ Point: `회사어필문구`, `인기제품`, `각 카테고리별 리스트 바로가기`
3. Product list
   : 상품리스트 화면
   : ✨ Point: `상품 이미지`, `상품 요약`, `각 요소 클릭시 상품소개화면 링크설정`
4. Product information
   : 상품소개 화면
   : ✨ Point: `상품상세정보`, `상품문의 Form`
5. Company information
   : 회사소개 화면
   : ✨ Point: `회사대표 인사말`,`회사경영 Vision`
6. Company contact
   : 회사문의 화면
   : ✨ Point: `메신져 문의링크`, `이메일문의 Form`

#### 개발

Hugo및 템플릿 사용법은 아래 링크를 참조

{{< admonition tip>}}

👉 Hugo 기본사용법: [Hugo Documentation](https://gohugo.io/documentation/)

👉 템플릿 고유설정: [UNIVERSAL - BUSINESS & E-COMMERCE TEMPLATE](https://bootstrapious.com/p/universal-business-e-commerce-template)

{{< /admonition >}}

### 4. 테스트

아래 항목을 토대로 테스트 진행

{{< admonition note "Test항목" false>}}
| No | View | Check point | Result |
| --: | -- | -- | -- |
| 1 | Index | 접속시, 404에러가 일어나지 않는가? | ✅ Passed |
| 2 | Index | 회사어필문구에 오타가 없는가? | ✅ Passed |
| 3 | Index | 인기제품 Section에 오타가 없는가? | ✅ Passed |
| 4 | Index | 인기제품 Section내의 링크가 올바르게 설정되어 있는가? | ✅ Passed |
| 5 | Index | 카테고리 Section에 오타가 없는가? | ✅ Passed |
| 6 | Index | 카테고리 Section내의 링크가 올바르게 설정되어 있는가? | ✅ Passed |
| 7 | Product list | 접속시, 404에러가 일어나지 않는가? | ✅ Passed |
| 8 | Product list | 모든 요소가 표시되는가? | ✅ Passed |
| 9 | Product list | 각 요소(상품)별 이미지가 올바르게 표시되는가? | ✅ Passed |
| 10 | Product list | 각 요소(상품)별 요약가 올바르게 표시되는가? | ✅ Passed |
| 11 | Product list | 각 요소(상품)클릭시 해당 상품소개화면으로 이동하는가? | ✅ Passed |
| 12 | Product information | 접속시, 404에러가 일어나지 않는가? | ✅ Passed |
| 13 | Product information | 상품상세정보가 올바르게 표시되는가? | ✅ Passed |
| 14 | Product information | 상품문의 Form가 올바르게 표시되는가? | ✅ Passed |
| 15 | Product information | 상품문의 Form이 제대로 작동하는가? | ✅ Passed |
| 16 | Company information | 접속시, 404에러가 일어나지 않는가? | ✅ Passed |
| 17 | Company information | 회사대표 인사말, 회사경영 Vision이 올바르게 표시되는가? | ✅ Passed |
| 18 | Company contact | 접속시, 404에러가 일어나지 않는가? | ✅ Passed |
| 19 | Company contact | 오타가 없는가? | ✅ Passed |
| 20 | Company contact | 메신져 아이콘 클릭시 제대로 작동하는가? | ✅ Passed |
| 21 | Company contact | 이메일문의 Form가 올바르게 표시되는가? | ✅ Passed |
| 22 | Company contact | 이메일문의 Form이 제대로 작동하는가? | ✅ Passed |
| 23 | Common | 모든 화면내에서 Menu bar가 올바르게 표시되는가? | ✅ Passed |
| 24 | Common | 모든 화면내에서 Menu bar내 모든기능이 올바르게 작동하는가? | ✅ Passed |
| 25 | Common | 모든 화면내에서 Header가 올바르게 표시되는가? | ✅ Passed |
| 26 | Common | 모든 화면내에서 Footer가 올바르게 표시되는가? | ✅ Passed |
| 27 | Common | HTML Header에 회사와 관계없는 meta데이터등이 없는가? | ✅ Passed |
{{< /admonition >}}

### 5. 이행준비

#### 도메인 설정

Github pages에 커스텀 도메인 연동을 위해 아래 Post대로 설정 진행

🪄 [Gihub pages 커스텀 도메인 연동](../../etc/github-pages-custom-domain) 참조

#### Github acitons(workflow) 설정

Hugo Document내 Github pages 연동방법을 채용하여,
특정 브랜치상태 변경시 Gihub조작 없이 자동적용하도록 설정
: Github workflow 동작 브랜치: `main`

🪄 [Hugo github pages 연동](https://gohugo.io/hosting-and-deployment/hosting-on-github/) 참조

### 6. 이행

#### main 브랜치 merge

개발 진행시의 브랜치를 Github workflow 동작 브랜치 (`main`)로 Merge 진행

#### Naver 검색엔진에 홈페이지 도메인 추가

아래 외부 post를 참조

🪄 (외부) [네이버 사이트 등록하기 (네이버 검색노출)](https://imweb.me/faq?mode=view&category=29&category2=35&idx=7607)

## CONCLUSION

#### 🔆 결과물: [울산컨테이너](https://울산컨테이너.com)

- 홈페이지 이행은 성공, Client확인 완료

- 홈페이지의 전체 static 리소스의 용량이 큰 탓에 페이지 Rendering 속도가 느린 화면이 존재
  : Rendering performance에 대한 고려가 부족했음 -> 개선항목
