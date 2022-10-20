---
title: "외부 Instance를 kubernetes worker node로 설정"
date: 2022-06-24T10:00:23+09:00
lastmod: 2022-06-14T17:45:33+09:00

tags: ["Devops"]
categories: ["issues"]
featuredImage: "k8s-init-using-public-ip.jpg"
featuredImagePreview: "k8s-init-using-public-ip.webp"
description: "kubernetes worker node 설정시 발생 Issue를 정리"

toc:
  auto: false
---

<!--more-->

## BACKGROUND

Kubernetes(이하 k8s) 구축단계에서 외부 Instance를 워커노드로 설정

## ISSUE

다른 머신을 k8s worker node 설정에 실패

## CONTENT

### 작업내용

1. Master 노드에서 `kubeadm init`

   `kubeadm join` 가이드 Command 를 제시

2. Worker node 추가 Command(`kubeadm join`) 확인

   Command 내 IP 주소가 공인 IP가 아님

   -> 외부로부터 접속이 불가하다 판단

## CONCLUSION

[Stack overflow](https://stackoverflow.com/questions/61543832/kubeadm-init-join-using-public-ip)내 같은 Issue 확인

1. kubeadm init 옵션을 활용하여 외부접속을 통한 worker node 추가가 가능

   ```bash
   --control-plane-endpoint
   ```

## REFERENCES

> [Stack overflow](https://stackoverflow.com/questions/61543832/kubeadm-init-join-using-public-ip)
