setwd("c:/r_workdata")

Sys.setlocale("LC_ALL", "korean")

library(lubridate)
library(dplyr)
library(ggplot2)
library(googleVis)

library(plyr)

# 그래픽 기초
# plot() : 분포도나 꺽은 선
# plot(y축데이터, 옵션)
# plot(x축데이터, 옵션)
# plot(x축, y축, 옵션)

v1 = c(2,2,2)
plot(v1)

# x축, y축
x = 1:3
y = 3:1
plot(x,y)

# x축, y축의 한계값 지정
plot(x, y, xlim = c(1, 10), ylim = c(1, 5))

# 축제목 : xlab, ylab, main : 그래픽 제목
plot(x, y, xlim = c(1,10), ylim = c(1,5), xlab = "x 축값", ylab = "y 축값", main = "PLOT TEST")

# 창을 지우고 다시 그린다
plot.new()
# 새로운 창에서 다시 그린다
dev.new()

v1 = c(100, 130, 120, 160, 150)
plot(v1, type = 'o', col = 'red',ylim = c(0,200), axes=F, ann = F )
# axes = 그래프 테두리 옵션
# ann = 타이틀 제목 옵션
 
axis(1, at=1:5, lab=c('MON','TUE', 'WED', 'THU', 'FRI'))
axis(2, ylim = C(0,200))
title(main='FRUITS', col.main = 'red', font.main = 4)
title(xlab = 'DAY', col.lab = 'black')
title(ylab = 'PRICE', col.lab = 'blue')

# 그래프의 배치조정 : mfrow
# par(mfrow = c(nr, nc))

par(mfrow = c(3,3))
plot(v1, type = 'b') # type = 'b'는 점과 선으로 이루어진 그래프 생성
plot(v1, type = 'l') # type = 'l'는 선으로 이루어진 그래프 생성
plot(v1, type = 'p') # type = 'p'는 점으로 이루어진 그래프 생성
plot(v1, type = 'c') # type = 'c'는 type = 'b'에서 점을 생략한 그래프 생성
plot(v1, type = 'o') # type = 'o'는 점과 선이 중첩된 그래프 생성
plot(v1, type = 'h') # type = 'h'는 각 점에서 x축까지의 수직선 그래프 생성
plot(v1, type = 'n') # type = 'n'는 축만 표현
plot(v1, type = 's') # type = 's'는 왼쪽시작 계단형 그래프 생성
plot(v1, type = 'S') # type = 'S'는 오른쪽시작 계단형 그래프 생성


par(mfrow = c(1,3))
pie(v1)
plot(v1, type = 'o')
barplot(v1)

par(mfrow = c(1,1))
a = c(1,2,3)
plot(a, xlab='aaa')


# 그래프의 여백 조정
# mgp = c(제목위치, 지표값 위치, 지표선 위치)
par(mgp = c(2,1,1))
plot(a, xlab = 'aaa')

# oma(outside margine) : 그래프의 전체 여백을 조정
# oma(bottom, left, top, right)

par(oma = c(2,1,1,1))
plot(a, xlab='aaa')


# 여러개의 그래프를 중점으로 그리기
# par(new = T, add = T)
v1 = c(1,2,3,4,5)
v2 = c(5,4,3,2,1)
v3 = c(3,4,5,6,7)

plot(v1, type = 's', col = 'red', ylim = c(1,5))
par(new = T)
plot(v2, type = 'o', col = 'blue', ylim = c(1,5))
par(new = T)
plot(v3, type = 'l', col = 'green')


# lines에 적은 ylim는 위에서 plot로 이미 ylim을 정해줬기때문에 lines에 적힌 ylim은 효과가 없다
plot(v1, type = 's', col = 'red', ylim = c(1,10) )
lines(v2, type = 'o', col = 'blue', ylim = c(1,5))  
lines(v3, type = 'o', col = 'green', ylim = c(1,100))

# 범례추가
# legend(x축, y축, 내용, cex = 글자크기, col = 색상,pch = 크기, lty = 선모양)
legend(4, 9, c('v1','v2','v3'), cex = 0.9, col = c('red','blue', 'green'), lty = 1) # ;lty : 0~6

# barplot() : 막대그래프
x = c(1,2,3,4,5)
barplot(x)

# 가로막대형 : horiz = T
barplot(x, horiz = T)

# 그룹으로 묶어서 출력 : beside = T
x = matrix(c(5,4,3,2), 2)
x
barplot(x, beside = T, names=c(5,3), col = c('green', 'yellow'))

# 그룹으로 묶어서 가로로 출력
barplot(x, beside = T, names=c(5,3), col = c('green', 'yellow'), horiz = T)

# 하나의 막대로 가로출력
barplot(x, names=c(5,3), col = c('green', 'yellow'), horiz = T, xlim = c(0,12))

# 여러 막대를 그룹으로 묶어서 한꺼번에 출력
v1 = c(100,120,140,160,180)
v2 = c(123,12,150,140,170)
v3 = c(140,170,120,110,160)

qty = data.frame(MANANA = v1, VHERRY = v2, ORANGE = v3)
qty

# barplot을 그룹으로 묶어서 출력할때는 반드시 출력대상이 matrix여야 한다
class(qty)
barplot(as.matrix(qty), main = 'FRUIS SALES', beside = T, col = rainbow(nrow(qty)), ylim = c(0,400))
legend(14, 400, c('MON','TUE','WED','THU','FRI'), cex = 0.8, fill = rainbow(nrow(qty)))

t(qty)
barplot(t(qty), main = 'FRUITS SALES', col = rainbow(length(qty)),ylim = c(0,400), names.arg = c('MON','TUE','WED','THU','FRI'), cex.axis = 0.8, las = 1, cex = 0.8, beside = T)
legend(0.2, 300, names(qty), cex = 0.8, fill = rainbow(length(qty)))

# 조건을 주고 그래프 그리기
# peach값이 200이상 red, 180~199 yellow, 그 이하 green
peach = c(180,200,250,198,170)

colors = c()
for (i in 1 : length(peach)) {
  if (peach[i] >= 200) {
    colors = c(colors,'red')
  } else if (peach[i] >= 180){
    colors = c(colors, 'yellow')
  } else {
    colors = c(colors, 'green')
  }
}

barplot(peach, main = 'PEACH SALES', names.arg = c('MON','TUE','WED','THU','FRI'), col = colors)

# 매개변수가 있는 함수 처리
 f1 = function(f){
   colors = NULL
   for (i in 1:length(f)) {
     if (f[i]>=200) {
      colors[i] = 'blue'
    } else if (f[i] >= 180) {
      colors[i] = 'pink'
    } else {
      colors[i] = 'green'
    }
   }
   return(colors)
}

f1(peach)
barplot(peach, main = 'PEACH SALES', names.arg = c('MON','TUE','WED','THU','FRI'))

# 실습

plot(v1, type = 'b') # type = 'b'는 점과 선으로 이루어진 그래프 생성
plot(v1, type = 'l') # type = 'l'는 선으로 이루어진 그래프 생성
plot(v1, type = 'p') # type = 'p'는 점으로 이루어진 그래프 생성
plot(v1, type = 'c') # type = 'c'는 type = 'b'에서 점을 생략한 그래프 생성
plot(v1, type = 'o') # type = 'o'는 점과 선이 중첩된 그래프 생성
plot(v1, type = 'h') # type = 'h'는 각 점에서 x축까지의 수직선 그래프 생성
plot(v1, type = 'n') # type = 'n'는 축만 표현
plot(v1, type = 's') # type = 's'는 왼쪽시작 계단형 그래프 생성
plot(v1, type = 'S') # type = 'S'는 오른쪽시작 계단형 그래프 생성


x1 = c(100,130,190,160,150,220)

# 1. 한 화면에 6개의 그래프를 나타내어라
par(mfrow = c(2,3))

# 2. 점과 선의 조합으로 이루어진 그래프 출력
plot(x1, type = 'b')

# 3. 가로출력
barplot(x1, horiz = T)

# 4. 그룹으로 묶어서 출력
v1 = matrix(x1,2,3)
v1
barplot(v1, beside = T, names.arg = c(1,2,3), col = c('green','yellow'))

# 5. 그룹으로 묶어서 가로 출력
barplot(v1, col = c('green','yellow'), names.arg = c(1,2,3), horiz = T)

# 6. 하나의 막대그래프로 가로로 출력
barplot(v1, names.arg = c(1,2,3), col = c('green','yellow'), xlim = c(0,500), horiz = T)

# 7. 하나의 막대그래프로 세로로 출력
barplot(v1, names.arg = c(1,2,3), col = c('green','yellow'), ylim = c(0,500))


# 8. 조건을 주고 그래프 그리기 : 한화면에 하나의 그래프로 표현
#     x1값이 200이상 red, 180~199 yellow, 그 이하 green
par(mfrow = c(1,1))
colors = c()
for (i in 1 : length(x1)) {
  if (x1[i] >= 200) {
    colors = c(colors,'red')
  } else if (x1[i] >= 180){
    colors = c(colors, 'yellow')
  } else {
    colors = c(colors, 'green')
  }
}
barplot(x1, main = 'X1', col = colors)


















