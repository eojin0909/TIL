아래는 위에서 정리한 AWS 시험 대비 내용을 `.md` (Markdown) 형식으로 변환한 거야. 바로 복붙해서 GitHub, VS Code, Obsidian 등 어디서든 사용 가능해!

---

```markdown
# AWS 시험범위 요약 정리 (1~7주차 기준)

## ✅ 1장: 클라우드 컴퓨팅 이점 & 서비스 모델

### 📌 클라우드 컴퓨팅 이점
- **Agility (민첩성)**: 빠른 배포 및 실험 가능
- **Elasticity (탄력성)**: 수요 변화에 맞춰 자원 자동 조정
- **Cost Saving (비용 절감)**: 초기 비용 감소, 사용량 기반 과금
- **글로벌 서비스 가능**
- **트래픽 폭주 대응 가능**
- **빅데이터 & AI 확장성**

### 📌 클라우드 서비스 유형
| 구분 | 설명 | 예시 |
|------|------|------|
| IaaS | 인프라 제공 (서버, 스토리지, 네트워크, 가상화) | EC2, S3, VPC, EBS |
| PaaS | 앱 개발 플랫폼 제공 (운영체제, 미들웨어 포함) | Elastic Beanstalk |
| SaaS | 소프트웨어 제공, 설치 불필요 | Gmail, Salesforce |

---

## ✅ 2장: AWS 핵심 서비스 & 리전 개념

### 📌 컴퓨팅
- **EC2**: 가상 서버
- **Lambda**: 서버리스, 이벤트 기반 실행

### 📌 스토리지
- **S3**: 객체 스토리지
- **EBS**: 블록 스토리지

### 📌 네트워크
- **VPC**: 가상 네트워크
- **Route 53**: DNS 서비스
- **CloudFront**: CDN

### 📌 데이터베이스
- **RDS**: 관계형 DB
- **DynamoDB**: NoSQL 키-값 저장소

### 📌 보안
- **IAM**: 사용자/권한 제어
- **보안 그룹**: EC2 트래픽 제어

### 📌 리전 & AZ
- **Region**: 지리적 위치 단위
- **AZ (가용영역)**: 떨어진 물리적 DC 그룹

### 📌 글로벌 vs 지역 서비스
- **글로벌 서비스**: IAM, Route53, CloudFront
- **지역 서비스**: EC2, S3, RDS

---

## ✅ 3장: EC2 & CloudWatch

### 📌 EC2 명령어
```bash
sudo su -
yum install httpd -y
systemctl start httpd
cd /var/www/html/
vi index.html
```

### 📌 CloudWatch 경보
- CPUUtilization ≥ 30%
- SNS 이메일 경보
- NetworkOut ≥ 20000 → 고트래픽 알람

### 📌 부하 테스트
```bash
yum install -y stress-ng
stress-ng --cpu 1 --timeout 10m

iperf3 -s &
iperf3 -c 127.0.0.1 -t 600 -b 100M
```

---

## ✅ 4장: S3 기초 & 보안

### 📌 S3 특징
- 객체 스토리지, 내구성 99.999999999%
- 파일 접근 URL 제공
- 무제한 저장, 5TB까지 가능

### 📌 객체 구성
- **Bucket**: S3 저장 단위
- **Key**: 객체 이름
- **Value**: 데이터
- **Metadata, Version ID**

### 📌 S3 보안
- 기본: Private
- **Bucket Policy**: 리소스 기반
- **IAM Policy**: 사용자 기반
- **MFA**: 추가 보안
- 특정 IP 허용/차단, 다운로드 제한 가능

### 📌 버킷 정책 예시
```json
{
  "Effect": "Allow",
  "Principal": "*",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::demo.rwlecture.com/*"
}
```

---

## ✅ AWS CLI

### 📌 명령어 예시
```bash
aws s3 ls
aws s3 cp local.txt s3://my-bucket/
aws s3 cp s3://my-bucket/file.txt ./ --recursive
```

---

## ✅ Auto Scaling & ELB

### 📌 스케일링 개념
- **Scale Up**: 성능 향상
- **Scale Out**: 인스턴스 수 증가 (무중단 확장)

### 📌 Auto Scaling 구성 요소
- **Launch Template**: EC2 설정 템플릿
- **ASG (Auto Scaling Group)**: 인스턴스 묶음
- **Scaling Policy**
  - Target Tracking (ex. CPU 60%)
  - Step Scaling
  - Scheduled Scaling

### 📌 CloudWatch
- 지표 모니터링 → 스케일링 정책 트리거

### 📌 ELB 개요
- 트래픽 분산 서비스
- **ALB**: HTTP 기반, 경로 분기 가능
- **NLB**: TCP 기반, 고속 처리, 고정 IP
- **CLB**: 구버전

### 📌 타겟 그룹
- ALB에서 트래픽을 분산시킬 대상
- 헬스체크, 포트 별도 설정 가능

---

## 📌 시험 핵심 키워드
- 클라우드 이점, IaaS/PaaS/SaaS
- EC2, VPC, IAM, S3, CLI
- CloudWatch, Auto Scaling, ELB
- 정책(JSON), 버킷 정책, 실습 명령어

```

---
