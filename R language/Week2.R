```R
setwd("c:/r_workdata")
getwd()

Sys.setlocale("LC_ALL", "Korean")
 
d1 = read.csv("야구성적.csv") 
d1

install.packages("lubridate")
library(lubridate)

install.packages("installr")
library(installr)

# R 버전 체크
check.for.updates.R()
install.R()

d1 =100
print(d1)
# class 타입 반환
class(d1)

d1 = '100'
class(d1)

print(1+1)
1+1
# digit은 숫자 전체 기준 3자리만 출력
print(pi, digit=3)
print(pi, 3)

print(1,2)
print('1', '1')
# 따로 줄바꿈없이 공백을 하나씩 주고 순서대로 하나씩 출력
cat(1, 2, 'd')

#변수 대입
a = 1
a <- 2
print(a)
# 1부터 20까지 증가한 값이 모두 a에 Vector형식으로(즉 배열과 같이)들어감
a = 1:20
print(a)

a = 2+(3*5)
print(a)

#세미클론으로 한 줄에서 여러가지 수행 가능
1+2; 1+243; 4+132; 

#제곱
2^3
2**2

#산술연산자
#+, -, *, /
# 나누기 : /, %/%, %%
# / : 실수값으로 표현
# %/% : 몫을 정수로 표현
# %% : 나머지

5/2
5%/%2
5%%2

10000
100000
1e+03
2e+03
2e-03

'1'+'3'
# 강제 형변환 : (숫자 변환) as.~
as.numeric('1')+as.numeric('2')

# 문자형
'first'
first = 'a'
class(first)

# 진리값,불
#  & : and연산
#  | : or연산
#  ! : not연산
3&1
3&-2

3|0
3|-3

!0

# NA/Null
# NA : 잘못된 값이 들어올경우(Not Applicable, Not Available)
# NULL : 존재하지 않는 값

cat(1, NA, 2)  #NA 포함해서 출력 1, NA, 2
cat(1, NULL, 2)  #NULL 빼고 출력 1, 2

sum(1, NA, 2)   # NA 값
sum(1, NULL, 2) # NULL 제외하고 계산

# factor : 여러번 중복되어 나오는 데이터들을 각 값으로 모아서 대표값을 출력
# csv : 데이터 또는 컬럼을 구분하는 구분자를 ','로 해놓은 파일

t1 = read.csv("factor_test.txt")
t1

class(t1)  #data.frame
str(t1) #10개의 object,  5개의 컬럼
# 아래와 같이 출력
'data.frame':	10 obs. of  5 variables:
 $ no      : int  1 2 3 4 5 6 7 8 9 10
 $ name    : chr  "서진수" "홍길동" "유관순" "전우치" ...
 $ blood   : chr  "O" "A" "O" "B" ...
 $ sex     : chr  "남" "남" "여" "남" ...
 $ location: chr  "서울" "부산" "부산" "전남" ...

# blood 안에 중복 내용들 제거하고 return
f1 = factor(t1$blood)
# blood 안에 몇개의 중복된 내용들이 있는지 알려줌
# ex) A AB B O
#     2  1 3 4
summary(f1)

f1 = factor(t1$sex)
f1
summary(f1)

# 날짜, 시간
# Base 패키지 : 날짜 시간 제어
Sys.Date()
Sys.time()
date()

a = '2002-05-21'
class(a)
# 문자 a를 Date 형태로 변환
a = as.Date(a)
class(a)

# 날짜 형태
# %d : 일
# %m : 월
# %Y : 년(4자리)
# %y : 년(2자리)

# 날짜를 Date 객체 형태로 변환
as.Date("03-12-2023", format='%m-%d-%Y')
as.Date("03122023", format='%m%d%Y')

as.Date("2023년 3월 10일", format='%Y년 %m월 %d일')
```

#기준일자를 주고 날짜계산 가능
as.Date(100, origin='2025-03-21')
as.Date(-100, origin='2025-03-21')
as.Date('2025-03-21') + 100
