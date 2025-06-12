# AWS Lambda Function Summary for Final Exam

## ✅ Basic Hello Lambda
**Function Name:** `sgu-202567-Lambda`  
**Description:** Returns a simple JSON message with status 200.

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

## 🪣 Lambda with S3 Upload
**Function Name:** `sgu-202567-lambda2`  
**Description:** Uploads a "Hello" message to S3 with timestamp.

---

## 🧾 Simple DynamoDB Put
**Function Name:** `sgu-202567-dynamo`  
**Description:** Inserts user_id and product_name into DynamoDB.

---

## 🔍 EC2 Health Check & Notification (LambdaA)
**Function Name:** `sgu-202567-LambdaA`  
**Description:** Monitors EC2 status, sends SNS alert and triggers LambdaB.

---

## 🔁 EC2 Auto Start (LambdaB)
**Function Name:** `sgu-202567-LambdaB`  
**Description:** Starts EC2 instance when called by LambdaA.

---

## 🧾 POST API to DynamoDB
**Function Name:** `sgu-202567-dynamo-post-api`  
**Description:** Parses JSON body and inserts data into DynamoDB.

---

## 📥 S3 to DynamoDB (Single Object)
**Function Name:** `sgu-202567-dynamodb-3c`  
**Description:** Reads JSON from S3 and inserts it with timestamp.

---

## 📥 S3 to DynamoDB with Validation
**Function Name:** `sgu-202567-dynamo-3c`  
**Description:** Reads JSON from S3, validates fields, inserts to DynamoDB.

---

## 📥 S3 to DynamoDB (Array Insert)
**Function Name:** `sgu-202567-dynamo-rambda`  
**Description:** Parses list of JSON objects from S3 and inserts all to DynamoDB.

---

## 😂 Lambda Layer Test (emoji)
**Function Name:** `sgu-202567-layertest (emoji)`  
**Description:** Converts emoji alias text to unicode emoji using `emoji` package.

---

## 🌐 Lambda Layer Test (HTTP GET)
**Function Name:** `sgu-202567-layertest (requests - get)`  
**Description:** Uses `requests` to call an external API (GET).

---

## 🌐 Lambda Layer Test (HTTP POST)
**Function Name:** `sgu-202567-layertest (requests - post)`  
**Description:** Uses `requests` to POST data to an external API.