---
title: "Oracle Cloud Infrastructure를 시작하기전에"
date: 2020-12-26T10:00:23+09:00
lastmod: 2020-12-27T17:45:33+09:00

tags: ["Devops", "cloud-system"]
categories: ["Cloud"]
featuredImage: "oci-before.jpg"
featuredImagePreview: "oci-before.webp"
description: "Oracle cloud를 시작하기전 기본정보에 대해 기술"

toc:
  auto: false
---

<!--more-->

## BACKGROUND

🪄 [Oracle Cloud Infrastructure에 대해서](../oci-basics/) 참조

## GOAL

OCI의 기본정보에 대해 학습

- 동작환경
- 주요용어
- 요금정책

## CONTENTS

### 동작환경

1. OCI는 기본적으로 하이퍼바이저 없이 Bare Metal Host로 직접 실행된다
2. 다른 테넌트와 물리적 시스템을 공유하지 않음 (단일 테넌트 구조)

✨ Bare Metal host란: [Link](https://phoenixnap.com/blog/what-is-bare-metal-server)

### 주요용어

#### regions and availability domains

`region`: Data center가 Service되는 Server의 물리적 위치

![https://www.oracle.com/a/ocom/img/cc01-datacenter-regions.jpg](https://www.oracle.com/a/ocom/img/cc01-datacenter-regions.jpg)

✨ [OCI의 Region List](https://www.oracle.com/a/ocom/img/cc01-datacenter-regions.jpg)

#### realm

#### Console

#### tenancy

#### compartments

#### security zones

#### virtual cloud network (VCN)

#### instance

#### image

#### shape

#### key pair

#### block volume

#### Object Storage

#### bucket

#### Oracle Cloud Identifier (OCID)

## REFERENCES

1. [Key Concepts and Terminology](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)
2. http://cloud-docs.taewan.me/010.oci_intro/basic_concept/terminologies/
