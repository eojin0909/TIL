def binSearch(ary, fData):
    global count
    start = 0
    end = len(ary) - 1

    while(start <= end):
        count += 1
        mid = (start + end)//2

        if fData == ary[mid]:
            return mid
        elif fData > ary[mid]:
            start = mid + 1
        elif fData < ary[mid]:
            end = mid - 1



## 전역변수 선언 부분 ##
ascSort, descSort = [],[]
findData = 0
count = 0
num = []
keyNum = 0
findDataIndex = 0

## main 코드 부분 ##
if __name__=="__main__":
    print("정수 10개를 공백으로 구분해 입력")
    for i in range(10):
        print("%d번째 정수입력"%(i+1))
        val = int(input(""))
        num.append(val)

    ascSort = num [ : ] #numlist 원소들을 ascSort에 복사
    descSort = num [ : ] #numlist 원소들을 descSort에 복사
    #ascSort.sort(reverse=False) #오름차순 정렬 시킴
    ascSort.sort() #오름차순 정렬 시킴
    descSort.sort(reverse=True)#내림차순 정렬 시킴

    print("입력된 정수들=", num)
    print("오름차순 정렬된 ascSort=", ascSort)
    print("내림차순 정렬된 descSort=", descSort)

    keyNum = int(input("검색하고자 하는 키값입력="))
    #findDataIndex = binSearch(num, keyNum)
    findDataIndex = binSearch(ascSort, keyNum)
    print("검색된 키값의 index=%d" % findDataIndex)
    print("검색된 키값=%d" % ascSort[findDataIndex])