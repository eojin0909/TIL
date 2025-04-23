
# 🧱 AWS 아키텍처 및 핵심 개념 요약

## 1️⃣ AWS 핵심 서비스 개요

### 🖥️ 컴퓨팅 서비스
- **EC2**: 가상 서버 제공 (온디맨드 / 스팟 인스턴스)
- **Lambda**: 서버리스 컴퓨팅, 이벤트 기반 실행

### 💾 스토리지 서비스
- **S3**: 객체 스토리지, 정적 웹 호스팅 가능
- **EBS**: EC2 인스턴스를 위한 블록 스토리지

### 🌐 네트워크 및 콘텐츠 전송
- **VPC**: 가상 네트워크 구성
- **Route 53**: DNS 서비스
- **CloudFront**: CDN 서비스

### 🗃️ 데이터베이스
- **RDS**: 관리형 관계형 DB (MySQL, PostgreSQL 등)
- **DynamoDB**: NoSQL 키-값 저장소

### 🔐 보안 및 접근관리
- **IAM**: 사용자 및 권한 관리
- **Security Group**: 트래픽 제어

---

## 2️⃣ AWS 구조 및 구성요소

### 🌍 리전 (Region)
- 물리적 서버 위치, 고유 코드 존재 (ex: 서울 → `ap-northeast-2`)
- 리전마다 서비스 이용 가능 여부 상이

### 🏢 가용영역 (Availability Zone, AZ)
- 하나의 리전에 2개 이상의 AZ 존재
- 물리적으로 떨어진 위치에 데이터 센터 구성

### 📦 엣지 로케이션 (Edge Location)
- CloudFront 등의 빠른 전송 및 캐싱을 위한 거점
- 전 세계 다수 존재

---

## 3️⃣ 서비스 유형

| 구분       | 설명                                                | 예시                     |
|------------|-----------------------------------------------------|--------------------------|
| 글로벌 서비스 | 전 세계에서 동일하게 사용되는 서비스                    | IAM, Route53, Billing 등 |
| 지역 서비스   | 특정 리전 기반에서만 작동                            | EC2, S3, RDS 등 대부분 서비스 |

---

## 4️⃣ VPC 구조 및 구성요소

### 🔧 구성 요소
- **subnet**: IP 범위 분할
- **Route Table**: 트래픽 경로 지정
- **Internet Gateway**: 인터넷과 연결
- **NAT Gateway**: 프라이빗 서브넷에서 외부와 통신
- **VPC Endpoint**: AWS 서비스와의 내부 연결

---

## 5️⃣ IAM (Identity and Access Management)

### 📋 IAM 구성 요소
- **User**: AWS 접근 주체
- **Group**: 사용자 그룹
- **Role**: 권한 위임용 임시 역할
- **Policy**: JSON 기반 접근 규칙
- **MFA**: 다중 인증

### ⚙️ 주요 기능
- 사용자별 접근 권한 제어 (EC2, S3 등)
- 정책 기반 세부 권한 제어
- 서비스 역할 간 권한 위임
- MFA 로그인 보안 강화

### ⚠️ 주의사항
- root 계정 최소 사용
- 최소 권한 원칙 준수
- 액세스 키 노출 금지
- 정책 설정 오류 = 보안 위험

---

## ⚠️ 실화 사례 요약

- AWS 계정 해킹 → EC2 인스턴스 무단 생성 → 비트코인 채굴
- 청구액 약 **3억원**
- AWS 측 감액 → 최종 **6400만원 청구**
- 개발자 오열 사례로 주의 강조됨

[🔗 관련 링크](https://www.teamblind.com/kr/post/AWS-%ED%95%B4%ED%82%B9%EC%9C%BC%EB%A1%9C-3%EC%96%B5%EC%B2%AD%EA%B5%AC%EB%8B%B9%ED%95%9C-%EA%B0%9C%EB%B0%9C%EC%9E%90%E3%84%B7%EC%9B%83%EB%8C%80%ED%8E%8C-YWUVxh3b)

---


# 🚀 AWS EC2 실습 요약

## 📌 EC2 개요
- **EC2 (Elastic Compute Cloud)**: AWS에서 제공하는 가상 서버
- 인스턴스: EC2에서 생성된 서버 개체
- 상태: `running`, `stopped`, `terminated`, `pending`, `stopping`, `rebooting`, `shutting-down`

---

## 🛠️ EC2 생성 절차
1. AWS 콘솔 접속 → EC2 → 인스턴스 시작
2. 이름 지정: 예) `sgu-202500-ec2test`
3. 이미지: `Amazon Linux 2 AMI`
4. 인스턴스 유형: `t3.nano`
5. 키페어 생성 및 .pem 파일 저장 (메일 전송 필수)
6. 보안 그룹 설정 후 인스턴스 시작

---

## 🔐 키페어 및 접속
- **PEM**: Linux/macOS용
- **PPK**: Windows PuTTY용 변환 필요
- Puttygen으로 `.pem` → `.ppk` 변환
- 접속: IP 주소 + `ec2-user` + `.ppk` 키

---

## ⚙️ 보안 그룹 설정
- 인바운드 규칙 수정 (ex. ICMP, HTTP 허용)
- 실습: HTTP 추가, 내 IP 허용

---

## 🧪 EC2 실습 요약
- **인스턴스 유형 변경**: 중지 후 `t3.nano` → `t3.micro`
- **삭제 및 재생성**: 태그 포함 설정 (예: key: class / value: class-3a)
- **웹서버 설치**: 
  ```bash
  sudo su -
  yum install httpd -y
  systemctl start httpd
  vi /var/www/html/index.html
  ```

---

## 📈 EC2 모니터링

### CloudWatch 설정
- 모니터링 탭 → 새 대시보드 생성 및 저장
- **지표 선택**: CPUUtilization
- 임계값 설정: `>30%`, 기간: `1분`
- 이메일 알림 설정 후 구독 승인

### 부하 테스트
- CPU 부하: `stress-ng --cpu 1 --timeout 10m --metrics --times`
- 네트워크 부하: `iperf3` 설치 후 내부 네트워크 부하 테스트
- CloudWatch 경보: `NetworkOut >= 20000` → `High_Network_Alarm` 생성

---


