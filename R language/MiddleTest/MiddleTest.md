# 📚 R 언어 TIL 핵심 요약

---

## 📘 벡터 작성 (날짜 구하기)

```r
# 벡터 생성
v1 <- c(1, 2, 3, 4, 5)
length(v1)

# 날짜 다루기
as.Date("2022-02-14") - as.Date("21.11.06", format="%y.%m.%d")

# lubridate 사용
library(lubridate)
d <- now()
year(d); month(d); day(d); wday(d, label = TRUE)

# 날짜 계산
d + years(1) + months(2) + days(3) + hours(4) + minutes(5) + seconds(6)
```

---

## 🧮 연산자 활용

```r
# 기본 산술 연산
a <- 10; b <- 3
a + b; a - b; a * b; a / b; a %% b; a %/% b

# 비교 연산
a > b; a == b; a != b

# 논리 연산
TRUE & FALSE
TRUE | FALSE
!TRUE
```

---

## 🧪 벡터 활용 함수

```r
# set 연산
union(c(1,2), c(2,3))
setdiff(c(1,2,3), c(2,3))
intersect(c(1,2,3), c(2,3))

# 이름 붙이기
f <- c(10, 20, 30)
names(f) <- c("apple", "banana", "peach")

# 포함 여부
3 %in% c(1,2,3)
```

---

## 🧱 matrix 활용 함수 (matrix 관련 실습 문제)

```r
# 생성 및 색인
m <- matrix(1:9, nrow=3, byrow=TRUE)
rownames(m) <- c("1", "2", "3")
colnames(m) <- c("a", "b", "c")
m[2,3]
m[m >= 5]

# 실습 예시
m1 <- matrix(1:20, 4, by=T)
m1[m1[,'c'] >= 10, ]
```

---

## 📦 list 활용 함수

```r
# 리스트 생성 및 조작
l1 <- list(name="홍길동", addr="서울", tel="010", pay=500)
l1$birth <- "2002"
l1$name <- c("고길동", "마이콜")
l1$name <- append(l1$name, "둘리", after=1)
l1$name[length(l1$name)-1] <- NA
l1$birth <- NULL
```

---

## 🧾 데이터프레임 (2가지 방법 및 처리 문제)

```r
# 방법 1: 컬럼별 생성
df1 <- data.frame(NO=1:3, NAME=c("apple", "banana", "peach"), PRICE=c(100,200,300))

# 방법 2: 행렬 → data.frame
m <- matrix(c(1, "apple", 100, 5, 2, "banana", 200, 10), 2, byrow=T)
df2 <- data.frame(m)

# 열/행 추가
df1 <- rbind(df1, data.frame(NO=4, NAME="mango", PRICE=400))
df1 <- cbind(df1, QTY=c(10, 20, 30, 40))
```

---

## 🧩 subset 함수

```r
# 조건 검색
subset(df1, PRICE >= 200)
subset(df1, NAME == "apple")

# 특정 컬럼 선택
subset(df1, select = c(NO, NAME))
subset(df1, select = -PRICE)
```
