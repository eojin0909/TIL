class LinkedQueue:
    class Node:
        def __init__(self, item, link):
            self.item = item
            self.next = link
    
    def __init__(self):
        print("난 LinkedQueue 기본 생성자")
        self.front = None
        self.rear = None
        self.size = 0

    def isEmpty(self):
        return self.size == 0    

    def add(self, item):
        newnode = self.Node(item, None)
        if self.isEmpty():
            self.front = newnode
        else :
            self.rear.next = newnode

        self.rear = newnode
        self.size += 1

    def dispq(self):
        p = self.front
        print("front =>" , end="")
        while p:
            if p.next != None:
                print("{!s:<7}".format(p.item) ,
                      "=>", end="")
            else:
                print(p.item, end='')
                
            p = p.next
        print(" :rear")

    def delete(self) :
        if self.isEmpty():
            raise EmptyError("Queue가 텅 비어 있음")
        else:
            fitem = self.front.item
            oldfront = self.front
            self.front = self.front.next
            del oldfront
            self.size -= 1
            if self.isEmpty():
                self.rear = None
        return fitem

class EmptyError(Exception):
    pass        

if __name__=="__main__":
    q = LinkedQueue()
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
