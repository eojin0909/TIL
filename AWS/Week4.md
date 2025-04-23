
# 🔀 AWS ELB (Elastic Load Balancer) 요약

## 📌 ELB란?
- EC2 인스턴스 등 여러 대상에 트래픽을 자동 분산하는 서비스
- 고가용성, 자동 확장, 보안 제공
- 도메인 기반 접근 (IP 고정 불가)
- Health Check, Auto Scaling 연동 가능

## 🧩 ELB 종류
| 종류 | 설명 |
|------|------|
| ALB (Application) | 경로 기반 라우팅, HTTP/HTTPS |
| NLB (Network) | 고성능 TCP 트래픽, Elastic IP 지원 |
| Classic | 구형, 현재는 잘 사용하지 않음 |

## 🧰 ALB 구성
- 타겟 그룹: EC2/람다 등 분산 대상
- ALB → 타겟 그룹 → 헬스체크 통과 인스턴스로 트래픽 분산

## 🧪 실습 1: ALB 생성
1. 시작 템플릿 수정 (UserData에 httpd 설치 + 인스턴스 ID 출력)
2. 템플릿으로 EC2 생성
3. 타겟 그룹 생성 및 인스턴스 등록
4. ALB 생성 → 리스너 포트 80 → 타겟 그룹 연결

## 🧪 실습 2: 경로 기반 리디렉션
- ALB 리스너 규칙 설정
- /s3 경로 접근 시 S3 버킷의 index.html로 리디렉션
