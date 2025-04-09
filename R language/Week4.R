setwd("c:r_workdata")

Sys.setlocale("LC_ALL", "korean")

library(lubridate)

#1
seq(as.Date("2025-01-01"), as.Date("2025-1-31"), 'day')

#2
vec1<-c('사과', '배', '감', '버섯', '고구마')
vec1
vec1[-3]

#3
vec1 <- c('봄', '여름', '가을', '겨울')
vec2 <- c('봄', '여름', '늦여름', '초가을')
#중복 제외 전부(중복된건 1번만 표시)
union(vec1,vec2)
#차집합
setdiff(vec1,vec2)
#교집합
intersect(vec1,vec2)

#4
vec1 <- c('a', 'b', 'c', 'd', 'e', 'f')
# 3,5번째 데이터를 대문자로 변경
vec1[c(3,5)] <- toupper(vec1[c(3,5)])
vec1

# 4번째 데이터 삭제
vec1=vec1[-4]
vec1

# 위의 백터를 fator 타입으로 변경
vec1 = as.factor(vec1)
vec1
class(vec1)

#5
vec1 = seq(as.Date("2022-01-01"), as.Date("2122-12-31"), 1)
vec1

#위의 백터를 년도를 제외한 월/일 형식으로만 출력하여 vec2 생성
vec2 = format(vec1, "%m/%d")
vec2
class(vec2)

#2022년 2월 28일의 위치 확인(names 함수 활용)

d1=vec1
names(d1) = 1:length(d1)
d1
d1[d1=="2022-02-28"]

# vec1에서 2022년 2월 28일 뒤에 2월 29일 날짜 삽입
d2 = append(as.character(d1), "2022-02-29", after = 59)
d2
d3=as.Date(d2)
d3

#matrix
# 1. 백터를 여러개 합친 형태 : 행렬
# 2. 모든 컬럼과 행은 동일한 타입
# 3. 기본적으로 열로 생성
# 4. 다른 데이터타입의 데이터를 저장할 경우 데이터프레임 사용
#여루선 법칙
m1 = matrix(c(1,2,3,4))
m1

m2 = matrix(c(1,2,3,4), nrow=2)
m2

m3 = matrix(c(1,2,3,4), nrow=2, byrow = T)
m3 = matrix(c(1,2,3,4), 2, by = T)
m3
m3[1,1]
m3[2,1]
m3[1,]
m3[,1]

m4 = matrix(c(1,2,3,
              4,5,6,
              7,8,9), 3, by = T)
m4

# 새로운 행과 열 추가 : 행 묶음 rbind(), 열 묶음 cbind()
m4 = rbind(m4, c(11,12,13))
m4

m4 = rbind(m4,c(15,16,17,18)) # 3열까지 없기때문에 4번째 숫자는 삭제
m4

m4 = cbind(m4,c(20,21,22)) # 순환원리
m4


# 행, 열이름 지정
rownames(m4) = c(1,2,3,4,5)
m4
colnames(m4) = c('1st','2nd','3rd','4th')
m4


# matrix 사용
m1 = matrix(1:20, 4, by=T)
m1

dimnames(m1) = list(c(1,2,3,4), c('a','b','c','d','e'))
m1

# 색인

m1[2,3]
m1[-3,]

# 행렬조건

m1 >= 10

# 10 이상인 원소를 출력
m1[m1>=10]

#m1의 c가 10 이상인 행을 출력
m1

m1[,'c']>=10
m1[m1[,'c']>=10]

# m1의 e값이 20인 행의 3~5번째의 컬럼 출력 
m1[m1[,'e']==20, 3:5]

# matrix 문제
no = c(1,2,3,4)
name = c('apple', 'banana', 'peach', 'berry')
price = c(500,200,200,50)
qty = c(5,2,4,7)

m1 = cbind(no,name,price,qty)
m1

# 1. peach 가격 출력
m1[m1[,'name']=='peach','price']

# 2. apple,peach의 데이터만 출력
m1[m1[,'name'] == 'apple'| m1[,'name'] == 'peach',]

# sales라는 컬럼생성(단, sales는 price*qty)
sales = as.numeric(m1[,'price'])*as.numeric(m1[,'qty'])
sales
cbind(m1,sales)

# 4. 첫번째 컬럼제거 후 각 행번호 설정
rownames(m1) = m1[,1]
m1
m1 = m1[,-1]
m1

# 5. qty가 5이상인 과일 이름 출력
m1[m1[,'qty']>=5,'name'] # matrix에서 비교연산으로 원소 추출 시 1차원 벡터로 리턴(행렬구조를 잃어버림)

# 6. 5번째 과일추가(mango, 100원, 10개)
v1 = c('mango',100,10)
m1 = rbind(m1,v1)
m1
rownames(m1)[5] = 5
m1

# array : 3차원 배열 (행,렬,높이)
#matrix를 쌓아 놓은 형태

a1 = array(c(1:12), dim=c(4,3))
a1

a2 = array(c(1:12), dim=c(2,2,3))
a2
a2[1,1,3]































