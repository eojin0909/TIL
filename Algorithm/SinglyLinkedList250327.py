class SList:
    class Node:
        def __init__(self, item, link):
            # Node 클래스는 item과 다음 노드를 가리킬 link 속성을 가짐
            self.item = item  # 노드의 값
            self.next = link  # 다음 노드를 가리키는 참조

    def __init__(self):
        print("난 SList의 생성자 ") 
        self.head = None  # SList는 처음에 빈 리스트로 초기화됨
        self.size = 0  # 리스트의 크기는 0으로 시작
    
    def isEmpty(self):
        return self.size == 0  # size가 0이면 리스트가 비어있음
    
    def insert_front(self, item):
        if self.isEmpty():
            # 리스트가 비어있다면 새로운 노드를 생성하고 헤드를 그 노드로 설정
            self.head = self.Node(item, None)
        else:
            self.head = self.Node(item, self.head)        
        self.size += 1  # 리스트 크기를 1 증가시킴
    
    def printList(self):
        p = self.head  
        while p:
            if p.next is not None:
                print(p.item, "=>", end="")  
            else:
                print(p.item)  
            p = p.next  

# 빈 함수 globalFunc() - 현재 사용되지 않음
def globalFunc():
    pass

if __name__ == "__main__":
    s = SList()  # 새로운 SList 객체 생성
    s.insert_front("apple")
    s.insert_front("orange") 
    s.printList() 