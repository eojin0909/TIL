# 📚 R 언어 중간 정리

## 📘 벡터 작성 및 날짜 구하기
  
R에서 벡터를 생성하는 방법과 날짜 객체를 다루는 방법.

```r
# 벡터 생성
v1 <- c(1, 2, 3)
v2 <- seq(1, 10, by = 2)
v3 <- rep("a", 5)

# 날짜 구하기
today <- Sys.Date()
as.Date("2025-04-20")
dates <- seq(as.Date("2025-01-01"), by = "month", length.out = 5)
```

---

## 🧮 연산자 활용
 
기본 산술 연산자와 논리 연산자.

```r
# 산술 연산자
a <- 10; b <- 3
a + b; a - b; a * b; a / b; a %% b; a %/% b

# 비교 연산자
a > b; a == b; a != b

# 논리 연산자
TRUE & FALSE
TRUE | FALSE
!TRUE
```

---

## 🧪 벡터 활용 함수

벡터에 자주 쓰이는 함수.

```r
v <- c(1, 2, 3, 4, 5)

sum(v)
mean(v)
median(v)
max(v)
min(v)
sort(v, decreasing = TRUE)
which.max(v)
which.min(v)
```

---

## 🧱  Matrix 활용 함수 + 실습 문제

Matrix를 만들고 처리하는 다양한 함수.

```r
# Matrix 생성
m <- matrix(1:9, nrow = 3, byrow = TRUE)

# 함수들
t(m)
rowSums(m)
colSums(m)
rowMeans(m)
colMeans(m)

# 실습 문제
m2 <- matrix(1:12, nrow = 3)
colSums(m2)
```

---

## 🧳 List 활용 함수

List 구조와 관련 함수들을 정리.

```r
my_list <- list(name = "Alice", age = 25, scores = c(90, 85, 100))

my_list$name
my_list[[3]]
my_list$age <- 26
my_list$gender <- "F"
my_list$age <- NULL
```

---

## 🧾 데이터프레임 만들기 (2가지 방법)

Data Frame을 두 가지 방법으로 만들고 처리.

```r
# 방법 1
df1 <- data.frame(
  name = c("홍길동", "김철수"),
  age = c(25, 30),
  score = c(90, 85)
)

# 방법 2
names <- c("이영희", "박민수")
ages <- c(22, 28)
scores <- c(88, 92)
df2 <- data.frame(names, ages, scores)

# 처리 예시
subset(df1, age >= 25)
```

---

## 🧩 subset 함수
  
조건에 맞는 데이터를 추출할 때 subset 함수를 사용하는 방법.

```r
df <- data.frame(
  name = c("홍길동", "김철수", "이영희"),
  age = c(25, 30, 22),
  score = c(90, 85, 88)
)

subset(df, age >= 25)
subset(df, score >= 90, select = name)
```
