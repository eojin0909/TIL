# 기말시험 요점 정리

## 1. Lambda Layer
- 라이브러리(emoji, requests 등)를 AWS Lambda에 zip 파일로 레이어 생성하여 추가
- Python 3.13 환경에서 zip 압축 후 콘솔에서 업로드 및 적용

## 2. DynamoDB 개념
- NoSQL DB로, 스키마 없이 유연한 데이터 저장
- Key-Value, Document, Graph 구조 존재
- BASE 특성 (Eventually Consistent 등)

## 3. DynamoDB vs RDBMS
| 항목 | RDBMS | NoSQL |
|------|-------|--------|
| 데이터 형식 | 정해진 스키마 | 자유로운 데이터 형식 |
| 처리 방식 | ACID | BASE |
| 확장성 | 확장 어려움 | 분산 처리 쉬움 |
| 쿼리 복잡도 | 복잡한 쿼리 가능 | 간단한 쿼리 위주 |
| AWS 서비스 | RDS, Aurora 등 | DynamoDB, MemoryDB 등 |

## 4. DynamoDB 실습
- 정렬 키(timestamp) 포함 테이블 생성
- 항목 추가, 시간순 정렬 쿼리
- Lambda로 Insert
- API Gateway와 연결하여 REST API 구성

## 5. Lambda + S3 + DynamoDB
- Lambda에서 S3 JSON 파일 읽고 DynamoDB 삽입
- 배열 처리, 필드 필터링
- 타임아웃 시 Lambda 제한 시간 증가 필요

## 6. Lambda + CloudWatch + DynamoDB
- CloudWatch 로그 조회
- message와 timestamp를 추출하여 DynamoDB에 저장

## 7. ELB (Elastic Load Balancer)
- 트래픽 분산
- ALB/NLB/CLB 유형
- 헬스 체크 및 Target Group 설정
- 리스너 규칙 설정 가능

## 8. ALB + Lambda + S3
- ALB 리스너에 경로 기반(/lambda, /upload 등)으로 Lambda 연결
- Lambda에서 S3에 파일 업로드 수행
