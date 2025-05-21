setwd("c:/r_workdata")

Sys.setlocale("LC_ALL", "korean")

library(lubridate)
library(dplyr)
library(ggplot2)
library(googleVis)

library(plyr)

# 히스토그램( 특정데이터의 빈도수를 막대러 나타낸 것 ) : hist()
h=c( 182,175,167,163,172,181,166,159,155)
hist(h, main="HIST")

# pie() : 전체 합이 100이 되어야하는 경우 서로를 비교할 때 사용
p1 = c(11,19,33,37) 
pie(p1)

pie (p1, radius=1, init.angle=90)
pie (p1, radius=1, init.angle=90, col = rainbow(length(p1)), labels = c('w1','w2','w3','w4'))

# 수치값 출력
pct = round(p1/sum(p1)*100,1)
lab=paste(pct,'%')

pie (p1, radius=1, init.angle=90, col = rainbow(length(p1)), labels = lab)
legend(0.8, 1.1, c('w1','w2','w3','w4'), cex=0.5, fill=rainbow(length(p1)))

pct = round (p1/sum(p1)*100,1)
lab1=c('w1','w2','w3','w4')
lab2=paste(lab1,'\n', pct,'%')
pie (p1, radius=1, init.angle=90, col = rainbow(length(p1)), labels = lab2)

# pie3D
install.packages("plotrix")
library(plotrix)

pct = round(p1/sum(p1)*100,1)
lab1=c('w1','w2','w3','w4')
lab2=paste(lab1,'\n', pct,'%')
pie3D (p1, radius=1, init.angle=90, col = rainbow(length(p1)), labels = lab2, explode = 0.05)

# 상자차트 ( 최대, 최소, 중앙값등을 한눈에 본다 ) : boxplot()
v1=c(10,12,15,11,20)
v2=c(5,7,15,8,9)
v3=c(11,20,15,18,13)
boxplot(v1,v2,v3)

boxplot(v1,v2,v3, col = c('blue','yellow','red'), names = c('BLUE','YELLOW','RED'), horizontal = T)

# 관계도 그리기 : igraph()
# 서로 연관있는 데이터들을 연결해서 표현해준다. 소셜네트워크망 만들때 사용
install.packages("igraph")
library(igraph)

g1=graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6))
g1
plot(g1)

name = c('홍길동대표','일지매부장','김유신과장','손흥민대리','윤봉길길대리','이순신부장','유관순과장','신사임당대리','강감찬부장','광개토과장','정몽주대리')

pemp = c('홍길동대표','홍길동대표','일지매부장','김유신과장','김유신과장','홍길동대표','이순신부장','유관순과장','홍길동대표','강감찬부장','광개토과장')

emp=data.frame(이름=name, 상사이름=pemp)
emp

g = graph.data.frame(emp, directed = T)
plot(g, layout=layout.fruchterman.reingold, vertex.size=5, edge.arrow.size=0.3)

plot(g, layout=layout.fruchterman.reingold, vertex.size=5, edge.arrow.size=0, vertex.label=NA)

dev.new()
plot(g, layout=layout.fruchterman.reingold, vertex.size=5, edge.arrow.size=0.3)

savePlot('network.png', type = 'png')

install.packages("devtools")
library(devtools)
install_github("christophergandrud/d3Network")
install.packages("RCurl")
library(RCurl)
library(d3Network)

d3SimpleNetwork(emp, width = 600, height = 600, file = 'c:/r_workdata/d3.html')

# 데이터정제
# 빠진데이터찾기 : 결측치 정제
# 결측치 = 누락된 값, 비어있는 값
# 결측치가 포함되어 있으면 함수사용 불가, 분석결과 외곡 / 제거 후 분석

df = data.frame(gender=c('M','F',NA,'M','F'), score=c(5,4,3,4,NA))
df

# 결측치 확인
is.na(df)
table(is.na(df))
table(is.na(df$gender))
table(is.na(df$score))

mean(df$score)

# 결측치 제거
# 결측치가 포함되있는 행 제거

df %>% 
  filter(is.na(score))

df %>% 
  filter(!is.na(score))

# 결측치 제거한 데이터로 분석
df1 = df %>% 
  filter(!is.na(score))

mean(df1$score)
sum(df1$score)

df1

# 여러 변수에 동시에 결측치없는 데이터 추출
df1 = df %>%
  filter(!is.na(score) & !is.na(gender))
df1

df

# 결측치가 하나라도 있으면 제거 : na.omit
df2 = na.omit(df)
df2

# 함수에 결측치 제외 기능 : na.rm=T
mean(df$score, na.rm = T)

exam = read.csv("csv_exam.csv")
exam

exam[c(3,8,15),'math'] = NA
exam

exam %>%
  summarise(mean_math=mean(math))

exam %>%
  summarise(mean_math=mean(math, na.rm=T))

# 결측치 대체하기
# - 결측치가 많을 경우 제외하면 데이터 손실이 큼
# - 대안 : 다른 값 채워 넣기
# 
# 결측치 대체법
# - 대표값으로 일괄대체 : 평균, 최빈값, 중앙값
# - 통계분석기법, 예측값 추정해서 대체
# 
# 평균값으로 대체

mean(exam$math, na.rm =T)

exam$math = ifelse(is.na(exam$math), 55, exam$math)
exam$math

mean(exam$math)

# 이상치 : 정상범주에서 크게 벗어난 값
# - 포함시 분석 결과 왜곡
# - 결측 처리 후 제외하고 분석
# 
# 이상치 종류
# - 존재할 수 없는 값 : 결측처리
# - 극단적인 값 : 정상범위 기준을 정해서 결측처리
# 
# 이상치 제거 : 존재할 수 없는 값을 없애줌

out = data.frame(gender=c(1,2,1,3,2,1), score=c(5,4,3,4,2,6))
out

# 이상치 확인
table(out$gender)
table(out$score)

# 결측처리
# 한개가 들어왔을땐 1번방법
out$gender = ifelse(out$gender == 3, NA, out$gender)
# 두개이상은 2번방법이 효과적임
out$gender = ifelse(out$gender %in% c(1,2), out$gender,NA)

out$score = ifelse(out$score > 5, NA, out$score)
out

# 결측처리 후 분석
out %>%
  filter(!is.na(gender) & !is.na(score))%>%
  group_by(gender) %>%
  dplyr :: summarise(mean_score=mean(score))

# 이상치 제거 : 극단적인 값
# - 정상범주에서 크게 벗어나면 결측처리
# 
# 판단기준
# - 논리적 판단
# - 통계적 판단 : boxplot()

library(ggplot2)
mpg

boxplot(mpg$hwy)
boxplot(mpg$hwy) $ stats

# 결측처리
mpg$hwy = ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외하고 분석
mpg %>%
  filter(!is.na(hwy))%>%
  group_by(drv) %>%
  dplyr::summarise(mean_hwy=mean(hwy))

mpg
mpg[c(65,124,131,153,212), 'hwy'] =NA

# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지
# 알아보려고 한다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지
# 확인해야 한다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보자.

mpg$hwy
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 
# hwy 평균이 높은지 알아보자. 하나의 dplyr 구문으로 만들어야한다.

mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  dplyr::summarise(mean_hwy = mean(hwy))





























