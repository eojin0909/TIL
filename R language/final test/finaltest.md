
# R 실습문제 코드 & 설명 정리 (주석 포함)

## 1번 문제(형식 2): 조건별 색상 barplot

```r
# x1: 막대그래프에 쓸 데이터 벡터 생성
x1 = c(100, 130, 190, 160, 150, 220)
par(mfrow = c(1,1))  # 한 화면에 1개의 그래프

# (1) 함수로 색상 구분해주는 방법
v1 = function(f){
  colors = NULL  # 결과를 저장할 벡터 (초기화)
  for (i in 1:length(f)){  # 각 원소별로 반복
    if (f[i] >= 200) {      # 200 이상이면 빨간색
      colors[i] = 'red'
    } else if (f[i] >= 180) { # 180~199는 노란색
      colors[i] = 'yellow'
    } else {                  # 그 외(179 이하)는 초록색
      colors[i] = 'green'
    }
  }
  return(colors)  # 색상 벡터 반환
}
barplot(x1, col = v1(x1))  # 구한 색상을 적용하여 막대그래프 출력

# (2) 반복문 직접 사용 (range() 대신 1:length(x1)! 중요)
colors = c()  # 색상 저장할 벡터
for (i in 1:length(x1)){
  if (x1[i] >= 200) {
    colors[i] = 'red'      # 200 이상 빨간색
  } else if (x1[i] >= 180) {
    colors[i] = 'yellow'   # 180~199 노란색
  } else {
    colors[i] = 'green'    # 179 이하 초록색
  }
}
barplot(x1, col = colors)  # 색상 지정하여 막대그래프 출력
```

> **주의:**  
> - R에서 반복문 인덱스는 `1:length(x1)` 혹은 `seq_along(x1)` 사용  
> - `range()`는 파이썬 함수임!  
> - 색상은 벡터 인덱스로 할당

---

## 2, 3, 4번 문제: dplyr로 그룹별 요약

```r
library(dplyr)  # dplyr 패키지 로드

# hwy 결측치 제외 & 구동방식별 hwy 평균 구하기
mpg %>%
  filter(!is.na(hwy)) %>%     # 결측치(NA) 제외
  group_by(drv) %>%           # drv별 그룹화
  summarise(mean_hwy = mean(hwy))  # 그룹별 평균
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
# dplyr 사용: 누적합계, 라벨 위치 계산
kem2 <- kem %>%
  group_by(이름) %>%
  mutate(
    누적합계 = cumsum(점수),           # 각 이름별 누적합계
    lab = 누적합계 - 점수 / 2         # 막대 레이블 표시 위치
  )

# plyr 사용: 같은 작업 (구형 스타일)
library(plyr)
ddply(kem, '이름', transform, 누적합계 = cumsum(점수), lab = cumsum(점수) - 점수/2)
```
- 둘 다 누적합계, 라벨 위치 계산 목적  
- dplyr이 최신 스타일 & 속도 빠름

---

## 5번 문제: ggplot2로 막대그래프 + 레이블

```r
library(ggplot2)  # ggplot2 패키지 로드

# 이름별 점수 막대그래프, 레이블도 표시
ggplot(kor, aes(x = 이름, y = 점수)) +
  geom_bar(stat = 'identity', color = 'blue', fill = 'pink') +          # 막대그래프(파란테두리, 핑크색)
  geom_text(aes(label = paste(점수, '점수')), color = 'black', size = 4) # 막대 위에 '점수' 레이블 표시
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
