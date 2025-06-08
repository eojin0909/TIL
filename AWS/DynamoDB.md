# DynamoDB 개념 및 실습 정리

## 1. RDBMS vs NoSQL

| 항목 | RDBMS | NoSQL |
|------|-------|--------|
| 데이터 형식 | 정해진 스키마 | 자유로운 형식 |
| 트랜잭션 처리 | ACID | BASE |
| 확장성 | 어려움 | 쉬움 |
| 쿼리 복잡도 | 복잡한 쿼리 가능 | 간단한 쿼리 위주 |
| AWS 서비스 | RDS, Aurora, Redshift | DynamoDB, DocumentDB, MemoryDB 등 |

## 2. NoSQL의 종류

- Key-Value Store
- Document Database
- Graph Database

## 3. BASE 특징

- **BAsically Available**: 고가용성 중심
- **Soft-State**: 상태가 일시적으로 일관되지 않아도 됨
- **Eventual Consistency**: 시간이 지나면 일관성 수렴

## 4. DynamoDB 실습

### 테이블 생성

- 테이블명: `sgu-202500-user-likes`
- 파티션 키: `user_id`

### JSON 데이터 예시

```json
{
  "user_id": { "S": "haeri05" },
  "product_name": { "S": "무선 이어폰" },
  "category": { "S": "디지털" },
  "reason": { "S": "최근 블루투스 기기 검색" },
  "timestamp": { "S": "2025-05-11T21:00:00" },
  "price": { "N": "89000" },
  "brand": { "S": "소니" },
  "color": { "S": "블랙" },
  "rating": { "N": "4.7" }
}
```

### 정렬 키 포함 테이블

- 테이블명: `sgu-202500-user-likes-time`
- 파티션 키: `user_id`
- 정렬 키: `timestamp` (문자열 타입)