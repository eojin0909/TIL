
# ☁️ AWS S3 요약 (이론 + 실습)

## 📌 S3란?
- AWS의 기본 객체 스토리지 서비스
- 99.999999999% 내구성, 거의 무제한 저장 가능
- 글로벌 서비스, 데이터는 특정 리전에 저장
- EC2와 함께 AWS에서 가장 널리 사용됨

---

## 📁 S3의 주요 개념

### ✅ 버킷과 객체
- **버킷**: S3의 논리적 저장 단위 (디렉터리 개념)
- **객체**: 저장된 데이터 (Key, Value, Metadata, Owner, VersionID 포함)
- 버킷 이름은 전 세계에서 고유해야 함

### ✅ 내구성과 가용성
- **내구성**: 데이터 손실 방지 → 11 9's (99.999999999%)
- **가용성**: 사용 가능성 → SLA 기준 99.9%

---

## 🗃️ 스토리지 클래스 요약

| 클래스 | 내구성 | 가용성 | 특징 |
|--------|--------|--------|------|
| Standard | 99.999999999% | 99.99% | 기본, 자주 사용하는 데이터 |
| Intelligent-Tiering | 99.999999999% | 99.99% | 자동으로 요금 최적화 |
| Standard-IA | 99.999999999% | 99.99% | 적게 접근, 30일 보관비 |
| One Zone-IA | 99.999999% | 99.95% | 단일 AZ, 저비용 |
| Glacier | 99.999999999% | 복원 후 99.99% | 장기 저장, 복원 필요 |
| Glacier Flexible | 99.999999999% | 복원 후 99.99% | 느린 복원, 백업용 |
| Glacier Deep Archive | 99.999999999% | 복원 후 99.99% | 법적 보관용 |
| S3 on Outposts | - | - | 온프레미스 스토리지 |

---

## 🔒 S3 보안

### 권한 종류
- **IAM 정책** (Identity-based)
- **버킷 정책** (Resource-based): JSON 형식

### 예시 정책
```json
{
  "Effect": "Allow",
  "Principal": "*",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::demo.rwlecture.com/*"
}
```

---

## 🧪 실습: 정적 웹 호스팅

### 1. index.html 생성 및 업로드
```html
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>S3 정적 웹사이트 실습</title></head>
<body>
  <h1>Amazon S3 정적 웹사이트 호스팅 실습</h1>
  <p>이 페이지는 S3 버킷에서 호스팅되고 있습니다.</p>
  <h2>업로드한 이미지:</h2>
  <img src="class/img/image.png" alt="S3 이미지">
</body>
</html>
```

### 2. 퍼블릭 엑세스 허용
- 버킷 → 권한 → 퍼블릭 엑세스 해제

### 3. 버킷 정책 설정 예시
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicWebsiteAllow",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::sgu-202500-s3/*"
  }]
}
```

### 4. 조건 설정 예시 (IP 제한)
```json
"Condition": {
  "IpAddress": {
    "aws:SourceIp": "123.123.123.123"
  }
}
```

### 5. 특정 폴더 다운로드 금지 예시
```json
{
  "Sid": "DenyGetObject",
  "Effect": "Deny",
  "Principal": "*",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::sgu-202500-s3-test/class/test/*"
}
```

---

## 🧪 실습 과제 예시
- security 폴더 생성
- 해당 폴더는 업로드 가능 / 다운로드 불가하도록 정책 설정

