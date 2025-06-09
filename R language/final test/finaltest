# R 문법 정리: 반복문, 결측치/이상치 처리, dplyr, 시각화

---

## 🔁 반복문 작성 (for문)

```r
for (i in 1:5) {
  print(paste("현재 숫자:", i))
}
```

- `1:5` 범위에서 `i`가 반복됨
- `paste()`는 문자열과 숫자 연결

---

## ❓ 결측치 확인 및 제거

```r
# 결측치 확인
is.na(data)

# 결측치가 포함된 행 확인
sum(is.na(data$column_name))

# 결측치 제거
clean_data <- na.omit(data)
```

- `is.na()` : NA인지 여부 확인
- `na.omit()` : NA가 있는 행 제거

---

## ⚠️ 이상치 확인 및 제거

### 📈 boxplot(상자그림) 이용

```r
boxplot(data$column_name)
```

- 박스플롯으로 이상치 시각화
- 상자 밖 점들이 이상치

### 이상치 수동 제거 예시

```r
q1 <- quantile(data$column_name, 0.25)
q3 <- quantile(data$column_name, 0.75)
iqr <- q3 - q1

# 이상치 제거
filtered <- subset(data, data$column_name >= (q1 - 1.5*iqr) & data$column_name <= (q3 + 1.5*iqr))
```

---

## 📦 dplyr 패키지 사용법

```r
library(dplyr)

# 열 선택
select(data, column1, column2)

# 조건 필터링
filter(data, column1 > 10)

# 그룹 요약
data %>%
  group_by(group_col) %>%
  summarise(mean_val = mean(target_col, na.rm = TRUE))
```

---

## 📊 barplot / ggplot2 막대그래프 예시

### 기본 barplot

```r
qty <- c(100, 200, 150, 250, 300)
names(qty) <- c("MON", "TUE", "WED", "THU", "FRI")
barplot(qty, main = "요일별 판매량", col = rainbow(5))
```

### ggplot2 막대그래프

```r
library(ggplot2)
df <- data.frame(day = c("MON", "TUE", "WED", "THU", "FRI"), sales = c(100, 200, 150, 250, 300))

ggplot(df, aes(x = day, y = sales)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "요일별 판매량", x = "요일", y = "판매량")
```

---
