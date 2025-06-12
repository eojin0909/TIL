# 📘 AWS Lambda 함수 정리 - 기말고사 대비 (코드 포함)

기말고사에 사용할 모든 Lambda 함수의 코드와 설명을 정리한 문서입니다.

---

## ✅ 기본 Lambda 함수 (Hello 메시지 반환)
**함수명:** `sgu-202567-Lambda`  
**설명:** 간단한 "Hello Lambda" 메시지를 반환하는 테스트용 함수입니다.

```python
import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        "statusDescription":"200 OK",
        "isBase64Encoded" : False,
        "headers": {
            "Content-Type":"application/json"
        },
        'body': '{"message":"Hello Lambda"}'
    }
```

---

## 🪣 S3에 텍스트 업로드
**함수명:** `sgu-202567-lambda2`  
**설명:** 현재 시간을 포함한 텍스트 파일을 S3 버킷에 업로드합니다.

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket_name = 'sgu-202567-s3'
    prefix = 'uploaded/'

    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    filename = f'{prefix}hello_{now}.txt'
    content = f'Hello Haeri! This file was created at {now}'

    s3.put_object(
        Bucket=bucket_name,
        Key=filename,
        Body=content.encode('utf-8')
    )

    return {
        "statusCode": 200,
        "statusDescription": "200 OK",
        "isBase64Encoded": False,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": '{"message": "업로드 완료"}'
    }
```

---

## 🧾 DynamoDB에 항목 저장
**함수명:** `sgu-202567-dynamo`

```python
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202567-user-likes')

    response = table.put_item(
        Item={
            'user_id': 'jihoon07',
            'product_name': '제로콜라'
        }
    )

    return {
        'statusCode': 200,
        'body': 'PutItem successful!'
    }
```

---

## 🔍 EC2 상태 확인 및 알림 + LambdaB 호출 (LambdaA)
**함수명:** `sgu-202567-LambdaA`

```python
import boto3
import json

ec2 = boto3.client('ec2')
sns = boto3.client('sns')
lambda_client = boto3.client('lambda')

INSTANCE_ID = 'i-06b650f8b77158f7c'
SNS_TOPIC_ARN = 'arn:aws:sns:ap-northeast-2:443370697536:sgu-202567-MyTopic'

def lambda_handler(event, context):
    response = ec2.describe_instance_status(InstanceIds=[INSTANCE_ID])
    statuses = response.get('InstanceStatuses', [])

    if not statuses or statuses[0]['InstanceState']['Name'] != 'running':
        message = f"경고: EC2 인스턴스 {INSTANCE_ID} 상태가 'stopped'입니다."

        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject='EC2 인스턴스 상태 경고',
            Message=message
        )

        lambda_client.invoke(
            FunctionName='sgu-202567-LambdaB',
            InvocationType='Event',
            Payload=json.dumps({"instance_id": INSTANCE_ID}).encode('utf-8')
        )
```

---

## 🔁 LambdaB - EC2 인스턴스 시작
**함수명:** `sgu-202567-LambdaB`

```python
import boto3
import json

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    instance_id = event.get('instance_id') or json.loads(event.get('body', '{}')).get('instance_id')

    if not instance_id:
        raise ValueError("instance_id가 전달되지 않았습니다.")

    ec2.start_instances(InstanceIds=[instance_id])
```

---

## 🧾 POST 요청 → DynamoDB 저장
**함수명:** `sgu-202567-dynamo-post-api`

```python
import boto3
import json
from datetime import datetime

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        user_id = body['user_id']
        product = body['product']
        timestamp = datetime.now().isoformat()

        reason = body.get('reason')
        brand = body.get('brand')
        price = body.get('price')
        color = body.get('color')

        item = {
            'user_id': user_id,
            'timestamp': timestamp,
            'product': product
        }

        if reason: item['reason'] = reason
        if brand: item['brand'] = brand
        if price: item['price'] = price
        if color: item['color'] = color

        table = boto3.resource('dynamodb').Table('sgu-202567-user-likes-time')
        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': '저장 완료',
                'user_id': user_id,
                'timestamp': timestamp
            }, ensure_ascii=False)
        }

    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': str(e)}, ensure_ascii=False)
        }
```



## 📥 S3에서 단일 JSON → DynamoDB 저장
**함수명:** `sgu-202567-dynamodb-3c`

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202567-user-likes-time')

    bucket_name = 'sgu-202567-s3'
    object_key = 'dynamo_data/user_likes_data.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        data = json.loads(content)

        timestamp = datetime.now().isoformat()
        data['timestamp'] = timestamp

        table.put_item(Item=data)

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'DynamoDB insert successful!',
                'item': data
            }, ensure_ascii=False)
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}, ensure_ascii=False)
        }
```

---

## 📥 S3에서 JSON (필수 필드 검증) → DynamoDB
**함수명:** `sgu-202567-dynamo-3c`

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202567-user-likes-time')

    bucket_name = 'sgu-202567-s3'
    object_key = 'dynamo_data/user_likes_data_2.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        raw_data = json.loads(content)

        user_id = raw_data.get('user_id')
        product = raw_data.get('product')

        if not user_id or not product:
            return {
                'statusCode': 400,
                'body': '필수 데이터 누락: user_id 또는 product가 없습니다.'
            }

        item = {
            'user_id': user_id,
            'timestamp': datetime.now().isoformat(),
            'product': product
        }

        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': '선택 필드만 Insert 완료',
                'item': item
            }, ensure_ascii=False)
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}, ensure_ascii=False)
        }
```

---

## 📥 S3에서 JSON 배열 → 반복 저장
**함수명:** `sgu-202567-dynamo-rambda`

```python
import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202567-user-likes-time')

    bucket_name = 'sgu-202567-s3'
    object_key = 'dynamo_data/user_likes_data.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        data_list = json.loads(content)

        for record in data_list:
            user_id = record.get('user_id')
            product = record.get('product')

            if not user_id or not product:
                print(f"user_id 또는 product 누락: {record}")
                continue

            item = {
                'user_id': user_id,
                'timestamp': datetime.now().isoformat(),
                'product': product
            }

            table.put_item(Item=item)
            print(f"Inserted: {item}")

        return {
            'statusCode': 200,
            'body': json.dumps('전체 레코드 Insert 완료', ensure_ascii=False)
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}, ensure_ascii=False)
        }
```

---

## 😂 이모지 변환 레이어 테스트
**함수명:** `sgu-202567-layertest (emoji)`

```python
import emoji

def lambda_handler(event, context):
    text = "AWS Lambda is awesome! :rocket:"
    result = emoji.emojize(text, language='alias')
    print(result)

    return {
        'statusCode': 200,
        'body': result
    }
```

---

## 🌐 외부 API GET 요청 (requests 사용)
**함수명:** `sgu-202567-layertest (requests - get)`

```python
import requests

def lambda_handler(event, context):
    url = "https://httpbin.org/get"
    response = requests.get(url)
    data = response.json()
    print("API 응답:", data)

    return {
        'statusCode': 200,
        'body': str(data)
    }
```

---

## 🌐 외부 API POST 요청 (requests 사용)
**함수명:** `sgu-202567-layertest (requests - post)`

```python
import requests
import json

def lambda_handler(event, context):
    url = "https://httpbin.org/post"
    payload = {"name": "test"}
    response = requests.post(url, json=payload)
    data = response.json()
    print("API 응답:", data)

    return {
        'statusCode': 200,
        'body': str(data)
    }
```

---
