---
title: "SSH 동작방식과 일부 인증방식 설정"
date: 2021-10-01T10:00:23+09:00

tags: ["Devops", "server", "TODO"]
categories: ["installation"]
featuredImage: "ssh-authentication.jpg"
featuredImagePreview: "ssh-authentication.webp"
description: "SSH 기본동작방식, 인증방식의 종류와 그중 Public Key인증방식에 필요한 기본설정방법을 제시"

toc:
  auto: false
---

<!--more-->

## GOAL

1. SSH 기본동작과 각 인증방식 이해
2. 일부 SSH 인증방식에 따른 설정방법을 확인

## SUMMARY

SSH(`Secure Shell`)란, Server에 접속할때 사용하는 Network 프로토콜 중 하나

{{< admonition tip >}}

1. 여기서 `Server`란 Web서버가 아닌 Linux 혹은 Unix 체제의 OS를 뜻함
2. Telnet또한 Network접속 프로토콜이지만 보통 사설Network에서 사용하며 보안성에 취약한 단점이 있다 \
   ✨ 참조: <https://www.guru99.com/telnet-vs-ssh.html>

{{< /admonition >}}

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
2. Server 확인 \
   Server의 공개키를 확인후, 공개키와 Server ID를 `~/.ssh/known_hosts`에 추가 \
   혹은 이미 작성된 Server ID가 `known_hosts`에 있는지 확인
3. Session 키 생성
   Server와 Client가 접속할때 사용할 Session 키를 생성
   - 생성 Session키는 대칭키
   - 해당 키는 데이터 전송시 암호화 혹은 복호화에 사용됨
   - Diffie-Hellman Algorithm 방식을 이용
4. Client에 대한 인증

   SSH 인증방식 종류

   1. Password Authentication \
      SSH 기본 인증방식, SSH 접속 User의 비밀번호를 통해 인증
   2. Public Key Authentication(`가장 많이 사용`) \
      Server와 Client간 Key pair(Private, Public)를 통해 보안성을 강화한 인증방식 (비대칭 암호화 알고리즘)
   3. Host based Authentication \
      동일한 User ID에 대한 접속을 전제로 **신뢰할수** 있는 Client의 Host를 Server에 설정, 제어하는 방식 \
      Key 등을 설정하지 않아도 인증이 가능하나, [Public key 인증방식]과 같이 사용하는것을 추천(보안성 증가 목적)
   4. Keyboard Authentication \
      Update 예정
   5. Challenge Responce Authentication \
      Update 예정
   6. GSSAPI Authentication \
      Update 예정

   > Key교환 Flow
   > {{< youtube U62S8SchxX4 standard >}}

5. 인증성공시, Client쪽에서 Session 요쳥 (SSH 통신 개시)

## PRECONDITION

- SSH 인증방식은 위에서 설명했듯이 여러 방법이 있지만, 본 post에서는 그중 가장 많이 사용하는 `Public Key 인증방식`의 동작과 설정방법에 대해 기술

## ABOUT PUBLIC KEY AUTHENTICATION

### Flow

1. [동작 환경: `Server`]

   - (`.ssh/authorized_keys`내에 키 ID가 존재할 경우) 난수를 생성
   - Client로부터 접속요청받을때 생성한 Session key를 이용하여 생성한 난수를 암호화한 Message를 Client에게 전송 \
     ✨ Session key의 생성에 대해서: [ssh-인증의-기본동작](#ssh-인증의-기본동작) 내 3번

2. [동작 환경: `Client`]

   - Server로부터 전달받은 `암호화된 난수 message`를 복호화하여 Server에서 생성한 난수정보를 획득
   - 획득한 난수와 Session key를 결합한 값을 MD5 Hash로 생성한 후 Server에게 전송

3. [동작 환경: `Server`]

   - 1에서 생성했던 난수와 Session key를 결합한 값을 MD5 Hash로 생성
   - Client로부터 전달받은 `난수와 Session key를 결합한 값을 MD5 Hash값`이 서로 일치 하는지 확인
   - 일치할 경우 인증성공

> Public key 인증 설명
> {{< youtube dPAw4opzN9g standard >}}

### How to generate key pair and setting?

- (본 post는 기본 MacOS에서 진행함.
- Linux환경에서는 동작가능하지만 Windows에서는 동작하지 않을가능성이 높음)
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
   chmod 666 ~/.ssh/config; vi ~/.ssh/config;chmod 440 ~/.ssh/config
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

## CONCLUSION

1. SSH의 기본 동작 Flow를 이해
2. 여러 인증방식중 흔히 사용하는 Public key 인증방식의 Flow이해와 설정방법을 통해 \
   CI/CD에서 특정 Server의 동작 실행 혹은 Monitoring도 보다 간결하게 진행가능

## TODO

1. SSH 통신이 필요한 다양한 상황에서 보다 적절한 선택을 가능하게 하기위해 다른 인증방식에 대한 내용과 설정방법을 파악할 필요가 있음
2. SSH command내 주로 사용하는 Options를 정리
3. Public key 인증방식의 이해를 보다 쉽게 하는 목적으로 Flow chart 작성도 고려 (Not Mandatory)
