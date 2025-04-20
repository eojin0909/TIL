# 🧠 R 핵심 개념 요약

## ✅ 1. 벡터 작성 (날짜 구하기)
```r
seq(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "month")
# 결과: 
# [1] "2025-01-01" "2025-02-01" "2025-03-01" "2025-04-01" "2025-05-01"
# [6] "2025-06-01" "2025-07-01" "2025-08-01" "2025-09-01" "2025-10-01"
# [11] "2025-11-01" "2025-12-01"

as.Date("2022-02-14") - as.Date("21.11.06", format = "%y.%m.%d")
# 결과: Time difference of 100 days
```

## ✅ 2. 연산자 활용
```r
5 + 2      # 7
5 %/% 2    # 2
5 %% 2     # 1
TRUE & FALSE  # FALSE
TRUE | FALSE  # TRUE
!TRUE         # FALSE
```

## ✅ 3. 벡터 활용 함수
```r
v1 <- c(1, 2, 3, 4, 5)
length(v1)                      # 5
append(v1, 6)                   # [1] 1 2 3 4 5 6
append(v1, c(11,12) after = 3)  # [1] 1 2 3 11 12 4 5
v1[1:(length(v1)-2)]            # [1] 1 2 3
setdiff(v1, c(2,3))             # [1] 1 4 5
intersect(v1, c(2,3))           # [1] 2 3
rep(1:3, each=2)                # [1] 1 1 2 2 3 3
```

## ✅ 4. matrix 활용 함수 (실습 포함)
```r
m <- matrix(1:6, nrow=2, byrow=TRUE)
# m =
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6

m[, "2"]               # 에러 (문자 인덱싱 안됨, 숫자 인덱스로 해야 함)
m[,2]                  # [1] 2 5
m[m[,3] > 2, ]         # [2,] 4 5 6
```

## ✅ 5. list 활용 함수
```r
l1 <- list(name = "홍길동", addr = "서울", tel = "010")
l1$addr                       # [1] "서울"
l1$birth <- "2002"           # 추가
l1$name <- append(l1$name, "둘리", after=1)
# $name
# [1] "홍길동" "둘리"

l1$birth <- NULL             # 삭제
```

## ✅ 6. 데이터프레임 (2가지 생성 방법 및 처리)
```r
# 방법 1
df1 <- data.frame(NO=c(1,2), NAME=c("apple","banana"), PRICE=c(100,200))
# 방법 2
no <- c(1,2); name <- c("apple","banana"); price <- c(100,200)
df2 <- data.frame(NO=no, NAME=name, PRICE=price)

# 행 추가
df1 <- rbind(df1, data.frame(NO=3, NAME="peach", PRICE=300))
# 열 추가
df1 <- cbind(df1, QTY=c(10,20,30))
# 조건 필터
subset(df1, PRICE >= 200)
# 결과:
#   NO   NAME PRICE QTY
# 2  2 banana   200  20
# 3  3  peach   300  30
```

## ✅ 7. subset 함수
```r
subset(df1, QTY <= 10)
# 결과:
#   NO  NAME PRICE QTY
# 1  1 apple   100  10

subset(df1, select = c(NO, NAME))
# 결과:
#   NO   NAME
# 1  1  apple
# 2  2 banana
# 3  3  peach

subset(df1, select = -PRICE)
# 결과:
#   NO   NAME QTY
# 1  1  apple  10
# 2  2 banana  20
# 3  3  peach  30
```
