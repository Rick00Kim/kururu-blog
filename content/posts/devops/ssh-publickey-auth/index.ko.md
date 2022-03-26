---
title: "SSH Public key 인증방식 설정"
date: 2021-10-01T10:00:23+09:00

tags: ["Devops", "server", "TODO"]
categories: ["installation"]
featuredImage: "ssh-publickey-auth.jpg"
featuredImagePreview: "ssh-publickey-auth.webp"
description: "SSH 인증방식중에 Public Key인증방식의 설명, 설정방법"

toc:
  auto: false
---

<!--more-->

## GOAL

`Public Key 인증방식`의 동작과 설정방법을 기술

## PRECONDITION

[SSH 기본](../ssh-auth-basic/)

## CONTENT

### 동작

1. [동작 환경: `Server`]

   - (`.ssh/authorized_keys`내에 키 ID가 존재할 경우) 난수를 생성
   - Client로부터 접속요청받을때 생성한 Session key를 이용하여 생성한 난수를 암호화한 Message를 Client에게 전송 \
     ✨ Session key의 생성에 대해서: [ssh-인증의-기본동작](../ssh-auth-basic#ssh-인증의-기본동작) 내 3번

2. [동작 환경: `Client`]

   - Server로부터 전달받은 `암호화된 난수 message`를 복호화하여 Server에서 생성한 난수정보를 획득
   - 획득한 난수와 Session key를 결합한 값을 MD5 Hash로 생성한 후 Server에게 전송

3. [동작 환경: `Server`]

   - 1에서 생성했던 난수와 Session key를 결합한 값을 MD5 Hash로 생성
   - Client로부터 전달받은 `난수와 Session key를 결합한 값을 MD5 Hash값`이 서로 일치 하는지 확인
   - 일치할 경우 인증성공

> Public key 인증 설명
> {{< youtube dPAw4opzN9g standard >}}

### Public key 설정방법

(본 post는 기본 MacOS에서 진행함. Linux환경에서는 동작가능하지만 Windows에서는 동작하지 않을가능성이 높음)

- 접속대상 Server가 하나이상인 경우를 전제로 작성되어 있음
- Private key에 접근시 비밀번호(passphrase)는 설정하지않음 (보안상 설정하는것을 추천)
- 옵션에 대한 설명은 업데이트 예정

1. [동작 환경: `Client`]

   - ssh-keygen을 통한 Key pair 생성

     ```bash
     # 접속대상 Server의 Alias를 설정
     export TARGET_SERVER="{Server명}"

     # ssh-keygen 실행(Server이름별로 구분되도록 파일을 분기)
     ssh-keygen -t rsa -N "" -b 2048 -C "SSH Authorized key for ${TARGET_SERVER}" -f ~/.ssh/${TARGET_SERVER}_ssh_key

     # 생성 key pair 확인
     ls -ltr ~/.ssh/${TARGET_SERVER}*
     ```

2. Public key 확인

   ```bash
   # 출력된 Public key는 Copy
   cat ~/.ssh/${TARGET_SERVER}_ssh_key.pub
   ```

3. [동작 환경: `Server`]

   - 2번에서 Copy한 Public key를 `.ssh/authorized_keys`에 추가 \
     .ssh/authorized_keys가 존재하지 않을 경우에는 생성

     ```bash
     # Public key를 추가
     cat >> ~/.ssh/authorized_keys
     # 붙여넣기 후 [ctrl + d]

     # 추가 확인
     cat ~/.ssh/authorized_keys
     ```

4. [동작 환경: `Client`]

   - 접속 확인
     ```bash
     ssh -i ~/.ssh/${TARGET_SERVER}_ssh_key {User name}@{Server Host} [-p {Port}]
     ```

   여기까지 설정으로 Public key 인증방식에 대한 설정은 완료

{{< admonition tip >}}
✨ 추가설정(필수는 아님)

- ssh host 설정

  ssh 접속시 필요한 옵션등을 포함하는 alias를 `~/.ssh`내에 설정하여 보다 간단하게 ssh 접속을 가능하게 하기위함

1. config 수정 (존재하지 않을 경우 신규생성)

   ```bash
   # .ssh 내 config 수정
   chmod 666 ~/.ssh/config; vi ~/.ssh/config; chmod 440 ~/.ssh/config
   ```

2. Host 설정

   아래 `Template`를 이용하여 host설정

   ```
   Host Name1
       HostName [IP Address]
       User [Username]
       Port [Port Number]
       IdentityFile ~/.ssh/[private key name]
   ```

{{< /admonition >}}

## CONCLUSION

Public key 인증방식의 Flow이해와 설정방법을 통해 \
 CI/CD에서 특정 Server의 동작 실행 혹은 Monitoring도 보다 간결하게 진행가능

## TODO

1. Public key 인증방식의 이해를 보다 쉽게 하는 목적으로 Flow chart 작성도 고려
