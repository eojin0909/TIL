# 📘 종합 시험 대비 요약 (설명 포함)

## 🧱 1. Git 기본
- **Git이란?**  
  소스 코드의 변경 이력을 관리하는 **분산 버전 관리 시스템(DVCS)**.  
  여러 개발자가 동시에 작업해도 충돌 없이 코드 이력을 추적할 수 있음.  
- **사용 방식**  
  CLI(명령어 기반) / GUI(그래픽 툴, 예: SourceTree, GitHub Desktop)  
- **시험 포인트**  
  Git의 “설치법”은 시험에 나오지 않음 ❌  
  사용법과 계정 설정(`git config`)은 출제됨 ✅

---

## 🧩 2. Git 초급
- **Git의 3단계 구조**
  1. Working Directory – 실제 작업하는 폴더  
  2. Staging Area – `git add`로 커밋 준비  
  3. Repository – `git commit`으로 기록 저장  

- **파일 생명주기**  
  Untracked → Modified → Staged → Committed  

- **reset / revert 차이**
  | 명령어 | 설명 |
  |--------|------|
  | reset | 특정 시점으로 되돌림 (기록 삭제 가능) |
  | revert | 되돌리는 새 커밋 생성 (기록 유지) |

- **reset 옵션**
  | 옵션 | 특징 |
  |------|------|
  | `--soft` | 커밋만 취소 |
  | `--mixed` | add 전 상태로 |
  | `--hard` | 완전히 삭제 |

- **계정 초기화**
  ```bash
  git config --global --unset user.name
  git config --global --unset user.email
  ```

---

## 🌿 3. Git 중급 (Branch)
- **Branch란?**  
  코드의 여러 버전을 나누어 동시에 개발할 수 있게 하는 “가지” 구조.

- **주요 명령어**
  ```bash
  git branch           # 목록 보기
  git switch -c dev    # 브랜치 생성 + 이동
  git branch -m old new # 이름 변경
  git branch -d temp    # 브랜치 삭제
  ```

- **merge vs rebase**
  | 구분 | merge | rebase |
  |------|--------|---------|
  | 기능 | 브랜치 합침 | 커밋 기반 재정렬 |
  | 이력 | 병합 커밋 남음 | 선형 이력 유지 |
  | 충돌 복구 | `git merge --abort` | `git rebase --abort` |

---

## ☁️ 4. GitHub / Git 고급
- **GitHub란?**  
  Git 저장소를 온라인에서 관리하고 협업할 수 있는 플랫폼.

- **원격 저장소 등록**
  ```bash
  git remote add origin <URL>
  git branch -M main
  ```

- **Push / Pull**
  - `git push origin main` → 로컬 → 원격
  - `git pull origin main` → 원격 → 로컬  

- **기타 포인트**
  - 협업 push 실습 있음  
  - Slack 연동은 시험 제외 ❌  

---

## 🌐 5. 네트워크
- **IP 주소**
  네트워크 상의 장치를 구분하기 위한 고유 번호 (IPv4: 32bit, IPv6: 128bit)

- **사설 IP 대역**
  | 클래스 | 범위 | 마스크 |
  |:--:|:--:|:--:|
  | A | 10.0.0.0~10.255.255.255 | /8 |
  | B | 172.16.0.0~172.31.255.255 | /16 |
  | C | 192.168.0.0~192.168.255.255 | /24 |

- **Network ID 계산**
  → IP 주소와 서브넷 마스크를 AND 연산  
  예: `192.168.25.38/24` → Network ID = `192.168.25.0`

- **브로드캐스트 주소**
  → 호스트 비트를 전부 1로 변경  
  예: `192.168.25.0/24` → Broadcast = `192.168.25.255`

- **문제 풀이**
  - 문제1: `172.22.65.33` → **172.22.0.0**
  - 문제3: `/22 → 255.255.252.0` → **Network: 191.168.24.0, Broadcast: 191.168.27.255**
  - 문제4: `/22, /23` 단위 계산 숙지  

---

## 🗄️ 6. AWS RDS
- **RDS란?**  
  AWS의 완전 관리형 관계형 DB 서비스 (자동 백업, 확장, 패치 관리).

- **Aurora 핵심**
  - MySQL/PostgreSQL 호환
  - 6중 복제 (3AZ × 2개 복제본)
  - 스토리지 단위 10GB 세그먼트로 자동 관리
  - 내결함성(Fault Tolerance) 우수

- **Quorum 구조**
  - 쓰기: 6개 중 4개 성공 시 완료  
  - 읽기: 6개 중 3개 성공 시 완료  

- **Single vs Multi-Master**
  | 구분 | Single | Multi |
  |------|---------|--------|
  | Writer | 1개 | 최대 4개 |
  | 장애조치 | 수동 승격 | 자동 Failover |
  | 용도 | 일반 서비스 | 대규모/금융 서비스 |

- **기능 요약**
  - **Copy-on-Write(Cloning)**: 변경된 블록만 복제 → 빠름  
  - **Backtrack**: 시점 복원  
  - **Sharding**: 대규모 분산 저장  
  - **Global DB**: 리전 간 복제 (RPO<1초, RTO<1분)

---

## 🧪 7. RDS 실습
- **세 가지 엔드포인트**
  | 주소 | 용도 |
  |------|------|
  | cluster | Writer (쓰기 전용) |
  | cluster-ro | Reader (읽기 전용) |
  | instance-1 | 관리용 |

- **실습 포인트**
  - Reader 추가 시 자동 복제  
  - Failover 시 Reader → Writer 승격  
  - Snapshot 생성 후 복원  

---

## ✅ 8. 최종 체크리스트
| 과목 | 핵심 포인트 |
|------|--------------|
| Git | reset 3옵션, revert 차이 |
| Git 중급 | branch 명령, merge vs rebase |
| GitHub | 원격 연결, push/pull 명령 |
| 네트워크 | CIDR, /22·/23 계산 |
| RDS | Aurora 구조, Quorum, MultiMaster |
| RDS 실습 | 엔드포인트, Failover, Snapshot |

---

📄 **참고:**  
이 내용은 “종합_시험대비_요약본_명조체.pdf”에도 동일하게 포함되어 있으며,  
PDF는 인쇄용 명조체로 제작되어 한글이 깨지지 않습니다.
