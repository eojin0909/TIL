
# 📚 알고리즘 시험 정리 (12~13주차 & 강의자료 반영)

---

## 🧾 시험 개요

- **문제 수**: 약 10문제
- **비중**: 손코딩 70% / 이론 30%
- **문제 유형**
  - 이론 문제: 수식 → 코드 표현, 시간 복잡도 해석
  - 손코딩 문제: BFS, DFS, 이진 탐색, 트리 구현
- **주의**: 로테이션(AVL Tree), 시간복잡도 표기(Big-O, Ω, Θ) 포함

---

## 📌 핵심 이론 정리

### ✅ DFS / BFS

- DFS: 스택 or 재귀 (연결요소 수 세기)
- BFS: 큐 사용, 방문 순서 중요
- DFS/BFS 모두 인접 리스트 + 방문 배열 필요

### ✅ 이진 탐색 (Binary Search)

- 정렬된 리스트에서 중앙값 기준 탐색
- 시간복잡도: O(log n)
- 대표 문제: 백준 1920번

#### 슈도코드

```text
BinarySearch(A, key):
    start ← 0
    end ← length(A) - 1
    while start ≤ end:
        mid ← (start + end) // 2
        if A[mid] == key:
            return mid
        else if A[mid] < key:
            start ← mid + 1
        else:
            end ← mid - 1
```

---

## 🌲 이진 트리 / 이진 탐색 트리 (BST)

### 이진 트리 종류

- 포화 이진 트리 (모든 노드가 자식 2개)
- 완전 이진 트리 (왼쪽부터 채운 형태)
- 편향 이진 트리 (왼쪽 또는 오른쪽만 있음)

### 이진 탐색 트리 특징

- 왼쪽: 더 작은 값 / 오른쪽: 더 큰 값
- 중복 X, 중위 순회 → 오름차순 출력

### 순회 방식

- 전위: 루트 → 왼쪽 → 오른쪽
- 중위: 왼쪽 → 루트 → 오른쪽
- 후위: 왼쪽 → 오른쪽 → 루트

---

## 🔄 정렬 알고리즘

### ✅ 힙 정렬 (Heap Sort)

- 최대 힙 구성 → 루트와 마지막 값 교환 → 힙 크기 감소
- DownHeap 반복 → 힙 조건 유지
- 시간복잡도: **O(n log n)**

### ✅ 퀵 정렬 (Quick Sort)

- 피봇 기준으로 분할 → 왼쪽/오른쪽 재귀 호출
- 최선/평균: O(n log n) / 최악: O(n^2)
- 피봇 선택 전략 중요 (중앙값 추천)

---

## ⏱️ 시간 복잡도 표기법

| 표기법 | 의미             | 예시        |
|--------|------------------|-------------|
| O(g(n)) | 최악의 경우       | O(n^2), O(log n) |
| Ω(g(n)) | 최선의 경우       | Ω(1)         |
| Θ(g(n)) | 정확한 평균 성능   | Θ(n log n)   |

---


# 📝 시험 범위 정리 (Python 알고리즘 및 자료구조)

---

## 1. DFS (깊이 우선 탐색) – 연결 요소 개수 구하기

**파일명:** `DFSFirst20250522.py`

- **기본 개념**
  - 인접 리스트 방식으로 그래프 표현
  - DFS 재귀 함수 구현
  - 방문 여부 체크를 위한 `visited` 배열 사용
  - 연결 요소의 개수 계산

- **핵심 코드**
  ```python
  def DFS(v):
      visited[v] = True
      for i in A[v]:
          if not visited[i]:
              DFS(i)

  for i in range(1, n+1):
      if not visited[i]:
          count += 1
          DFS(i)
  ```

- **주의할 점**
  - `count =+ 1` → `count += 1`로 수정 필요
  - `sys.setrecursionlimit(10000)`로 재귀 깊이 제한 해제

---

## 2. 이진 탐색 (Binary Search)

**파일명:** `bstFirst0612.py`

- **기본 개념**
  - 오름차순/내림차순 정렬
  - 이진 탐색 알고리즘 구현 (`while` 루프 기반)
  - 입력된 정수 리스트에서 키 값 탐색

- **핵심 함수**
  ```python
  def binSearch(ary, fData):
      start = 0
      end = len(ary) - 1
      while(start <= end):
          mid = (start + end) // 2
          if fData == ary[mid]:
              return mid
          elif fData > ary[mid]:
              start = mid + 1
          else:
              end = mid - 1
  ```

- **추가 내용**
  - 사용자 입력 10개 정수 → 정렬 후 탐색
  - `global count`로 탐색 횟수 측정

---

## 3. 이진 탐색 트리 (BST: Binary Search Tree)

**파일명:** `bstTreeSecound0529.py`

- **기본 개념**
  - 클래스로 노드 정의 (`TreeNode`)
  - 문자열 리스트 기반 이진 탐색 트리 구성
  - 중위 순회 (In-order Traversal)로 출력

- **중요 함수**
  ```python
  def inorder_traversal(node):
      if node is not None:
          inorder_traversal(node.left)
          print(node.data, end=" ")
          inorder_traversal(node.right)
  ```

- **트리 구성**
  - 루트 노드부터 비교하여 좌/우 자식으로 삽입
  - 문자열의 알파벳 순으로 비교

---

## ✅ 시험 대비 포인트

- DFS 재귀 호출과 방문 배열의 동작 원리
- 이진 탐색 알고리즘의 루프 흐름과 조건 비교
- 트리 구조 구성과 중위 순회 원리
- `input()` 및 `sys.stdin.readline()`의 사용 차이
- 오름차순/내림차순 정렬과 리스트 복사 방식

