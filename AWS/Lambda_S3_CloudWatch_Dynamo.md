# Lambda + S3 + CloudWatch + DynamoDB 정리

## ✅ 목적

- **S3**에 저장된 데이터를 **Lambda**로 처리하여 **DynamoDB**에 저장
- 또는 **CloudWatch** 로그에서 이벤트를 추출하여 DynamoDB에 저장

---

## ✅ Lambda + S3 → DynamoDB

### 구조

1. S3에 JSON 파일 업로드
2. Lambda가 해당 JSON을 읽음
3. 데이터를 필터링 및 파싱하여 DynamoDB에 저장

```python
# 핵심 처리 흐름
response = s3.get_object(Bucket=bucket, Key=key)
content = response['Body'].read().decode('utf-8')
data = json.loads(content)

for record in data:
    table.put_item(Item={
        'user_id': record['user_id'],
        'timestamp': datetime.now().isoformat(),
        'product': record['product']
    })
```

---

## ✅ Lambda + CloudWatch → DynamoDB

### 구조

1. 로그 그룹 내 최근 스트림 조회
2. 로그 이벤트 추출
3. 각 이벤트를 DynamoDB에 저장

```python
streams = logs.describe_log_streams(...)
events = logs.get_log_events(...)

for e in events:
    table.put_item(Item={
        'user_id': 'cloudwatch',
        'timestamp': datetime.fromtimestamp(e['timestamp'] / 1000).isoformat(),
        'product': e['message'].strip()
    })
```

---

## ✅ 팁

- Lambda는 timeout 설정 중요 (기본 3초 → 10초로 설정 가능)
- IAM 역할에 `S3`, `DynamoDB`, `CloudWatchLogs` 권한 부여 필요