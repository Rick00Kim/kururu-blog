---
title: "SSH 동작방식(기본)"
date: 2021-10-01T10:00:23+09:00

tags: ["Devops", "server", "TODO"]
categories: ["installation"]
featuredImage: "ssh-auth-basic.jpg"
featuredImagePreview: "ssh-auth-basic.webp"
description: "SSH 기본동작방식 설명"

toc:
  auto: false
---

<!--more-->

## GOAL

SSH 기본동작과 각 인증방식 이해

## SUMMARY

SSH(`Secure Shell`)란, Server에 접속할때 사용하는 Network 프로토콜 중 하나

{{< admonition tip >}}

1. 여기서 `Server`란 Web서버가 아닌 Linux 혹은 Unix 체제의 OS를 뜻함
2. Telnet또한 Network접속 프로토콜이지만 보통 사설Network에서 사용하며 보안성에 취약한 단점이 있다 \
   ✨ 참조: <https://www.guru99.com/telnet-vs-ssh.html>

{{< /admonition >}}

## CONTENT

### SSH 인증의 기본동작

> REFERENCES \
> <https://www.golinuxcloud.com/openssh-authentication-methods-sshd-config/> \
> <https://info.support.huawei.com/info-finder/encyclopedia/en/SSH.html> \
> <https://medium.com/@Magical_Mudit/understanding-ssh-workflow-66a0e8d4bf65>

1. Client로부터 Server에 대한 접속 요청

   ```bash
   # SSH command
   # SSH 접속 Port는 기본 22이지만, 특정 Port를 지정해 sshd(SSH Daemon)을 실행중인 Server인 경우
   #    [-p]옵션을 통해 특정 Port를 지정할수 있다
   ssh {User name}@{Server Host} [-p {Port}]
   ```

2. Server 확인

   Server의 공개키를 확인후, 공개키와 Server ID를 `~/.ssh/known_hosts`에 추가 \
   혹은 이미 작성된 Server ID가 `known_hosts`에 있는지 확인

3. Session 키 생성

   Server와 Client가 접속할때 사용할 Session 키를 생성

   - 생성 Session키는 대칭키
   - 해당 키는 데이터 전송시 암호화 혹은 복호화에 사용됨
   - Diffie-Hellman Algorithm 방식을 이용

4. Client에 대한 인증

   SSH 인증방식 종류

   1. Password Authentication

      SSH 기본 인증방식, SSH 접속 User의 비밀번호를 통해 인증

   2. Public Key Authentication(`가장 많이 사용`)

      Server와 Client간 Key pair(Private, Public)를 통해 보안성을 강화한 인증방식 (비대칭 암호화 알고리즘)

   3. Host based Authentication

      동일한 User ID에 대한 접속을 전제로 **신뢰할수** 있는 Client의 Host를 Server에 설정, 제어하는 방식 \
      Key 등을 설정하지 않아도 인증이 가능하나, [Public key 인증방식]과 같이 사용하는것을 추천(보안성 증가 목적)

   4. Keyboard Authentication

      Update 예정

   5. Challenge Responce Authentication

      Update 예정

   6. GSSAPI Authentication

      Update 예정

   > Key교환 Flow
   > {{< youtube U62S8SchxX4 standard >}}

5. 인증성공시, Client쪽에서 Session 요쳥 (SSH 통신 개시)

{{< admonition tip "ssh관련 설정파일의 필수 혹은 권장 permission" false >}}

> Reference: <https://superuser.com/a/1559867>

```
+------------------------+-------------------------------------+-------------+-------------+
| Directory or File      | Man Page                            | Recommended | Mandatory   |
|                        |                                     | Permissions | Permissions |
+------------------------+-------------------------------------+-------------+-------------+
| ~/.ssh/                | There is no general requirement to  | 700         |             |
|                        | keep the entire contents of this    |             |             |
|                        | directory secret, but the           |             |             |
|                        | recommended permissions are         |             |             |
|                        | read/write/execute for the user,    |             |             |
|                        | and not accessible by others.       |             |             |
+------------------------+-------------------------------------+-------------+-------------+
| ~/.ssh/authorized_keys | This file is not highly sensitive,  | 600         |             |
|                        | but the recommended permissions are |             |             |
|                        | read/write for the user, and not    |             |             |
|                        | accessible by others                |             |             |
+------------------------+-------------------------------------+-------------+-------------+
| ~/.ssh/config          | Because of the potential for abuse, |             | 600         |
|                        | this file must have strict          |             |             |
|                        | permissions: read/write for the     |             |             |
|                        | user, and not accessible by others. |             |             |
|                        | It may be group-writable provided   |             |             |
|                        | that the group in question contains |             |             |
|                        | only the user.                      |             |             |
+------------------------+-------------------------------------+-------------+-------------+
| ~/.ssh/identity        | These files contain sensitive data  |             | 600         |
| ~/.ssh/id_dsa          | and should be readable by the user  |             |             |
| ~/.ssh/id_rsa          | but not accessible by others        |             |             |
|                        | (read/write/execute)                |             |             |
+------------------------+-------------------------------------+-------------+-------------+
| ~/.ssh/identity.pub    | Contains the public key for         | 644         |             |
| ~/.ssh/id_dsa.pub      | authentication.  These files are    |             |             |
| ~/.ssh/id_rsa.pub      | not sensitive and can (but need     |             |             |
|                        | not) be readable by anyone.         |             |             |
+------------------------+-------------------------------------+-------------+-------------+
```

{{< /admonition >}}

## AFTER

1. Public Key 인증방식에 대해서
   : -> [Link](../ssh-publickey-auth/)

## CONCLUSION

1. SSH의 기본 동작 Flow를 이해

## TODO

1. SSH 통신이 필요한 다양한 상황에서 보다 적절한 선택을 가능하게 하기위해 다른 인증방식에 대한 내용과 설정방법을 파악할 필요가 있음
2. SSH command내 주로 사용하는 Options 설명 추가
