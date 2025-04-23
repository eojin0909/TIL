
# 💻 AWS CLI 기반 EC2 + S3 연동 실습 요약

## 🎯 목표
- AWS CLI 사용법
- EC2 UserData를 통한 자동 설정
- EC2에서 S3 연동 자동화

## 🗂️ 실습 구성도
1. S3에 index.php 업로드
2. EC2 생성 시 UserData 스크립트 사용해 php/httpd 설치 및 S3에서 index.php 다운로드

### 📜 UserData 예시
```bash
#!/bin/bash
yum install httpd php -y
aws s3 cp s3://sgu-202500-s3/index.php /var/www/html --region ap-northeast-2
systemctl restart httpd
```

## 🧰 AWS CLI 주요 명령어
- `aws s3 ls`: 버킷 목록 보기
- `aws s3 cp 로컬 s3://...`: 업로드
- `aws s3 cp s3://... 로컬`: 다운로드
- `--recursive`: 폴더 업/다운로드
