# 📚 R 언어 주차별 전체 정리 (함수 설명 + 예시 포함)

---

## 📅 Week 3: 벡터, 날짜, 기본 객체

### ✅ 주요 내용
- 날짜 연산 (as.Date, POSIXct, lubridate)
- 벡터 생성 및 연산
- 변수 선언법과 주의사항
- seq(), rep(), append() 등 벡터 관련 함수

### ✅ 함수 설명 및 예시
```r
as.Date("2022-02-14") - as.Date("21.11.06", format="%y.%d.%m")  # 날짜 차이 계산
now()  # 현재 날짜/시간
year(now())  # 연도만 추출
seq(1, 10, 2)  # 1~10까지 2간격으로 벡터 생성
rep(1:3, each=2)  # 각 요소 반복
append(c(1,2,3), 4)  # 값 추가
```

---

## 📅 Week 4: 벡터 응용, 날짜 포맷, Matrix 실습

### ✅ 함수 설명 및 예시
```r
toupper("abc")  # 대문자 변환
as.factor(c("a", "b", "c"))  # 팩터형 변환
format(Sys.Date(), "%m/%d")  # 날짜 포맷
matrix(1:6, nrow=2)  # 행렬 생성
rbind(matrix(1:4, 2), c(5,6))  # 행 추가
dimnames(matrix(1:4, 2)) <- list(c("A", "B"), c("X", "Y"))  # 행/열 이름
```

### ✅ 실습 예시
```r
m <- matrix(1:9, nrow=3, byrow=TRUE)
m[m >= 5]  # 조건 필터링
```

---

## 📅 Week 5: List, DataFrame, subset, 파일 읽기

### ✅ 함수 설명 및 예시
```r
l <- list(name="홍길동", age=30); l$name  # 리스트 생성 및 접근
df <- data.frame(a=1:3, b=c("A", "B", "C"))  # 데이터프레임 생성
subset(df, a > 1)  # 조건으로 행 필터링
merge(df1, df2, all=TRUE)  # 병합
read.csv("fruits.csv")  # CSV 읽기
```

### ✅ 실습 예시
```r
sales <- data.frame(NO=1:3, NAME=c("apple","banana","peach"), PRICE=c(100,200,300))
subset(sales, PRICE >= 200)
```

---

## 📅 Week 6: 자주 사용하는 함수, apply 계열, 사용자 함수, plyr

### ✅ 함수 설명 및 예시
```r
mean(c(1,2,3))  # 평균
sd(c(1,2,3))  # 표준편차
sort(c(3,1,2))  # 정렬
apply(matrix(1:4,2), 1, sum)  # 행별 합
lapply(list(1:3, 4:6), sum)  # 리스트 요소별 합
tapply(mtcars$mpg, mtcars$cyl, mean)  # 그룹 평균
aggregate() : 다양한 함수를 사용하여 결과 출력
apply() : 다양한 기능
cor() : 상관함수
cumsum() : 설정된 지점까지의 누적합
cumporm() : 설정된 지점까지의 누적곱
diff() : 차이나는 부분 찾음
length() : 요소 갯수
max() : 최대값
min() : 최소값
mean() : 평균
median() : 중앙값
order() : 요소의 원위치
prod() : 누적곱
range() : 범위
rank() : 순위
sd() : 표준편차
rev() : 역순
sort() : 정렬
summary() : 요약
sweep() : 일괄적 빼기
tapply() : 백터에서 주어진 함수 연산
var() : 분산
```

### ✅ 사용자 정의 함수 예시
```r
myfun <- function(x, y) {
  return(abs(x - y))
}
myfun(5, 3)
```

---

## 📅 Week 7: dplyr 패키지 실습

### ✅ 함수 설명 및 예시
```r
library(dplyr)
df <- data.frame(name=c("홍", "김"), age=c(22, 25))
df %>% filter(age > 23)  # 행 필터링
df %>% select(name)  # 열 선택
df %>% mutate(adult = age >= 20)  # 새 열 추가
df %>% summarise(mean_age = mean(age))  # 요약
```

### ✅ 실습 예시
```r
df %>%
  filter(age >= 20) %>%
  group_by(name) %>%
  summarise(count = n())
```
