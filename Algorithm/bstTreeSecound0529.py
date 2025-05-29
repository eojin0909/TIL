class TreeNode :
    def __init__(self):
        self.left = None
        self.data = None
        self.right = None

## 전역변수 선언 부분 ##
memory = []
root = None
nameAry = ['어진이와 친구들', '어진이와 아이들', '이어진 밴드', '이어진', '어진', '어진리']

## main 코드 영역 ##
if __name__=="__main__":
    node = TreeNode()
    node.data = nameAry[0]
    root = node
    memory.append(node)

    for name in nameAry[1:]:
        node = TreeNode()
        node.data = name
        current = root
        while True:
            if name < current.data:
