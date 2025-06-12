# 📘 AWS Lambda 함수 정리 - 기말고사 대비 (코드 포함)

기말고사에 사용할 모든 Lambda 함수의 코드에 상세 주석을 추가한 문서입니다.

---

## ✅ 기본 Lambda 함수 (Hello 메시지 반환)

```python
import json

# Lambda 함수의 진입점
def lambda_handler(event, context):
    # 클라이언트에게 JSON 형식으로 "Hello Lambda" 메시지를 반환
    return {
        'statusCode': 200,                       # HTTP 상태 코드
        "statusDescription": "200 OK",           # 상태 메시지
        "isBase64Encoded": False,                # Base64 인코딩 여부 (파일 전송 시 주로 true)
        "headers": {
            "Content-Type": "application/json"   # 응답의 타입 정의
        },
        'body': '{"message":"Hello Lambda"}'     # 본문 데이터
    }
```

---

## 🪣 S3에 텍스트 업로드

```python
import json
import boto3
from datetime import datetime

# 현재 시간을 포함한 텍스트 파일을 S3에 업로드하는 함수
def lambda_handler(event, context):
    s3 = boto3.client('s3')                      # S3 클라이언트 생성
    bucket_name = 'sgu-202567-s3'                # 대상 버킷 이름
    prefix = 'uploaded/'                         # 업로드될 폴더 경로

    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')   # 현재 시각
    filename = f'{prefix}hello_{now}.txt'        # 저장할 파일명
    content = f'Hello Haeri! This file was created at {now}'  # 파일 내용

    # S3에 객체 업로드
    s3.put_object(
        Bucket=bucket_name,
        Key=filename,
        Body=content.encode('utf-8')             # UTF-8 인코딩 후 저장
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

# 🪣 S3 파일 불러오기 → 난수로 수정 → 다시 저장하기 (Lambda + boto3)

AWS Lambda와 boto3를 활용해 S3에서 파일을 읽고, 내용을 난수(random value)로 수정한 뒤 다시 저장하는 방법입니다.

---

## ✅ 전체 프로세스

1. S3에서 파일 불러오기
2. 파일 내용을 난수로 수정
3. 새로 저장하거나 덮어쓰기

---

## ✅ 기본 예제 코드 (텍스트 파일 수정)

```python
import boto3
import random
import string

s3 = boto3.client('s3')
bucket_name = 'your-bucket-name'
key = 'your-file.txt'

def lambda_handler(event, context):
    obj = s3.get_object(Bucket=bucket_name, Key=key)
    content = obj['Body'].read().decode('utf-8')

    random_string = ''.join(random.choices(string.ascii_letters + string.digits, k=20))

    new_key = f"modified/{key}"
    s3.put_object(
        Bucket=bucket_name,
        Key=new_key,
        Body=random_string.encode('utf-8')
    )

    return {
        'statusCode': 200,
        'body': f'{new_key}에 저장 완료'
    }
```

---

## ✅ JSON 파일 수정 예제

```python
import boto3
import json
import random
import string

s3 = boto3.client('s3')
bucket = 'your-bucket-name'
key = 'data/sample.json'

def lambda_handler(event, context):
    obj = s3.get_object(Bucket=bucket, Key=key)
    content = obj['Body'].read().decode('utf-8')
    data = json.loads(content)

    # 예: 'name' 필드를 랜덤 문자열로 변경
    data['name'] = ''.join(random.choices(string.ascii_lowercase, k=8))

    new_content = json.dumps(data, ensure_ascii=False)
    s3.put_object(Bucket=bucket, Key=f'modified/{key}', Body=new_content.encode('utf-8'))

    return {'statusCode': 200, 'body': 'JSON 파일 수정 완료'}
```

---

## ✅ CSV 파일 수정 예제

```python
import boto3
import csv
import io
import random

s3 = boto3.client('s3')
bucket = 'your-bucket-name'
key = 'data/sample.csv'

def lambda_handler(event, context):
    obj = s3.get_object(Bucket=bucket, Key=key)
    content = obj['Body'].read().decode('utf-8')

    input_stream = io.StringIO(content)
    output_stream = io.StringIO()
    reader = csv.DictReader(input_stream)
    fieldnames = reader.fieldnames

    writer = csv.DictWriter(output_stream, fieldnames=fieldnames)
    writer.writeheader()

    for row in reader:
        # 예: age 컬럼을 10~99 사이 랜덤 숫자로 수정
        row['age'] = str(random.randint(10, 99))
        writer.writerow(row)

    s3.put_object(Bucket=bucket, Key=f'modified/{key}', Body=output_stream.getvalue().encode('utf-8'))

    return {'statusCode': 200, 'body': 'CSV 수정 완료'}
```

---

## ✅ 랜덤값 생성 요약

| 타입 | 코드 | 설명 |
|------|------|------|
| 숫자 | `random.randint(1000, 9999)` | 1000~9999 |
| 문자열 | `''.join(random.choices(string.ascii_letters, k=10))` | 알파벳 10자 |
| UUID | `import uuid; uuid.uuid4()` | 고유값 생성 |

---

## ✅ 권한 필요

Lambda 함수가 S3 접근할 수 있도록 IAM Role에 아래 권한이 있어야 합니다:

```json
{
  "Effect": "Allow",
  "Action": [
    "s3:GetObject",
    "s3:PutObject"
  ],
  "Resource": "arn:aws:s3:::your-bucket-name/*"
}
```


---

## 🧾 DynamoDB에 항목 저장

```python
import boto3

# 정해진 값을 DynamoDB 테이블에 저장
def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')    # DynamoDB 리소스 생성
    table = dynamodb.Table('sgu-202567-user-likes')  # 테이블 이름

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

```python
import boto3
import json

# EC2 상태를 점검하고 꺼져 있으면 알림 + LambdaB 호출
ec2 = boto3.client('ec2')
sns = boto3.client('sns')
lambda_client = boto3.client('lambda')

INSTANCE_ID = 'i-06b650f8b77158f7c'  # 대상 인스턴스 ID
SNS_TOPIC_ARN = 'arn:aws:sns:ap-northeast-2:443370697536:sgu-202567-MyTopic'  # SNS 주제 ARN

def lambda_handler(event, context):
    response = ec2.describe_instance_status(InstanceIds=[INSTANCE_ID])
    statuses = response.get('InstanceStatuses', [])

    if not statuses or statuses[0]['InstanceState']['Name'] != 'running':
        message = f"경고: EC2 인스턴스 {INSTANCE_ID} 상태가 'stopped'입니다."

        # SNS 알림 전송
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject='EC2 인스턴스 상태 경고',
            Message=message
        )

        # LambdaB 호출 → EC2 인스턴스 시작
        lambda_client.invoke(
            FunctionName='sgu-202567-LambdaB',
            InvocationType='Event',
            Payload=json.dumps({"instance_id": INSTANCE_ID}).encode('utf-8')
        )
```

---

## ✅ 기본 Lambda 함수 (Hello 메시지 반환)

```python
import json

# Lambda 함수의 진입점
def lambda_handler(event, context):
    # 클라이언트에게 JSON 형식으로 "Hello Lambda" 메시지를 반환
    return {
        'statusCode': 200,                       # HTTP 상태 코드
        "statusDescription": "200 OK",           # 상태 메시지
        "isBase64Encoded": False,                # Base64 인코딩 여부 (파일 전송 시 주로 true)
        "headers": {
            "Content-Type": "application/json"   # 응답의 타입 정의
        },
        'body': '{"message":"Hello Lambda"}'     # 본문 데이터
    }
```

---

## 🪣 S3에 텍스트 업로드

```python
import json
import boto3
from datetime import datetime

# 현재 시간을 포함한 텍스트 파일을 S3에 업로드하는 함수
def lambda_handler(event, context):
    s3 = boto3.client('s3')                      # S3 클라이언트 생성
    bucket_name = 'sgu-202567-s3'                # 대상 버킷 이름
    prefix = 'uploaded/'                         # 업로드될 폴더 경로

    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')   # 현재 시각
    filename = f'{prefix}hello_{now}.txt'        # 저장할 파일명
    content = f'Hello Haeri! This file was created at {now}'  # 파일 내용

    # S3에 객체 업로드
    s3.put_object(
        Bucket=bucket_name,
        Key=filename,
        Body=content.encode('utf-8')             # UTF-8 인코딩 후 저장
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

```python
import boto3

# 정해진 값을 DynamoDB 테이블에 저장
def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')    # DynamoDB 리소스 생성
    table = dynamodb.Table('sgu-202567-user-likes')  # 테이블 이름

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

```python
import boto3
import json

# EC2 상태를 점검하고 꺼져 있으면 알림 + LambdaB 호출
ec2 = boto3.client('ec2')
sns = boto3.client('sns')
lambda_client = boto3.client('lambda')

INSTANCE_ID = 'i-06b650f8b77158f7c'  # 대상 인스턴스 ID
SNS_TOPIC_ARN = 'arn:aws:sns:ap-northeast-2:443370697536:sgu-202567-MyTopic'  # SNS 주제 ARN

def lambda_handler(event, context):
    response = ec2.describe_instance_status(InstanceIds=[INSTANCE_ID])
    statuses = response.get('InstanceStatuses', [])

    if not statuses or statuses[0]['InstanceState']['Name'] != 'running':
        message = f"경고: EC2 인스턴스 {INSTANCE_ID} 상태가 'stopped'입니다."

        # SNS 알림 전송
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject='EC2 인스턴스 상태 경고',
            Message=message
        )

        # LambdaB 호출 → EC2 인스턴스 시작
        lambda_client.invoke(
            FunctionName='sgu-202567-LambdaB',
            InvocationType='Event',
            Payload=json.dumps({"instance_id": INSTANCE_ID}).encode('utf-8')
        )
```

--- 


---

## 🔁 LambdaB - EC2 인스턴스 시작

```python
import boto3
import json

ec2 = boto3.client('ec2')  # EC2 클라이언트 생성

def lambda_handler(event, context):
    # event에서 instance_id 추출 (직접 또는 body 안에 있을 수도 있음)
    instance_id = event.get('instance_id') or json.loads(event.get('body', '{}')).get('instance_id')

    if not instance_id:
        # instance_id가 없으면 오류 발생
        raise ValueError("instance_id가 전달되지 않았습니다.")

    # EC2 인스턴스 시작
    ec2.start_instances(InstanceIds=[instance_id])
```

---

## 🧾 POST 요청 → DynamoDB 저장

```python
import boto3
import json
from datetime import datetime

# POST 요청으로 받은 데이터를 DynamoDB에 저장하는 함수
def lambda_handler(event, context):
    try:
        # JSON 본문 파싱
        body = json.loads(event['body'])
        user_id = body['user_id']
        product = body['product']
        timestamp = datetime.now().isoformat()

        # 선택 필드
        reason = body.get('reason')
        brand = body.get('brand')
        price = body.get('price')
        color = body.get('color')

        # 항목 구성
        item = {
            'user_id': user_id,
            'timestamp': timestamp,
            'product': product
        }

        # 선택 필드 추가
        if reason: item['reason'] = reason
        if brand: item['brand'] = brand
        if price: item['price'] = price
        if color: item['color'] = color

        # DynamoDB 저장
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
        # 오류 처리
        return {
            'statusCode': 400,
            'body': json.dumps({'error': str(e)}, ensure_ascii=False)
        }
```

---

## 📥 S3에서 단일 JSON → DynamoDB 저장

```python
import json
import boto3
from datetime import datetime

# S3에서 JSON 하나를 읽어 DynamoDB에 저장
def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('sgu-202567-user-likes-time')

    bucket_name = 'sgu-202567-s3'
    object_key = 'dynamo_data/user_likes_data.json'

    try:
        # S3 객체 읽기
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response['Body'].read().decode('utf-8')
        data = json.loads(content)

        # 타임스탬프 추가
        timestamp = datetime.now().isoformat()
        data['timestamp'] = timestamp

        # DynamoDB 저장
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

```python
import json
import boto3
from datetime import datetime

# S3에서 JSON 읽고 필수 항목 검증 후 저장
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

```python
import json
import boto3
from datetime import datetime

# S3에서 배열 데이터를 읽어 여러 개를 DynamoDB에 저장
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

```python
import emoji

# emoji 라이브러리를 사용하여 텍스트 안의 이모지 태그(:rocket:)를 실제 이모지로 변환
def lambda_handler(event, context):
    text = "AWS Lambda is awesome! :rocket:"      # :rocket:은 이모지 태그 (🚀)
    result = emoji.emojize(text, language='alias') # 태그를 실제 이모지로 변환
    print(result)                                  # CloudWatch 로그 출력

    return {
        'statusCode': 200,
        'body': result                             # 변환된 결과를 응답으로 반환
    }
```

## 🌐 외부 API GET 요청 (requests 사용)

```python
import requests

# 외부 API (httpbin.org) 에 GET 요청을 보내는 예제
def lambda_handler(event, context):
    url = "https://httpbin.org/get"  # 테스트용 API
    response = requests.get(url)     # GET 요청 보내기
    data = response.json()           # 응답 JSON 파싱
    print("API 응답:", data)         # CloudWatch 로그 출력

    return {
        'statusCode': 200,
        'body': str(data)            # 문자열로 응답 본문 구성
    }
```

---

## 🌐 외부 API POST 요청 (requests 사용)

```python
import requests
import json

# 외부 API에 POST 요청을 보내는 Lambda 예제
def lambda_handler(event, context):
    url = "https://httpbin.org/post"      # 테스트용 API
    payload = {"name": "test"}            # 전송할 JSON 데이터
    response = requests.post(url, json=payload)  # POST 요청
    data = response.json()                # 응답 JSON 파싱
    print("API 응답:", data)              # 로그 출력

    return {
        'statusCode': 200,
        'body': str(data)                 # 문자열로 반환
    }
```


# 📘 AWS CloudWatch 로그 그룹 및 로그 기록 방법 정리

기말 대비 또는 실무에서 사용할 수 있는 CloudWatch 로그 관련 핵심 내용을 정리한 문서입니다.

---

## ✅ 1. CloudWatch 로그 그룹(Log Group) 만드는 법

### 📍 AWS 콘솔에서 만드는 방법

1. [AWS Management Console](https://console.aws.amazon.com/) 접속  
2. 상단 검색창에 **“CloudWatch”** 입력 후 서비스 이동  
3. 왼쪽 메뉴에서 **“로그 그룹”** 선택  
4. **“로그 그룹 생성”** 클릭  
5. 원하는 이름 입력 (예: `/aws/lambda/my-lambda-loggroup`)  
6. **“로그 그룹 생성”** 버튼 클릭  

---

### 📍 AWS CLI로 만드는 방법

```bash
aws logs create-log-group --log-group-name /aws/lambda/my-lambda-loggroup
```

---

## ✅ 2. Lambda 함수에서 CloudWatch 로그 남기기

- Lambda 함수는 별도 설정 없이 기본적으로 CloudWatch 로그 그룹을 자동으로 생성하고 로그를 남깁니다.
- `print()` 또는 `logging` 모듈을 사용하면 CloudWatch에 로그가 기록됩니다.

```python
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    print("print로 남긴 로그")              # CloudWatch 로그로 전송됨
    logger.info("logger로 남긴 INFO 로그")  # CloudWatch 로그로 전송됨
    logger.error("logger로 남긴 ERROR 로그")
    return {'statusCode': 200}
```

- Lambda를 처음 배포하면 `/aws/lambda/함수이름` 로그 그룹이 자동 생성됩니다.
- 로그 확인:  
  **AWS Console > CloudWatch > 로그 그룹 > `/aws/lambda/함수이름` > 로그 스트림**

---

## ✅ 3. EC2, ECS 등 다른 리소스에서 CloudWatch 로그 사용

- **EC2**: CloudWatch 에이전트 설치 후 로그 그룹에 로그 전송 가능
- **ECS**: 태스크 정의에서 `awslogs` 드라이버를 설정하여 로그 전송
- **직접 로그 전송**: `boto3`의 `put_log_events` 메서드로 프로그래밍 방식 전송도 가능

---

## ✅ 4. 참고 공식 문서

- [AWS CloudWatch 시작하기](https://docs.aws.amazon.com/ko_kr/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [Lambda와 CloudWatch 연동](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-cloudwatchlogs.html)

---

AWS Lambda에서 `print()` 또는 `logging` 모듈을 사용하면 로그가 CloudWatch로 전송되어 콘솔에서 확인할 수 있습니다.

### 📌 방법 1: print() 사용 (간단)
```python
print("로그 메시지입니다")  # 이 메시지는 CloudWatch Logs에 출력됨
```

### 📌 방법 2: logging 모듈 사용 (추천)
```python
import logging

logger = logging.getLogger()          # 기본 로거 객체를 가져옴
logger.setLevel(logging.INFO)         # 로그 레벨을 INFO로 설정

logger.info("INFO 로그 메시지")       # INFO 수준 로그
logger.error("ERROR 로그 메시지")     # ERROR 수준 로그
```

> 📍 로그는 AWS Console > CloudWatch > 로그 그룹 > `/aws/lambda/함수이름` > 로그 스트림에서 확인할 수 있습니다.

---

## ✅ 5. 타임스탬프 생성

### 📌 ISO 8601 형식의 타임스탬프 생성
```python
from datetime import datetime

timestamp = datetime.now().isoformat()  # 현재 시간을 ISO 형식 문자열로 반환
print("타임스탬프:", timestamp)         # 예시: 2025-06-12T14:32:45.123456
```

### 📌 날짜/시간만 따로 추출
```python
now = datetime.now()
print("날짜:", now.strftime("%Y-%m-%d"))  # '2025-06-12' 형식
print("시간:", now.strftime("%H:%M:%S"))  # '14:32:45' 형식
```

---

## ✅ 전체 예제 코드 (주석 포함)

```python
import logging
from datetime import datetime

# CloudWatch 로그를 위한 로거 설정
logger = logging.getLogger()
logger.setLevel(logging.INFO)  # 로그 레벨 설정

def lambda_handler(event, context):
    # 현재 시간 타임스탬프 생성
    timestamp = datetime.now().isoformat()

    # 로그 메시지 출력 (CloudWatch에 기록됨)
    logger.info(f"[{timestamp}] Lambda 함수가 실행되었습니다")

    # 함수 응답 반환
    return {
        'statusCode': 200,
        'body': f"실행된 시간: {timestamp}"
    }
```
