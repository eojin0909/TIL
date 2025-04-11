# 연결 리스트를 이용한 큐 클래스 정의
class LinkedQueue:
    # Node 클래스는 큐의 각 요소를 나타냄
    class Node:
        def __init__(self, item, link):
            self.item = item    # 데이터 저장
            self.next = link    # 다음 노드를 가리키는 링크

    # 큐 생성자
    def __init__(self):
        print("난 LinkedQueue 기본 생성자")
        self.front = None  # 큐의 앞쪽 노드를 가리킴
        self.rear = None   # 큐의 뒤쪽 노드를 가리킴
        self.size = 0      # 큐의 크기(요소 개수)

    # 큐가 비어있는지 확인하는 함수
    def isEmpty(self):
        return self.size == 0    

    # 큐에 데이터를 추가하는 함수 (enqueue)
    def add(self, item):
        newnode = self.Node(item, None)  # 새 노드 생성
        if self.isEmpty():               # 큐가 비어있으면 front도 새 노드를 가리킴
            self.front = newnode
        else:
            self.rear.next = newnode     # 큐의 끝에 새 노드를 연결
        self.rear = newnode              # rear를 새 노드로 갱신
        self.size += 1                   # 큐 크기 증가

    # 큐의 모든 요소를 출력하는 함수
    def dispq(self):
        p = self.front
        print("front =>", end="")
        while p:
            if p.next != None:
                print("{!s:<7}".format(p.item), "=>", end="")
            else:
                print(p.item, end='')    # 마지막 요소는 => 없이 출력
            p = p.next
        print(" :rear")                 # 큐 출력 끝 표시

    # 큐에서 데이터를 삭제하는 함수 (dequeue)
    def delete(self):
        if self.isEmpty():              # 비어있으면 예외 발생
            raise EmptyError("Queue가 텅 비어 있음")
        else:
            fitem = self.front.item     # 삭제할 front 노드의 데이터 저장
            oldfront = self.front
            self.front = self.front.next  # front를 다음 노드로 이동
            del oldfront                 # 기존 front 노드 삭제
            self.size -= 1              # 큐 크기 감소
            if self.isEmpty():          # 삭제 후 큐가 비었으면 rear도 None으로 설정
                self.rear = None
        return fitem                    # 삭제한 데이터 반환

# 큐가 비었을 때 발생할 사용자 정의 예외 클래스
class EmptyError(Exception):
    pass        

# 직접 실행할 경우 테스트용 코드
if __name__=="__main__":
    q = LinkedQueue()                  # 큐 생성
    q.add("apple")
    q.add("orange")
    q.add("cherry")
    q.add("pear")
    print("사과, 오렌지, 체리, 배 삽입 후 =", end="")
    q.dispq()

    delfruit = q.delete()
    print("사과 삭제 후 delfruit = ", delfruit)
    q.dispq()

    print("front 가 가리키는 orange 노드 삭제 후 Queue=")
    delfruit = q.delete()
    print("오렌지 삭제 후 delfruit = ", delfruit)
    q.dispq()
