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

업데이트 예정

#### Console

OCI 내 Resource확인, 수정, 삭제, 추가등의 조작을 가능케하는 Web UI

#### tenancy

OCI에서 Cloud resources를 조작하는 OCI Account

#### compartments

OCI 내 존재하는 Resources의 집합(논리적 Container)

![OCI_Compartment](https://k21academy.com/wp-content/uploads/2018/03/OCI_Compartment.png)

#### security zones

업데이트 예정

#### virtual cloud network (VCN)

가상 Cloud Network

이하 Network 정보를 포함

- Subnet
- Routing cable
- Gateway

![VCN image](https://k21academy.com/wp-content/uploads/2018/03/20.png)

#### instance

OCI내에서 동작중인 Compute 인스턴스

#### image

Instance의 OS image

OCI에서 제공하는 기본 Image가 존재하며, Custom image 이용도 가능

✨ [OCI 제공 Image](https://docs.oracle.com/en-us/iaas/Content/Compute/References/images.htm#OracleProvided_Images)

#### shape

Instance의 CPU와 할당 Memory set

✨ [OCI 제공 Shape](https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#Compute_Shapes)

#### key pair

SSH 인증방식 중 비밀키/공개키

#### block volume

업데이트 예정

#### Object Storage

업데이트 예정

#### bucket

업데이트 예정

#### Oracle Cloud Identifier (OCID)

오라클 클라우드 식별자

OCI 내애 존재하는 모든 Object에 대한 고유 ID

## REFERENCES

1. [Key Concepts and Terminology](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)
2. http://cloud-docs.taewan.me/010.oci_intro/basic_concept/terminologies/
3. [Oracle Cloud Infrastructure (OCI) : Region, AD, FD, Tenancy, Compartment, VCN, IAM, Storage Service](https://k21academy.com/oracle-compute-cloud-services-iaas/oracle-cloud-infrastructure-oci-region-ad-tenancy-compartment-vcn-iam-storage-service/)
