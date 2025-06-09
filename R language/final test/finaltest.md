# R 프로그래밍 심화 정리: 반복문, 결측치/이상치 처리, dplyr, 시각화

---

## 🔁 반복문 (for문, while문)

### ✅ for 문

```r
for (i in 1:5) {
  cat("반복 중인 숫자:", i, "\n")
}
```

- `cat()`은 `print()`보다 출력이 간결하며 줄바꿈 조절 가능
- `1:5`는 시퀀스 생성

### ✅ while 문

```r
x <- 1
while (x <= 5) {
  cat("현재 x:", x, "\n")
  x <- x + 1
}
```

- 조건이 TRUE인 동안 반복 수행
- 무한 루프 방지 위해 내부에서 변수 갱신 필수

---

## ❓ 결측치(NA) 처리

### ✅ 결측치 확인

```r
# 전체 데이터 프레임에 NA 포함 여부
any(is.na(df))

# 열별 NA 개수 확인
colSums(is.na(df))
```

### ✅ 결측치 제거

```r
# NA 포함된 행 제거
df_clean <- na.omit(df)

# 특정 열 기준 NA 제거
df <- df[!is.na(df$column_name), ]
```

### ✅ 결측치 대체

```r
# 평균으로 대체 (NA를 평균값으로)
df$column_name[is.na(df$column_name)] <- mean(df$column_name, na.rm = TRUE)
```

---

## ⚠️ 이상치 처리 (Outliers)

### ✅ 시각적 확인: boxplot

```r
boxplot(df$column, main = "Boxplot for 이상치 확인", col = "orange")
```

### ✅ 통계적 제거 (IQR 기준)

```r
Q1 <- quantile(df$column, 0.25)
Q3 <- quantile(df$column, 0.75)
IQR <- Q3 - Q1

lower <- Q1 - 1.5 * IQR
upper <- Q3 + 1.5 * IQR

df_no_outliers <- subset(df, df$column >= lower & df$column <= upper)
```

- 이상치 기준은 통상적으로 `1.5 * IQR`
- 필요시 `3 * IQR`도 사용

---

## 📦 dplyr 패키지 실전 예시

```r
library(dplyr)

df %>%
  filter(score > 80) %>%
  select(name, score) %>%
  arrange(desc(score)) %>%
  mutate(grade = ifelse(score >= 90, "A", "B")) %>%
  summarise(평균 = mean(score), 최대 = max(score))
```

| 함수        | 설명                              |
|-------------|-----------------------------------|
| `filter()`  | 행 필터링                         |
| `select()`  | 열 선택                            |
| `arrange()` | 정렬 (`desc()`로 내림차순)         |
| `mutate()`  | 새로운 열 추가                     |
| `summarise()` | 집계 함수 사용                   |

---

## 📊 시각화: barplot vs ggplot2

### ✅ 기본 barplot

```r
sales <- c(100, 200, 150, 250, 300)
names(sales) <- c("MON", "TUE", "WED", "THU", "FRI")

barplot(sales,
        main = "요일별 판매량",
        col = rainbow(5),
        ylim = c(0, 400),
        ylab = "판매량",
        cex.names = 0.9,
        border = "black")
```

### ✅ ggplot2 막대그래프 (범주형 시각화)

```r
library(ggplot2)

df <- data.frame(
  day = factor(c("MON", "TUE", "WED", "THU", "FRI"),
               levels = c("MON", "TUE", "WED", "THU", "FRI")),
  sales = c(100, 200, 150, 250, 300)
)

ggplot(df, aes(x = day, y = sales, fill = day)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "요일별 판매량", x = "요일", y = "판매량") +
  theme_minimal()
```

- `fill = day`: 요일에 따라 색 다르게
- `scale_fill_brewer()`: 예쁜 색 팔레트
- `theme_minimal()`: 깔끔한 테마 적용

---

## ✅ 마무리 팁

- `for`와 `while`은 꼭 **조건 종료 제어**를 넣을 것
- `dplyr` 파이프라인은 `|>` 대신 `%>%`로 연결 (tidyverse 스타일)
- `ggplot2`는 데이터 시각화에서 가장 강력한 도구 중 하나

