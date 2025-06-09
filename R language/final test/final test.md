# R language final test summary

---

## 1️⃣ 반복문 작성 (for, while, repeat)

**예시 1: for문 - 벡터의 값 제곱**
```r
v <- c(1,2,3,4,5)
for (i in v) {
  print(i^2)
}
```

**예시 2: while문 - 1부터 5까지 누적합**
```r
i <- 1; sum <- 0
while (i <= 5) {
  sum <- sum + i
  i <- i + 1
}
print(sum) # 15
```

---

## 2️⃣ 결측치 확인 및 제거 (is.na, %in%)

**예시 1: 결측치(NA) 개수 확인**
```r
df <- data.frame(a=c(1,NA,3), b=c(4,5,NA))
sum(is.na(df))      # 전체 NA 개수
rowSums(is.na(df))  # 각 행별 NA 개수
```

**예시 2: 결측치가 있는 행 제거**
```r
df_no_na <- na.omit(df)
```

**예시 3: 특정값을 결측치 대용으로 간주 후 제거**
```r
df <- data.frame(a=c(1,-99,3), b=c(4,5,-99))
df_clean <- df[!(df$a %in% c(-99) | df$b %in% c(-99)), ]
```

---

## 3️⃣ 이상치 확인 및 제거 (boxplot, hist)

**예시 1: boxplot을 이용한 이상치 시각화**
```r
v <- c(1,2,3,100,4,5)
boxplot(v)$stats # 사분위수 등
```

**예시 2: boxplot의 이상치를 NA로 처리**
```r
outliers <- boxplot(v)$out
v[v %in% outliers] <- NA
```

---

## 4️⃣ dplyr 패키지 사용법

- **filter()**: 행 추출
- **select()**: 열 추출
- **mutate()**: 변수 추가/변환
- **arrange()**: 정렬
- **summarise() + group_by()**: 그룹별 요약
- **across()**: 여러개의 열을 업

**예시 1: 결측치가 없는 행만 추출 후 평균**
```r
library(dplyr)
df %>% filter(!is.na(a)) %>% summarise(mean_a = mean(a))
```

**예시 2: group_by + summarise**
```r
df %>% group_by(b) %>% summarise(mean_a = mean(a, na.rm=TRUE))
```

---

## 5️⃣ barplot/ggplot2 활용 (막대그래프)

**예시 1: barplot()을 이용한 벡터 막대그래프**
```r
v <- c(5, 7, 8)
barplot(v, names.arg = c("A", "B", "C"), col="skyblue")
```

**예시 2: ggplot2를 이용한 데이터프레임 막대그래프**
```r
library(ggplot2)
df <- data.frame(name=c("A","B","C"), score=c(10,15,8))
ggplot(df, aes(x=name, y=score)) + geom_bar(stat='identity', fill="tomato")
```

---

## 🏆 시험 단기 요약 TIP

- **반복문**: for( i in ... ), while, repeat
- **결측치**: is.na(), na.omit(), %in%로 특정값 처리
- **이상치**: boxplot(), 이상치 NA처리
- **dplyr**: filter, select, mutate, arrange, summarise, group_by
- **barplot**: 벡터/행렬, names.arg
- **ggplot2**: geom_bar(stat='identity'), aes, fill

---
