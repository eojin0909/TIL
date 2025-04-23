# 📘 자료구조 예제 정리 (.py to .md)

## ✅ 1. Stack (stackList250320.py)

```python
def push(item):
    global top
    stack.append(item)
    top += 1

def pop():
    global top
    if len(stack) != 0:
        item = stack.pop(top)
        top -= 1
        return item

stack = []
top = -1
if __name__ == "__main__":
    push("apple")
    push("orange")
    push("cherry")
    print("apple, orange, cherry를 push 후  = ", stack, " <- top")
    topvalue = pop()
    print("topvalue=", topvalue)
    push("pear")
    topval2 = pop()
    print("topval2 =", topval2)
```

---

## ✅ 2. 단일 연결 리스트 (SinglyLinkedList250403)

```python
class SList:
    class Node:
        def __init__(self, item, link):
            self.item = item
            self.next = link

    def __init__(self):
        self.head = None
        self.size = 0
    ...
    def insert_index(self, index, item):
        ...
    def delete_index(self, index):
        ...
    def delete_final(self):
        ...
```

사용 예:
```python
s = SList()
s.insert_front("apple")
s.insert_front("orange")
...
s.insert_index(2,"melon")
s.delete_index(3)
s.delete_final()
s.printList()
```

---

## ✅ 3. 단순 연결 리스트 기본 버전 (SinglyLinkedList250327)

```python
class SList:
    class Node:
        def __init__(self, item, link):
            self.item = item
            self.next = link

    def __init__(self):
        self.head = None
        self.size = 0

    def insert_front(self, item):
        ...
    
    def printList(self):
        ...
```

사용 예:
```python
s = SList()
s.insert_front("apple")
s.insert_front("orange")
s.printList()
```

---

## ✅ 4. 연결 리스트 기반 큐 (QueueBySList250410)

```python
class LinkedQueue:
    class Node:
        def __init__(self, item, link):
            self.item = item
            self.next = link

    def __init__(self):
        self.front = None
        self.rear = None
        self.size = 0

    def add(self, item):
        ...
    
    def delete(self):
        ...
```

사용 예:
```python
q = LinkedQueue()
q.add("apple")
q.add("orange")
q.add("cherry")
q.add("pear")
q.dispq()
q.delete()
q.dispq()
```
