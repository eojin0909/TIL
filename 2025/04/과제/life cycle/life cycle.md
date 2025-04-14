## 📘 주제: life cycle 실습

---

## 📚 용어 정리

- Flutter는 화면 간 이동 시 내부적으로 **Stack 구조**를 사용한다.
  - `Navigator.push()` → 화면을 Stack에 추가
  - `Navigator.pop()` → Stack에서 제거하고 이전 화면 복귀

- `StatefulWidget`의 생명주기 함수:
  - `initState()` : 위젯이 처음 생성될 때 1번 호출됨
  - `build()` : 위젯이 다시 그려져야 할 때마다 호출됨
  - `dispose()` : 위젯이 화면에서 제거될 때 호출됨

---

## 🧑‍💻 실습 코드

```dart
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FirstPage()));

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SecondPage()),
            );
          },
          child: Text("Go to Second Page"),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    print("🟢 initState 호출됨");
  }

  @override
  Widget build(BuildContext context) {
    print("🔵 build 호출됨");
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Go Back"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("🔴 dispose 호출됨");
    super.dispose();
  }
}
