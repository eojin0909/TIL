class SList:
    class Node:
        def __init__(self, item, link):
            self.item = item 
            self.next = link 
    
    def __init__(self):
        print("난 SList의 생성자 ") 
        self.head = None  
        self.size = 0  
    
    # 리스트가 비었는지 확인하는 함수
    def isEmpty(self):
        return self.size == 0 
    
    # 리스트의 앞에 새로운 노드를 추가하는 함수
    def insert_front(self, item):
        if self.isEmpty():
            # 리스트가 비어있으면, 첫 번째 노드로 새로운 노드를 추가
            self.head = self.Node(item, None)
        else:
            # 비어있지 않으면, 새로운 노드를 생성하고 그 뒤에 기존의 head를 연결
            self.head = self.Node(item, self.head)
        self.size += 1  
    
    # 주어진 노드(p) 뒤에 새로운 노드를 추가하는 함수
    def insert_after(self, item, p):
        p.next = self.Node(item, p.next) 
        self.size += 1  
    
    # 리스트에서 특정 값을 찾고 그 인덱스를 반환하는 함수
    def search(self, target):
        p = self.head
        # 리스트를 순차적으로 탐색
        for k in range(self.size): 
            if target == p.item: 
                return k 
            p = p.next 
    
    # 주어진 노드(p)의 뒤에 있는 노드를 삭제하는 함수
    def delete_after(self, p):
        if self.isEmpty():
            print("List가 텅 비어있어서 삭제 불가")  
            return None
        else:
            t = p.next  
            p.next = t.next  
            del t  
            self.size -= 1  
    
    # 리스트의 첫 번째 노드를 삭제하는 함수
    def delete_front(self):
        if self.isEmpty():
            print("List가 텅비어서 삭제 불가")  
            return None
        else:
            t = self.head  
            self.head = self.head.next  
            del t  
            self.size -= 1 
    
    # 사용자가 원하는 index에 새로운 노드를 삽입하는 함수
    def insert_index(self, index, item):
        if index < 0 or index > self.size:
            print("잘못된 인덱스")
            return
        if index == 0:
            self.insert_front(item)  
        else:
            p = self.head
            for _ in range(index - 1): 
                p = p.next
            
            self.insert_after(item, p)
        self.size += 1  
    
    # 사용자가 원하는 index에 노드를 삭제하는 함수
    def delete_index(self, index):
        if index < 0 or index >= self.size:
            print("잘못된 인덱스")
            return  
        
        if index == 0:
            self.delete_front() 
        else:
            p = self.head
            for _ in range(index - 1): 
                p = p.next
            
            self.delete_after(p)
        self.size -= 1  
    
    # 리스트의 마지막 노드를 삭제하는 함수
    def delete_final(self):
        if self.isEmpty():
            print("List가 텅 비어서 삭제 불가")
            return
        
        if self.size == 1:
            self.delete_front() 
        else:
            p = self.head
            while p.next and p.next.next:  
                p = p.next
            self.delete_after(p) 
        self.size -= 1 
    
    # 리스트의 모든 노드를 출력하는 함수
    def printList(self):
        p = self.head 
        while p:
            if p.next is not None:
                print(p.item, "=>", end="")
            else:
                print(p.item)
            p = p.next  

# 전역 함수로 정의되어 있지만, 내용이 비어있는 함수
def globalFunc():
    pass  

if __name__=="__main__":
    s = SList()
    s.insert_front("apple")
    s.insert_front("orange")
    s.printList() 
    s.insert_after("cherry", s.head.next)  
    s.printList()  
    s.insert_front("pear")

    s.insert_front("melon")
    s.insert_front("strawberry")
    s.insert_front("geape")
    s.insert_front("peach")
    s.insert_front("banana")
    s.insert_front("mango")  
    s.printList()  
    print("cherry는 %d번째 Node에 있다"% (s.search("cherry")+1))  
    s.delete_after(s.head)  
    s.printList()  
    print("첫번째 Node 삭제후\t\t")
    s.delete_front()  
    s.printList()  
    #실습과제 코딩
    s.insert_index(2,"melon")
    s.delete_index(3)
    s.delete_final()
    s.printList()