
# R 실습문제 코드 & 설명 정리

## 1번 문제(형식 2): 조건별 색상 barplot

```r
# 값에 따라 색상을 다르게 지정하여 barplot 출력

x1 = c(100, 130, 190, 160, 150, 220)
par(mfrow = c(1,1))  # 한 화면에 1개의 그래프

# (1) 함수로 구현
v1 = function(f){
  colors = NULL
  for (i in 1:length(f)){
    if (f[i] >= 200) {
      colors[i] = 'red'
    } else if (f[i] >= 180) {
      colors[i] = 'yellow'
    } else {
      colors[i] = 'green'
    }
  }
  return(colors)
}
barplot(x1, col = v1(x1))

# (2) 반복문 직접 사용 (range() 대신 1:length(x1)!)
colors = c()
for (i in 1:length(x1)){
  if (x1[i] >= 200) {
    colors[i] = 'red'
  } else if (x1[i] >= 180) {
    colors[i] = 'yellow'
  } else {
    colors[i] = 'green'
  }
}
barplot(x1, col = colors)
```

> **주의:**  
> - R에서 반복문 인덱스는 `1:length(x1)` 혹은 `seq_along(x1)` 사용  
> - `range()`는 파이썬 함수임!  
> - 색상은 벡터 인덱스로 할당

---

## 2, 3, 4번 문제: dplyr로 그룹별 요약

```r
library(dplyr)

# hwy 결측치 제외 & 구동방식별 hwy 평균 구하기
mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
```
- `filter(!is.na(hwy))`: 결측치(NA) 제거  
- `group_by(drv)`: drv별 그룹화  
- `summarise(mean_hwy = mean(hwy))`: 평균 구하기

> **참고:**  
> - `%in%`은 벡터 조건 추출에 씀  
> - `hwy[hwy %in% hwy[!is.na(hwy)]]` 처럼도 사용 가능

---

## 누적합계 & 레이블 계산 (dplyr vs plyr)

```r
# dplyr 사용
kem2 <- kem %>%
  group_by(이름) %>%
  mutate(
    누적합계 = cumsum(점수),
    lab = 누적합계 - 점수 / 2
  )

# plyr 사용
library(plyr)
ddply(kem, '이름', transform, 누적합계 = cumsum(점수), lab = cumsum(점수) - 점수/2)
```
- 둘 다 누적합계, 라벨 위치 계산 목적  
- dplyr이 최신 스타일 & 속도 빠름

---

## 5번 문제: ggplot2로 막대그래프 + 레이블

```r
library(ggplot2)

ggplot(kor, aes(x = 이름, y = 점수)) +
  geom_bar(stat = 'identity', color = 'blue', fill = 'pink') +
  geom_text(aes(label = paste(점수, '점수')), color = 'black', size = 4)
```
- `geom_bar(stat = 'identity')`: 점수(y축) 막대그래프  
- `color`: 테두리색, `fill`: 내부색  
- `geom_text()`: 막대 위에 점수 레이블 표시

---

## 기타 팁/주의

- **range() vs 1:length(x):**  
  R 반복문 인덱스는 1:length(x) 혹은 seq_along(x)로!  
  (range()는 값의 범위 반환이니 혼동 주의)
- **dplyr 주요 함수:**  
  filter(), group_by(), summarise(), mutate() 등 활용  
- **색상 벡터:**  
  colors <- character(length(x1))로 미리 길이 선언 가능

---
