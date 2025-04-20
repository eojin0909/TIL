# 📅 TIL - Week 3: R 언어 기초 및 날짜 처리

## ✅ 날짜 처리 및 `lubridate` 패키지

### ✔ 기본 날짜 연산
```r
as.Date("2022-02-14") - as.Date("21.11.06", format = "%y.%d.%m")
```

- `as.Date()`로 문자열을 날짜 객체로 변환 가능
- 날짜 포맷 지정 시 `format = "%y.%d.%m"`처럼 직접 설정 필요

### ✔ POSIX 클래스
- `POSIXlt`: 리스트 기반 날짜 (년, 월, 일, 시, 분, 초)
- `POSIXct`: 기준 날짜(1970-01-01)부터의 초 단위 시간

### ✔ 날짜 차이 계산
```r
as.POSIXct("2025-03-19 15:51") - as.POSIXct("2025-03-19 13:50:00")
```

### ✔ `lubridate` 활용
```r
library(lubridate)
now() + years(1) + months(2) + days(3) + hours(4) + minutes(5) + seconds(6)
```

- `now()`: 현재 시간
- `year(d)`, `month(d)`, `day(d)`, `wday(d, label=T)`: 날짜 정보 추출
- `hm("22:30")`, `hms("22:30:15")`: 시각 객체 생성

### ✔ 날짜 생성
```r
seq(as.Date("2025-01-01"), as.Date("2025-12-31"), 'month')
```

- `seq()`로 날짜 범위 생성 (`'day'`, `'month'`, `'year'` 등 가능)

---

## 📌 변수와 자료형

### ✔ 변수 선언
```r
v1 <- 2
v2 <- v3 <- v4 <- 1
10 -> v5 -> v6 -> v7
```

- 대소문자 구분
- 변수명은 문자로 시작해야 함
- 예약어 사용 금지

### ✔ 클래스 확인
```r
class(v1)
str(v1)
```

- `class()`: 자료형 확인
- `str()`: 구조 확인

---

## 🔢 벡터(Vector)

### ✔ 벡터 생성
```r
v1 <- c(1, 2, 3, 4, 5)
v1[1:(length(v1) - 2)]
```

- `c()`: 벡터 생성
- `length()`: 길이 확인
- 인덱스는 1부터 시작

### ✔ 벡터 수정/추가
```r
v1[2] <- 6
v1 <- append(v1, c(10, 11), after = 3)
```

- `append()`: 요소 삽입

### ✔ 벡터 연산
```r
v1 + v2
setdiff(v1, v2)    # 차집합
intersect(v1, v2)  # 교집합
```

### ✔ 이름 지정
```r
names(f) <- c('apple', 'banana', 'peach')
```

- 각 요소에 이름 부여 가능

### ✔ 연속값 벡터 생성
```r
seq(1, 10, 2)
rep(1:3, each = 2)
```

- `seq()`: 등차수열
- `rep()`: 반복

---

## 🧪 실습 문제 예시

### 날짜 차이 구하기
```r
as.Date("2022-02-14") - as.Date("21.11.06", format = "%y.%d.%m")
```

### 특정 날짜 인덱싱 및 연산
```r
d <- seq(as.Date("2025-01-01"), as.Date("2125-12-31"), 'year')
d[c(35, 45)] + years(1)
```

### 벡터 범위 출력
```r
v1[1:(length(v1)-2)]
```

---

## 🛠 자주 사용하는 함수 요약

| 함수 | 설명 |
|------|------|
| `as.Date()` | 문자열 → 날짜 변환 |
| `as.POSIXct()` | 문자열 → 시각 변환 |
| `seq()` | 연속된 벡터 생성 |
| `rep()` | 벡터 반복 생성 |
| `append()` | 벡터 요소 추가 |
| `length()` | 벡터 길이 확인 |
| `class()` | 객체의 자료형 확인 |
| `str()` | 객체 구조 확인 |
| `setdiff()` | 차집합 |
| `intersect()` | 교집합 |
| `union()` | 합집합 |
| `%in%` | 포함 여부 확인 |


# 📅 TIL - Week 4: R 언어 벡터, 행렬, 배열 실습

## ✅ 날짜와 벡터 기본

### ✔ 날짜 시퀀스 생성
```r
seq(as.Date("2025-01-01"), as.Date("2025-1-31"), 'day')
```

### ✔ 벡터 삭제 및 대소문자 변환
```r
vec1 <- c('a', 'b', 'c', 'd', 'e', 'f')
vec1[c(3,5)] <- toupper(vec1[c(3,5)])
vec1 = vec1[-4]
vec1 = as.factor(vec1)
```

- `toupper()`: 대문자 변환
- `as.factor()`: 팩터형 변환

### ✔ 집합 연산
```r
union(vec1, vec2)      # 합집합
setdiff(vec1, vec2)    # 차집합
intersect(vec1, vec2)  # 교집합
```

---

## 📅 날짜 포맷 처리 및 삽입

```r
vec1 = seq(as.Date("2022-01-01"), as.Date("2122-12-31"), 1)
vec2 = format(vec1, "%m/%d")
```

### ✔ 특정 날짜의 위치 찾기
```r
names(d1) = 1:length(d1)
d1[d1 == "2022-02-28"]
```

### ✔ 날짜 삽입 후 변환
```r
d2 = append(as.character(d1), "2022-02-29", after = 59)
d3 = as.Date(d2)
```

---

## 🧮 행렬(Matrix) 기본

### ✔ 생성과 속성
```r
m2 = matrix(c(1,2,3,4), nrow=2)
m3 = matrix(c(1,2,3,4), 2, byrow = TRUE)
```

- `matrix()`: 행렬 생성
- `byrow = TRUE`: 행 기준으로 채우기

### ✔ 행렬 확장 및 이름 지정
```r
m4 = rbind(m4, c(11,12,13))
m4 = cbind(m4, c(20,21,22)) # 열 추가
rownames(m4) = c(1,2,3,4,5)
colnames(m4) = c('1st','2nd','3rd','4th')
```

---

## 📌 행렬 조건 및 필터링

### ✔ 조건에 따른 요소 추출
```r
m1[m1 >= 10]
m1[m1[,'c'] >= 10]
m1[m1[,'e'] == 20, 3:5]
```

- 논리 조건을 이용해 특정 값 추출 가능

---

## 💼 행렬 실습 문제

### ✔ 과일 데이터 생성
```r
m1 = cbind(no, name, price, qty)
```

### ✔ 문제별 풀이
1. `peach` 가격 출력:
```r
m1[m1[,'name']=='peach','price']
```

2. `apple`, `peach`만 출력:
```r
m1[m1[,'name']=='apple' | m1[,'name']=='peach',]
```

3. `sales` 컬럼 생성:
```r
sales = as.numeric(m1[,'price']) * as.numeric(m1[,'qty'])
cbind(m1, sales)
```

4. 첫 번째 컬럼 제거 및 행 이름 지정:
```r
rownames(m1) = m1[,1]
m1 = m1[,-1]
```

5. `qty`가 5 이상인 과일 이름:
```r
m1[m1[,'qty'] >= 5, 'name']
```

6. 과일 추가 (`mango`, 100원, 10개):
```r
v1 = c('mango',100,10)
m1 = rbind(m1, v1)
rownames(m1)[5] = 5
```

---

## 🧱 배열(Array)

### ✔ 배열 생성
```r
a2 = array(c(1:12), dim=c(2,2,3))
a2[1,1,3]
```

- `array(dim = c(row, col, depth))`: 다차원 배열 생성
- 행, 열, 높이 단위로 요소 접근 가능

---

## 🛠 자주 사용하는 함수 요약

| 함수 | 설명 |
|------|------|
| `seq()` | 연속된 벡터/날짜 생성 |
| `format()` | 날짜 포맷 변경 |
| `append()` | 요소 삽입 |
| `toupper()` | 대문자 변환 |
| `as.factor()` | 팩터형 변환 |
| `matrix()` | 행렬 생성 |
| `rbind()` | 행 추가 |
| `cbind()` | 열 추가 |
| `rownames()` / `colnames()` | 행/열 이름 설정 |
| `array()` | 배열 생성 |


# 📅 TIL - Week 5: R 언어 리스트, 데이터프레임, 파일 입출력

## 📦 리스트 (List)

```r
l1 = list(name = '홍길동', addr = '서울', tel = '010-1111-1111', pay = 500)
l1$addr
l1$birth = '2002'
l1$name = c('고길동', '마이콜')
l1$name = append(l1$name, '둘리', after = 1)
l1$birth = NULL
```

- `$`를 통해 키 조회
- `append()`로 원하는 위치에 요소 추가
- 요소 삭제는 `NULL` 또는 `NA` 사용

---

## 📊 데이터프레임 (Data Frame)

### ✔ 생성 방법
```r
sales = data.frame(NO=no, NAME=name, PRICE=price, QTY=qty)
```

- `str()`, `class()`로 구조 확인
- `subset()`으로 조건 조회
- `rbind()`, `cbind()`, `merge()`로 행/열/데이터 병합

### ✔ 조건 조회
```r
subset(sales, QTY <= 5)
subset(sales, NAME == 'apple')
```

### ✔ 병합
```r
merge(df5, df6)
merge(df5, df6, all = TRUE)
```

---

## 🧪 데이터프레임 실습 문제

1. 특정 이름/조건 조회:
```r
sales$NAME
sales[1,3]
sales[c(1,3),]
```

2. 데이터 추가 및 병합:
```r
df7 = data.frame(NO = c(4,5), NAME = c('mango','barry'), PRICE = c(400, 500))
df1 = rbind(df1, df7)
df1 = cbind(df1, qty = c(10,20,30,40,50))
```

3. 일부 열만 추출/변경:
```r
mem2 = subset(mem, select = c(NO, NAME, TEL))
mem3 = subset(mem, select = -TEL)
colnames(mem3) = c('번호','이름','주소','취미')
```

---

## 📈 평균과 반올림

```r
mean(a1$가격)
round(mean(a1$가격), 2)
```

- `mean()`: 평균 계산
- `round(x, 2)`: 소수점 둘째자리 반올림

---

## 🛠 dplyr 패키지 활용

```r
df2 = rename(df2, v2 = var2)
df1$var_sum = df1$var1 + df1$var2
```

- `rename()`: 변수명 변경
- 파생변수 생성도 쉬움

---

## 📊 ggplot2의 mpg 데이터

```r
library(ggplot2)
mpg1 = rename(mpg, city = cty, highway = hwy)
```

- `mpg`: 자동차 정보 데이터셋
- `rename()`으로 열 이름 변경

---

## 💾 파일 입출력

### ✔ 파일 목록 확인
```r
list.files()
list.files(all.files = TRUE)
```

### ✔ scan() 함수
```r
s1 = scan("scan_1.txt")
s2 = scan("scan_2.txt", what = "")
```

- 숫자만 읽거나, `what=''`으로 문자열까지 가능

### ✔ readline() / readLines()
```r
input = readline("R u OK?!")
readLines("scan_4.txt")
```

- `readline()`: 한 줄 입력
- `readLines()`: 전체 읽기 (문자열로 저장)

---

### ✔ 데이터 프레임 읽기

```r
read.table("fruits.txt", header = TRUE)
read.csv("fruits_3.csv")
read.csv("fruits_4.csv", header = FALSE, col.names = c('NO','NAME','PRICE','QTY'))
```

### ✔ 쓰기

```r
write.csv(df, "output.csv")
write.table(df, "output.txt")
```

---

## 🛠 자주 사용하는 함수 요약

| 함수 | 설명 |
|------|------|
| `list()` | 리스트 생성 |
| `append()` | 리스트에 요소 추가 |
| `data.frame()` | 데이터프레임 생성 |
| `subset()` | 조건 필터링 |
| `merge()` | 데이터프레임 병합 |
| `mean()` | 평균값 계산 |
| `round()` | 반올림 |
| `rename()` | 변수명 변경 (dplyr) |
| `scan()` | 벡터로 파일 읽기 |
| `readline()` | 한 줄 입력 |
| `readLines()` | 파일 전체 읽기 |
| `read.table()` | 텍스트 테이블 읽기 |
| `read.csv()` | CSV 파일 읽기 |
| `write.csv()` | CSV 파일 저장 |
| `write.table()` | 텍스트 파일 저장 |


# 📅 TIL - Week 6: R 데이터 요약 함수, 사용자 정의 함수, plyr 패키지

## 📌 자주 사용되는 기본 함수

| 함수 | 설명 |
|------|------|
| `aggregate()` | 그룹별 집계 |
| `apply()` | 행/열별 연산 |
| `lapply()` / `sapply()` | 리스트 원소별 연산 (list형 / vector형 출력) |
| `tapply()` | factor 기반 그룹 연산 |
| `mapply()` | 여러 벡터를 동시에 연산 |
| `mean()`, `max()`, `min()` | 평균, 최대/최소값 |
| `var()`, `sd()` | 분산, 표준편차 |
| `sort()`, `rev()` | 정렬, 역순 |
| `summary()` | 데이터 요약 |

### 예시
```r
apply(matrix(1:6, 2), 1, sum)
tapply(Fruits$Sales, Fruits$Fruit, sum)
mapply(sum, v1, v2, v3)
```

---

## 🍎 aggregate 함수

```r
aggregate(Sales ~ Year, Fruits, sum)
aggregate(Sales ~ Fruit, Fruits, max)
aggregate(Sales ~ Fruit + Year, Fruits, max)
```

- 그룹별로 합계/최대값 등의 연산 가능

---

## 🧠 apply 계열 함수

### ✔ apply()
```r
apply(m1, 1, sum)  # 행 기준
apply(m1, 2, max)  # 열 기준
```

### ✔ lapply() / sapply()
```r
lapply(Fruits[,c(4,5)], max)  # list형
sapply(Fruits[,c(4,5)], max)  # 벡터형
```

### ✔ tapply()
```r
tapply(Fruits$Sales, Fruits$Fruit, sum)
```

### ✔ mapply()
```r
mapply(sum, v1, v2, v3)
```

---

## ⚙ 사용자 정의 함수

```r
my1 = function() { return(10) }

my2 = function(a) {
  return(a^2)
}

my3 = function(a, b) {
  return(abs(a - b))
}
```

- 인자를 받아 연산 후 결과 반환
- 조건문도 사용 가능

---

## 🔃 정렬 함수

```r
sort(Fruits$Sales)
sort(Fruits$Sales, decreasing = TRUE)
```

---

## 🧩 plyr 패키지

### ✔ summarise()
```r
ddply(f, 'name', summarise, sum_qty = sum(qty), sum_price = sum(price))
```

- 그룹별 요약
- SQL의 `GROUP BY`와 유사

### ✔ 연도별/과일별 요약
```r
ddply(f, c('year','name'), summarise, max_qty = max(qty), min_price = min(price))
```

### ✔ transform()
```r
ddply(f, 'name', transform, pct_qty = round(qty*100/sum(qty), 2))
```

- 각 행 기준으로 계산 결과도 함께 출력하고 싶을 때 사용

---

## 🧪 데이터 실습 요약

1. 연도/연령별 합계
```r
apply(data1[,2:15], 2, sum) # 연도별
apply(data1[,2:15], 1, sum) # 연령별
```

2. 사용자 정의 함수 호출
```r
my2(3)
my3(2, 3)
```

3. 비율 계산
```r
ddply(f, 'name', transform, pct_qty = round(qty*100/sum(qty), 2))
```

---

## 🛠 자주 사용하는 패키지

- `lubridate`: 날짜 처리
- `dplyr`: 데이터 조작
- `ggplot2`: 시각화
- `googleVis`: 구글 시각화 도구
- `plyr`: 그룹별 요약 및 변환


# 📅 TIL - Week 7: dplyr 패키지로 데이터 조작 실습

## 📦 dplyr 주요 함수

| 함수 | 설명 |
|------|------|
| `filter()` | 조건에 맞는 행 추출 |
| `select()` | 특정 열 선택 |
| `arrange()` | 정렬 |
| `mutate()` | 새로운 열(변수) 생성 |
| `summarise()` + `group_by()` | 집계 (평균, 합계 등) |

---

## 🧪 실습: 야구 성적 데이터

### ✔ 데이터 불러오기
```r
d1 = read.csv("야구성적.csv")
```

---

## 🔍 filter()

```r
filter(d1, 경기 >= 120)
filter(d1, 경기 >= 120 & 득점 >= 80)
filter(d1, 포지션 %in% c('1루수','3루수'))
```

---

## 🎯 select()

```r
select(d1, 선수명, 포지션, 팀)
select(d1, 순위:타수)
select(d1, -홈런, -타점, -도루)
```

---

## 🔗 파이프 연산자 `%>%`

```r
d1 %>%
  filter(타수 >= 400) %>%
  select(선수명, 팀, 경기, 타수)
```

---

## 🔢 arrange()

```r
arrange(타수)       # 오름차순
arrange(desc(타수)) # 내림차순
```

---

## 🧮 mutate() - 새로운 변수 생성

```r
mutate(경기X타수 = 경기 * 타수)
mutate(할푼리 = round(안타 / 타수, 3))
```

- `mutate()`는 기존 컬럼을 기반으로 새로운 컬럼 생성

---

## 📊 summarise() + group_by()

### ✔ 팀별 평균 경기 수
```r
d1 %>%
  group_by(팀) %>%
  summarise(avg = mean(경기, na.rm = TRUE))
```

### ✔ 여러 컬럼 평균
```r
d1 %>%
  group_by(팀) %>%
  summarise(across(c(경기, 타수), mean))
```

---

## 🚨 주의할 점

- `summarise_each()`은 구버전 함수로 권장되지 않음
- `summarise(across(...))` 사용 권장
- `mutate()` 시 오타 조심 (e.g. `득점수`, `득정`은 컬럼명 오류)

---

## 🛠 자주 사용하는 dplyr + pipe 조합

| 조합 예시 | 설명 |
|-----------|------|
| `data %>% filter(...)` | 조건 필터링 |
| `%>% select(...)` | 원하는 열만 보기 |
| `%>% mutate(...)` | 새로운 변수 만들기 |
| `%>% arrange(...)` | 정렬 |
| `%>% group_by(...) %>% summarise(...)` | 그룹화 후 요약 |

---

이 주차에서는 특히 `dplyr`의 파이프 연산자와 함께 쓰는 실전 예제가 많았고, 데이터 필터링과 요약처리에 집중했음.

