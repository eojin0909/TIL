setwd("C:/r_workdata")

Sys.setlocale("LC_ALL", "korean")

library(lubridate)
library(dplyr)
library(ggplot2)
library(googleVis)

library(plyr)

# ggplot2() : plot() 함수의 확장 버전
# ggplot(dataframe, aes(x=x축데이터, y=y축데이터)) + geom_함수

# geom 부분 설정 값
# - stat : 주어진 데이터에서 geom에 필요한 데이터를 생성한다
# - stat_bin : 아래와 같은 데이터를 갖는 dataframe 출력
# 1. count : 각 항목의 빈도수
# 2. deensity : 각 항목의 밀도수
# 3. ncount : count와 같으나 값의 범위가 (0,1)로 스케일링
# 4. ndensity : density와 같으나 값의 범위가 (0.1)로 스케일링

kor = read.table("학생별국어성적_new.txt", header = T, sep = ',')
kor

ggplot(kor, aes(x=이름, y=점수))+geom_point()

# geom_bar() : barplot가 비슷한 역할
ggplot(kor, aes(x=이름, y=점수))+geom_bar(stat='identity')

ggl = ggplot(kor, aes(x=이름, y=점수))+geom_bar(stat='identity', color ='green',size=2, fill='red')

ggl+theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust=1, colour = 'blue', size=8))

kem = read.csv("학생별과목별성적_국영수_new.csv")
kem

skem = arrange(kem, 이름, 과목)
skem

skem2 = ddply(skem, '이름', transform, 누적합계=cumsum(점수))
skem2

skem3 = ddply(skem2, '이름', transform, 누적합계=cumsum(점수), label=cumsum(점수)-0.5*점수)
skem3

gg2 = ggplot(skem3, aes(x=이름, y=점수, fill=과목))+geom_bar(stat='identity', position = position_stack(reverse = T))+geom_text(aes(y=label, label=paste(점수,'점')),color='black',size=4)+guides(fill=guide_legend(reverse = T))

gg2+theme(axis.title.x = element_text(angle = 45, hjust = 1, vjust = 1, color = 'black',size=8))


# geom_segment()를 사용한 롤리팝 그래프의 표현

install.packages("gridExtra")
library(gridExtra)
mtcars
View(mtcars)
mt = mtcars

# x축과 연결된 롤리팝 그래프
# x축으로 부터 수직선으로 연결된 그래프를 그리는 경우 geom_segment()의 aes() 맵핑변수로
# xend=변수x, yend=0으로 설정

gg1 = ggplot(mt, aes(x=mpg, y=disp))
gg1 + geom_segment(aes(xend=mpg, yend=0, color=gear), size=1.3)+geom_point(aes(color=gear),size=6)+scale_color_continuous(type = "gradlient")+theme_minimal()

# y축과 연결된 롤리팝 그래프
# 위와 반대로 y축으로 부터 수평선으로 연결된 그래프를 그리는 경우 geom_segment()의 aes() 맵핑변수로
# xend=0, yend=변수y으로 설정

gg1 = ggplot(mt, aes(x=mpg, y=disp))
gg1 + geom_segment(aes(xend=0, yend=disp, color=gear), size=1.3)+geom_point(aes(color=gear),size=6)+scale_color_continuous(type = "viridis")+theme_minimal()


# geom_point()

g1 = ggplot(mt, aes(x=hp, y=mpg))
g1+geom_point()

g2 = g1+geom_point(color='pink')
g2

g3 = g1+geom_point(aes(color=facter(am)))
g3

g4 = g1+geom_point(size=7)
g4

g5 = g1+geom_point(aes(size=wt))
g5

g6 = g1+geom_point(aes(size=wt, shape=factor(am)))
g6

g7 = g1+geom_point(aes(size=wt, shape=factor(am), color=factor(am)))
g7

g8 = g1+geom_point(aes(size=wt, shape=factor(am), color=factor(am)))+scale_color_manual(values = c('pink','red'))
g8

g9 = g1+geom_point(aes(size=wt, shape=factor(am), color=factor(am)))+scale_color_manual(values = c('pink','red'))+geom_line()
g9

g10 = g1+geom_point(aes(size=wt, shape=factor(am), color=factor(am)))+scale_color_manual(values = c('pink','red'))+geom_line()+labs(x='마력', y='연비')
g10

# geom_line()
th = read.csv("학생별과목별성적_3기_3명.csv")
th
ss=arrange(th, 이름, 과목)
ss

ggplot(ss, aes(x=과목, y=점수, group=이름, color=이름))+geom_line()+geom_point(size=6, shape=9)
# shape : 0~25까지 존재함

install.packages("multilinguer")
library(multilinguer)

install.packages(c('string','hash','tau','Sejong','RSQLite','devtools'))

install.packages("remotes")
remotes::install_github("haven-jeon/koNLP", upgrade='never',INSTALL_opts=c("--no-multiarch"),force = TRUE)

library(KoNLP)

useSejongDic()

install.packages("wordcloud")
install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)

getwd()
# setwd("/Cloud/project")

#1. 데이터에서 단어만 추출
d1 = readLines("BTS유엔연설_국문.txt")
d1

d2=sapply(d1,extractNoun,USE.NAMES=F)

d3= unlist(d2)

d3=Filter(function(x){
  nchar(x)>= 2
}, d3)

write(unlist(d3),"BTS_kor.txt")
d4=read.table("BTS_kor.txt")
d4
wc=table(d4)

pal=brewer.pal(9,"Set3")
wordcloud(names(wc),freq=wc,scale=c(5,1),rot.per=0.25, min.freq = 2, random.color = T, random.order  =F, colors =pal)
