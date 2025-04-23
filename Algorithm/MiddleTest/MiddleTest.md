# 📘 자료구조 예제 정리 (.py to .md)

각 예제는 파이썬으로 작성된 기본적인 자료구조(스택, 큐, 연결리스트) 구현입니다. 주요 함수들의 기능 설명과 실행 결과도 포함했습니다.

---

## ✅ 1. Stack (stackList250320.py)

### ✔ 설명
- `push(item)`: 스택의 top에 값을 추가합니다.
- `pop()`: top 값을 제거하고 반환합니다.

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

### 💡 출력 결과
```
apple, orange, cherry를 push 후  =  ['apple', 'orange', 'cherry']  <- top
topvalue= cherry
topval2 = pear
```

---

## ✅ 2. 단일 연결 리스트 고급형 (SinglyLinkedList250403)

### ✔ 설명
- `insert_front(item)`: 맨 앞에 노드를 추가
- `insert_after(item, p)`: 주어진 노드 뒤에 추가
- `insert_index(index, item)`: 원하는 위치에 삽입
- `delete_front()`, `delete_after(p)`, `delete_index(index)`, `delete_final()` 삭제 관련
- `search(target)`: 값의 인덱스 검색
- `printList()`: 전체 리스트 출력

```python
s = SList()
s.insert_front("apple")
s.insert_front("orange")
s.insert_after("cherry", s.head.next)
s.insert_front("pear")
s.insert_index(2, "melon")
s.delete_index(3)
s.delete_final()
s.printList()
```

### 💡 출력 예시
```
mango => banana => peach => geape => strawberry => melon => pear => orange => cherry => apple
cherry는 9번째 Node에 있다
첫번째 Node 삭제후
banana => peach => geape => strawberry => melon => pear => orange => cherry => apple
```

---

## ✅ 3. 단순 연결 리스트 기본형 (SinglyLinkedList250327)

### ✔ 설명
- `insert_front(item)`: 리스트 앞에 노드를 삽입
- `printList()`: 전체 노드 출력

```python
s = SList()
s.insert_front("apple")
s.insert_front("orange")
s.printList()
```

### 💡 출력 결과
```
orange =>apple
```

---

## ✅ 4. 연결 리스트 기반 큐 (QueueBySList250410)

### ✔ 설명
- `add(item)`: rear에 데이터 추가
- `delete()`: front에서 데이터 제거
- `dispq()`: 큐 전체 출력

```python
q = LinkedQueue()
q.add("apple")
q.add("orange")
q.add("cherry")
q.add("pear")
q.dispq()
q.delete()
q.dispq()
q.delete()
q.dispq()
```

### 💡 출력 예시
```
사과, 오렌지, 체리, 배 삽입 후 = front =>apple   =>orange =>cherry =>pear :rear
사과 삭제 후 delfruit =  apple
front =>orange =>cherry =>pear :rear
오렌지 삭제 후 delfruit =  orange
front =>cherry =>pear :rear
```
