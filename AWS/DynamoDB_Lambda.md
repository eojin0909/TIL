# DynamoDB + Lambda 실습 정리

## ✅ 실습 개요

- Lambda 함수가 실행될 때 DynamoDB 테이블에 데이터를 삽입
- API Gateway와 연동하여 외부 요청으로도 저장 가능

---

## ✅ 사용 테이블

- 테이블명: `sgu-202500-user-likes-time`
- 파티션 키: `user_id`
- 정렬 키: `timestamp`

---

## ✅ Lambda 예제 코드

```python
import boto3
import json
from datetime import datetime

def lambda_handler(event, context):
    body = json.loads(event['body'])  # API Gateway를 통해 JSON Body 전달받음
    user_id = body['user_id']
    product = body['product']
    timestamp = datetime.now().isoformat()

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202500-user-likes-time')

    item = {
        'user_id': user_id,
        'timestamp': timestamp,
        'product': product
    }

    table.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'success'})
    }
```

---

## ✅ 연결 순서 요약

1. **DynamoDB 테이블 생성** (`user_id`, `timestamp`)
2. **Lambda 함수 생성 및 IAM 권한 설정**
   - `AmazonDynamoDBFullAccess`
3. **API Gateway 연결 (선택 사항)**
   - POST 요청 → Lambda 트리거
   - `application/json` 본문 필요

---

## ✅ 테스트 이벤트 예시

```json
{
  "body": "{ \"user_id\": \"haeri01\", \"product\": \"에어팟\" }"
}
```