# 📘 AWS Lambda 함수 정리 - 기말고사 대비

기말고사에서 사용할 Lambda 함수들을 기능별로 정리한 문서입니다. 각 함수는 AWS 리소스(S3, EC2, DynamoDB 등)와의 연동, 알림, 데이터 처리 등을 수행합니다.

---

## ✅ 기본 Lambda 함수 (Hello 메시지 반환)
**함수명:** `sgu-202567-Lambda`  
**설명:** 간단한 "Hello Lambda" 메시지를 반환하는 테스트용 함수입니다.

```python
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        "statusDescription":"200 OK",
        "isBase64Encoded" : False,
        "headers":{"Content-Type":"application/json"},
        'body': '{"message":"Hello Lambda"}'
    }
```

---

## 🪣 S3에 텍스트 업로드
**함수명:** `sgu-202567-lambda2`  
**설명:** 현재 시간을 포함한 텍스트 파일을 생성하여 지정된 S3 버킷에 업로드합니다.

---

## 🧾 DynamoDB에 항목 저장
**함수명:** `sgu-202567-dynamo`  
**설명:** `user_id`, `product_name` 값을 가진 항목을 DynamoDB 테이블에 저장합니다.

---

## 🔍 EC2 상태 확인 및 경고 전송 (LambdaA)
**함수명:** `sgu-202567-LambdaA`  
**설명:**  
- EC2 인스턴스 상태가 정지(`stopped`)되었는지 확인  
- 정지 상태면 SNS로 경고 메시지를 전송  
- LambdaB 함수를 호출하여 EC2를 재시작 요청

---

## 🔁 EC2 시작 처리 (LambdaB)
**함수명:** `sgu-202567-LambdaB`  
**설명:** 전달받은 `instance_id`를 기준으로 EC2 인스턴스를 시작합니다.

---

## 🧾 POST API → DynamoDB 저장
**함수명:** `sgu-202567-dynamo-post-api`  
**설명:**  
- HTTP POST 요청으로 전달된 JSON 데이터를 파싱  
- 필수 및 선택 필드를 DynamoDB에 저장

---

## 📥 S3 → DynamoDB (단일 JSON 객체)
**함수명:** `sgu-202567-dynamodb-3c`  
**설명:**  
- S3에서 JSON 파일을 불러와 타임스탬프를 추가  
- DynamoDB 테이블에 해당 데이터를 저장

---

## 📥 S3 → DynamoDB (필드 검증 포함)
**함수명:** `sgu-202567-dynamo-3c`  
**설명:**  
- S3에서 JSON 파일을 읽어 필수 필드(`user_id`, `product`)를 확인  
- 문제 없을 경우 DynamoDB에 저장

---

## 📥 S3 → DynamoDB (JSON 배열 처리)
**함수명:** `sgu-202567-dynamo-rambda`  
**설명:**  
- S3에 저장된 JSON 배열 데이터를 반복 처리하여  
- 각 항목을 DynamoDB에 저장

---

## 😂 이모지 변환 테스트
**함수명:** `sgu-202567-layertest (emoji)`  
**설명:** 문자열 내 이모지 텍스트(:rocket:)를 실제 이모지(🚀)로 변환

---

## 🌐 HTTP GET 요청 테스트
**함수명:** `sgu-202567-layertest (requests - get)`  
**설명:** 외부 API(`httpbin.org/get`)에 GET 요청을 보내고 결과를 출력

---

## 🌐 HTTP POST 요청 테스트
**함수명:** `sgu-202567-layertest (requests - post)`  
**설명:** 외부 API(`httpbin.org/post`)에 POST 요청으로 JSON 데이터 전송

---