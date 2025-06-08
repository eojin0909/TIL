# ELB + Lambda + S3 실습 정리

## 1. ELB(Elastic Load Balancer) 개요

- 트래픽을 EC2, Lambda 등으로 자동 분산
- Health Check 기능 제공
- 도메인 기반 접속 필수

### 종류

- **Application Load Balancer (ALB)**: 경로 기반 라우팅
- **Network Load Balancer (NLB)**: TCP 기반, 고성능
- **Classic Load Balancer**: 구버전

## 2. 실습 흐름 요약

### ALB 구성

1. 시작 템플릿 수정 → EC2 자동 실행
2. 타겟 그룹 생성
3. ALB 생성 → 리스너 규칙 설정

### ALB + Lambda 연결

- ALB 리스너에서 /lambda 경로로 요청 → Lambda 함수 호출

```python
# 예시 Lambda 코드
def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "headers": { "Content-Type": "application/json" },
        "body": '{"message": "Hello Lambda"}'
    }
```

### ALB + Lambda + S3 연결

- /upload 경로에서 S3로 파일 업로드

```python
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    filename = f'uploaded/hello_{now}.txt'
    content = f'Hello Haeri! This file was created at {now}'
    s3.put_object(Bucket='sgu-202500-3b', Key=filename, Body=content.encode('utf-8'))
    return {
        "statusCode": 200,
        "headers": { "Content-Type": "application/json" },
        "body": '{"message": "업로드 완료"}'
    }
```