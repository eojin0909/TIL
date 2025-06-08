# Lambda 2개 + DynamoDB 1개 생성 실습 정리

## ✅ DynamoDB 테이블 생성

### 테이블명: `sgu-202500-user-likes-time`

- **Partition Key**: `user_id` (String)
- **Sort Key**: `timestamp` (String, ISO 8601 형식 추천)
- **주의**: DynamoDB는 날짜 타입 없음 → 문자열로 처리

```json
{
  "user_id": "haeri01",
  "timestamp": "2025-06-08T10:00:00",
  "product": "갤럭시워치"
}
```

---

## ✅ Lambda 함수 1: S3 → DynamoDB 데이터 삽입

### 목적:
S3에 업로드된 JSON 파일을 읽어서 DynamoDB에 저장

### 권한:
- `AmazonS3ReadOnlyAccess`
- `AmazonDynamoDBFullAccess`

### 코드 예시:

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202500-user-likes-time')

    bucket_name = 'sgu-202500-3b'
    object_key = 'dynamo_data/user_likes_data.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        data_list = json.loads(content)

        for record in data_list:
            item = {
                'user_id': record.get('user_id'),
                'timestamp': datetime.now().isoformat(),
                'product': record.get('product')
            }
            table.put_item(Item=item)

        return { 'statusCode': 200, 'body': 'Inserted successfully' }

    except Exception as e:
        return { 'statusCode': 500, 'body': str(e) }
```

---

## ✅ Lambda 함수 2: CloudWatch 로그 → DynamoDB 저장

### 목적:
Lambda 함수 로그를 읽고 CloudWatch에서 메세지와 타임스탬프를 추출하여 저장

### 권한:
- `CloudWatchLogsReadOnlyAccess`
- `AmazonDynamoDBFullAccess`

### 코드 예시:

```python
import boto3
from datetime import datetime
import json

def lambda_handler(event, context):
    logs = boto3.client('logs')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202500-user-likes-time')

    log_group = '/aws/lambda/sgu-202500-lambda-s3'

    try:
        streams = logs.describe_log_streams(
            logGroupName=log_group,
            orderBy='LastEventTime',
            descending=True,
            limit=1
        )['logStreams']

        stream_name = streams[0]['logStreamName']

        events = logs.get_log_events(
            logGroupName=log_group,
            logStreamName=stream_name,
            limit=20,
            startFromHead=True
        )['events']

        for e in events:
            item = {
                'user_id': 'cloudwatch',
                'timestamp': datetime.fromtimestamp(e['timestamp'] / 1000).isoformat(),
                'product': e['message'].strip()
            }
            table.put_item(Item=item)

        return { 'statusCode': 200, 'body': 'CloudWatch logs inserted' }

    except Exception as e:
        return { 'statusCode': 500, 'body': str(e) }
```

---

## 📌 팁
- Lambda 제한 시간은 기본 3초 → 실패 시 10초로 변경
- API Gateway와 연동 가능 (POST 방식으로 DynamoDB 저장)
