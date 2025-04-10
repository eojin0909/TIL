def push(item):
    global top
    stack.append(item)
    top += 1 #top = top + 1

def pop():
    global top
    if len(stack) != 0:
        #item = stack.pop(-1)
        item = stack.pop(top)
        top -= 1 #top = top - 1
        return item

stack = []
top = -1 # -1, 0, 1, 2, 1
if __name__ == "__main__":
    push("apple")
    push("orange")
    push("cherry")
    print("apple, orange, cherry를 push 후  = \t", end="")
    print(stack, "\t <- top")
    print("TOP 항목 =", end='')
    topvalue = pop()
    print("topvalue=", topvalue)
    push("pear")
    print("pear 추가 후 top=", end="")
    topval2 = pop()
    print("topval2 =", topval2)