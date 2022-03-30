---
title: "[Issues] Oracle Cloud Infrastructure의 Compute instance 생성 실패"
date: 2022-03-14T11:00:23+09:00
lastmod: 2022-03-14T17:45:33+09:00

tags: ["Devops", "cloud-system", "TODO"]
categories: ["installation", "issues"]
featuredImage: "oci-core-out-of-capacity.jpg"
description: "Oracle Cloud Infrastructure 내 특정 컴포넌트 생성시, [Out of host capacity]에러가 발생"

toc:
  auto: false
---

<!--more-->

## BACKGROUND

아래와 같은 목적으로 Oracle Cloud Infrastructure(이하 `OCI`)내 가상머신을 생성, 이용할 계획

1. 모니터링 이용
2. 웹 어플리케이션 구동

## PRECONDITION

Terraform을 이용해 OCI 가상머신 생성

## ISSUE

OCI내 Compute instance 생성시 에러가 발생

## CONTENT

### Log

```text
Error: 500-InternalError
Provider version: 4.69.0, released on 2022-03-23.
Service: Core Instance
Error Message: Out of host capacity.
OPC request ID: 2bc26f2c0c61f3754936ef581f58ae81/996BF8A4E4FC65931431F31CBB5BFB9A/3ED1086824720418C6F2E93BC5438CDB
Suggestion: The service for this resource encountered an error. Please contact support for help with service: Core Instance

  with oci_core_instance.ubuntu_instance,
  on instance.tf line 10, in resource "oci_core_instance" "ubuntu_instance":
  10: resource "oci_core_instance" "ubuntu_instance" {
```

## CONCLUSION

[Issue정리](https://github.com/Rick00Kim/infra-tools/issues/3)

## REFERENCES

> 1. https://www.reddit.com/r/oraclecloud/comments/suwhns/out_of_capacity/
> 2. https://bestofphp.com/repo/hitrov-oci-arm-host-capacity
> 3. https://www.reddit.com/r/oraclecloud/comments/on2e25/resolving_oracle_cloud_out_of_capacity_issue_and/
