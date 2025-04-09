setwd("c:r_workdata")

Sys.setlocale("LC_ALL", "korean")

library(lubridate)

# 서로 다른 데이터 타입 처리 객체
# 1. list
# - 벡터와 비슷한 형태(키, 값)로 저장

l1 = list(name = '홍길동',
          addr = '서울',
          tel = '010-1111-1111',
          pay = 500)
l1

# 특정 키만 조회
l1$addr

# list에 요소를 추가 / 삭제
l1$birth = '2002'
l1$birth

# 기존 이름을 삭제하고 추가
l1$name = c('고길동', '마이콜')
l1$name

# 삭제 안하고 추가
l1$name[length(l1$name)+1] = '홍길동'
l1$name

# 삭제 안하고 원하는 위치에 추가
# append()사용
l1$name  = append(l1$name, '둘리', after = 1)
l1$name

#list 삭제
# 1. 특정 값을 삭제
l1$name[length(l1$name)-1] = NA
l1$name

# 2. list 키 삭제
l1$birth = NULL
l1$birth

# dataframe (이게 더 효율적)
# 1. 각 컬럼(라벨)별로 먼저 생성 후 data.frame으로 모든 컬럼을 합침
no = c(1,2,3,4)
name = c('apple','banana','peach','grape')
price = c(500,200,100,300)
qty = c(5,2,4,7)

sales = data.frame(NO = no, NAME = name, PRICE = price, QTY =qty)
sales
class(sales)
str(sales)

# 2. 행렬로 생성
sales2 = matrix(c(1,'Apple',500,5,
                 2, 'Peach',200,2,
                 3, 'Banana',50,4,
                 4,'Grape',100,7),4, by=T)
sales2

d1 = data.frame(sales2)
d1

names(d1) = c('NO', 'NAME', 'PRICE', 'QTY')
d1
class(d1)
str(d1)

# 데이터 조회
sales
sales$NAME
sales[1,3]
sales[,2]
sales[3,]
sales[c(1,3),]
sales[,c(2,4)]
sales[,c(1:3)]

# 원하는 조건만 검색 가능 : subset()
subset(sales, QTY <= 5)
subset(sales, PRICE == 200)
subset(sales, NAME == 'apple')

# 데이터 추가 / 합치기 : rbind(), cbind(), merge()
no = c(1,2,3)
name = c('apple','banana','peach')
price = c(100,200,300)
df1 = data.frame(NO=no, NAME=name, PRICE=price)
df1

no = c(10,20,30)
name = c ('train','car','ship')
price = c(1000,2000,3000)
df2 = data.frame(No=no, NAME=name, PRICE=price)

df1
df2
df3 = cbind(df1, df2)
df3

# 안됨
df4 = rbind(df1, df2)
df4

df5 = data.frame(name=c('apple','banana','cherry'), price = c(300,200,100))
df6 = data.frame(name=c('apple','berry','cherry'), qty = c(10,20,30))
cbind(df5, df6)
# 안됨
rbind(df5, df6)

merge(df5, df6)
merge(df5, df6, all=T)

# df1에 번호가 4, 5,이고, 이름이 'mango', 'berry'와 가격이 각 400, 500 인 데이터 생성 후 df1행 추가

df7 = data.frame(NO = c(4,5), NAME = c('mango','barry'), PRICE = c(400, 500))
df1 = rbind(df1, df7)
df1

# 수량이 (10,20,30,40,50)인 데이터를 열 추가
df1 = cbind(df1, qty = c(10,20,30,40,50))
df1

# data.frame에서 특정 컬럼만 골라내서 새로운 형태 만들기
no = c(1,2,3,4,5)
name = c('이순신','김유신','유관순','강감찬','안중근')
addr = c('서울','대전','대구','부산','광주')
tel = c(111,222,333,444,555)
hobby = c('놀','먹','자','게','멍')
mem = data.frame(NO=no, NAME=name, ADDR=addr, TEL=tel, HOBBY=hobby)
mem
mem2 = subset(mem, select = c(NO,NAME,TEL))
mem2

mem3 = subset(mem, select = -TEL)
mem3

colnames(mem3) = c('번호','이름','주소','취미')
mem3

sales
ncol(sales)
nrow(sales)
names(sales)
colnames(sales)
rownames(sales)
row.names(sales)
sales[c(2,3,1),]

#########실습문제############
name = c('사과','딸기','수박')
price = c(1803,1501,3040)
sale = c(24,38,13)
a1 = data.frame(NAME = name, PRICE = price, SALE = sale)
a1
colnames(a1) = c('제품','가격','판매량')
a1

# 평균값 구하는 명령어 mean()
sum(a1$가격)/3
sum(a1$판매량)/3

mean(a1$가격)
mean(a1$판매량)

# 3번째 소수점에서 반올림해서 2번째 소수점까지만 나오게 하는 방법
round(mean(a1$가격),2)

# 데이터 수정 : 변수명 바꾸기
install.packages("dplyr")
library(dplyr)

df1 = data.frame(var1 = c(1,2,1),
                 var2 = c(2,3,3))
df2 = df1

df2= rename (df2, v2=var2)
df2

# 변수 조합해서 파생변수를 만들기
df1
df1$var_sum = df1$var1+df1$var2
df1

install.packages("ggplot2")
library(ggplot2)
mpg
View(mpg)
class(mpg)
str(mpg)
head(mpg)
tail(mpg)

mpg1 = mpg
mpg1 = rename(mpg1, city=cty)
mpg1 = rename(mpg1, highway=hwy)
View(mpg1)

# 작업용 데이터 읽기, 쓰기
# 파일 이름 확인
setwd("c://r_workdata")

list.files()
list.files(all.files = T)

list.files(recursive = T)

# scan() : 텍스트 파일을 읽어서 벡터에 저장(정수값만 읽는다)
s1 = scan('scan_1.txt')
s1
s1[1]
s2 = scan('scan_2.txt', what = '') #what을 사용하면 실수값까지 문자열로 표기되서 나옴
s2

s3 = scan('scan_3.txt', what = '')
s3

s4 = scan('scan_1.txt', what = '')
s4

input = scan()
input

input = scan(what ='')
input

# read:line() : 한줄읽기
input = scan()
input[3]

input2 = readline()
input2

input2 = readline("R u OK?!")
input2

# readLines() : 파이를 읽어서 벡터에 저장 (실수 문자 다 읽지만 전부 문자열로 저장됨)
input5 = readLines("scan_4.txt")
input5

# read.table() : 데이터를 읽어서 데이터 프레임에 지정
# - 주석이나 공백을 제외하고 읽는다
# 기본적으로 컬럼명이 없다고 판단
f = read.table('fruits.txt')
f

f = read.table('fruits.txt', header = T)
f

# read.csv() : csv파일을 읽기
# read.table과 다르게 기본적으로 컬럼명이 있다고 판단
f3 = read.csv("fruits_3.csv")
f3

f4 = read.csv("fruits_4.csv", header = F)
f4

lab = c('NO', 'NAME', 'PRICE', 'QTY')
f4 = read.csv('fruits_4.csv', header = F, col.names = lab)
f4

# read.csv() => wrtie.csv()
# read.table() => write.table()

t3 = read.table("csv_text.txt")
t3

t3 = read.table("csv_test.txt", sep=',', header = T)






























