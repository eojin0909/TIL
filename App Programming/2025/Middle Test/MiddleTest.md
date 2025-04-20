# TIL - Flutter 기초 정리

## 📅 0장. 플러터 개발 환경 준비하기

### ✅ 앱 개발 방식
- **네이티브 방식**: 플랫폼(iOS/Android)에서 자체적으로 개발
- **하이브리드 방식**: 웹 앱을 감싼 형태 (웹뷰 기반)
- **크로스 플랫폼 방식**: 한 번의 개발로 iOS/Android 앱 모두 제작 가능

### ✅ 플러터 특징
- 구글이 만든 크로스 플랫폼 프레임워크
- 낮은 진입 장벽, 높은 네이티브 성능, 예쁜 UI, 훌륭한 개발 도구 지원

## 📱 1장. 생애 첫 모바일 앱 만들기

### ✅ 환경 구성 검사
- `flutter doctor` 명령어로 확인
- 프로젝트 창에서 'flutter_app > test > pubspec.yaml'을 선택 후, 오른쪽 상단에 표시된 4가지 링크 중 'Flutter doctor'를 클릭 하단 Flutter창에서 확인 가능, Flutter SDK 환경변수에 추가하지 않아도 작동하여 편리 
- 자세한 정보: `flutter doctor --verbose`

## 🔤 2장. Dart 문법 기초

### ✅ 변수 타입
```dart
int age = 10;
double pi = 3.14;
String name = "홍길동";
bool isTrue = true;
```

### ✅ const / final
- 한 번 설정한 값을 변경 불가
차이점
- final : run타입 검사
- const : Compile 타입 검사

### ✅ 타입 검사 및 형변환
```dart
name is String // true
name is! int // true
```

### ✅ 타입검사
```
- is : 같으면 True
- is! : 다르면 True
```
### ✅ 형변환 (as)
```dart
as는 다른 타입끼리 변환이 안되고 더 상위 개념으로 변환가능
int -> num
dynamic: 모든 타입 허용
```

### ✅ 함수 표현
- **익명함수**: `([args]) { return something; }`
- **람다식**: `([args]) => something;`

### ✅ 선택 매개변수
```dart
void greet({String name = '친구'}) {
  print('안녕 $name');
}
```

### ✅ 클래스, 상속, 인터페이스
- **클래스**는 설계도
```
- 컴퓨터 세계에서 객체는 저장 공간에 할당되어 값을 가지거나 식별자에 의해 참조되는 공간
- 변수, 자료구조, 함수 또는 메서드 등이 객체
- 객체를 메모리에 작성하는 것이 인스턴스 화 
- 메모리에 작성된 객체를 인스턴스
- 인스턴스화 하기 위해서는 설계도가 필요 설계도 역할하는것이 class
- Class 안에 속성을 표현하는 것이 프로퍼티
```
- **상속**: 코드 재사용, 계층 구조  ( 키워드 "extends" )
- **인터페이스**: 유연성, 다중 구현 가능 ( 키워드 "implements" )

### ✅ 컬렉션
```dart
List<String> foods = ['라면', '김밥'];
- 순서가 있는 값들의 집합 ( dart에선 배열을 제공하지 않기에 배열처럼 사용 ) 
Map<String, String> cityMap = {'한국': '서울'};
-  키( key ) 와 값( value ) 쌍의 집합, 값 추가/수정, 값 접근 
Set<String> uniqueCities = {'서울', '부산'};
- 중복 없는 값들의 집합, 값 추가, 중복 제거
```

### ✅ 컬렉션 제어
```dart
// if
var list = [1, 2, if (condition) 3];  		#[1, 2, 3]
// for
var squares = [for (var i in [1,2,3]) i * i]; 	#[1, 4, 9]
```

### ✅ 함수형 프로그래밍 특징 요약
| 구분 | 설명 |
|------|------|
일급 객체	 | 함수도 변수처럼 사용 가능 |
forEach	 | 반복하며 각 요소에 작업 수행 (리턴 X) |
where	| 조건 필터링 (true인 것만 추출) |
map		 | 요소 변환 (리턴값으로 새로운 리스트 생성) |

## ⚙️ 3장. 프로젝트 및 앱 구조

### ✅ pubspec.yaml
- 앱 메타정보, 의존성, assets 설정 관리

### ✅ 주요 항목 설명
| 구분 | 설명 |
|------|------|
name			 | 프로젝트 이름 |
description		 | 설명 |
version		 | 앱 버전 (앱스토어, Play스토어 배포용) |
environment	 | SDK 최소/최대 버전 지정 |
dependencies	 | 앱에서 직접 사용하는 패키지들 |
dev_dependencies | 테스트, 빌드용 등 개발 중만 사용하는 패키지 |
flutter		 | Flutter 전용 설정 (예: assets, fonts) |

주의사항
- 들여쓰기는 공백 2칸 ( 탭 X )
- 잘못 들여쓰면 오류 발생
- pubspec.yaml 변경 후엔 항상
	flutter pub get 또는 Vscode/Android Studio 에서 "Pub get" 해야 적용

### ✅ 위젯
- **StatelessWidget**: 불변, 정적인 UI
- **StatefulWidget**: 상태 변경에 따라 재렌더링

동작상의 차이
항목		 | StatelessWidget	 | StatefulWidget |
|------|------|------|
상태 관리	 | ❌ 불가능		 | ✅ 가능 (setState) |
UI 갱신	 | ❌ 불가능		 | ✅ 가능 |
사용 시점	 | 고정된 UI (텍스트, 버튼 등) | 사용자 입력, 애니메이션 등 동적 UI |
예시		 | Text, Icon, AppBar	 | Checkbox, TextField, ListView.builder |

## 🧱 4장. 기본 위젯 I

### ✅ 배치 위젯
- `Row`: 자식 위젯들을 수평으로 나란히 배치
- `Column`: 자식 위젯들을 수직으로 쌓아 배치
- `ListView`: 스크롤 가능한 리스트 뷰를 생성
- `ListTile`: 리스트 항목을 구성할 때 사용하는 위젯 (제목, 부제목, 아이콘 등 포함 가능)
- `GridView`: 가로, 세로 격자 형태로 위젯들을 배치
- `PageView`: 좌우 또는 상하로 페이지를 넘기는 뷰 생성

### ✅ 상단 바
- `AppBar`: 앱의 상단에 표시되는 바 (제목, 액션 아이콘 등 표시)
- `TabBar`: 탭 메뉴를 가로로 나열하여 탭 전환 UI 구성
- `Tab`: TabBar에 들어가는 개별 탭 항목
- `TabBarView`: 각 탭에 대응되는 실제 화면 내용

### ✅ 정렬 / 공간
- `Center`: 자식 위젯을 부모 위젯의 중앙에 정렬
- `SizedBox`: 고정된 크기의 공간 또는 위젯 생성
- `Padding`: 자식 위젯 주변에 여백을 추가
- `Align`: 부모 위젯 기준으로 자식의 위치를 정렬
- `Expanded`: 남은 공간을 자식 위젯이 모두 차지하도록 확장
- `Card`: 테두리와 그림자를 가진 박스 형태의 위젯

### ✅ 버튼 위젯
- `ElevatedButton`: 입체감 있는 버튼
- `TextButton`: 텍스트만 보이는 버튼
- `IconButton`: 아이콘 클릭을 위한 버튼
- `FloatingActionButton`: 둥근 모양의 플로팅 액션 버튼

## 🧩 5장. 기본 위젯 II

### ✅ 기타 UI
- `Icon`: 다양한 아이콘 표시
- `Text`: 텍스트 표시용 위젯
- `ProgressIndicator`: 로딩 또는 처리 상태 표시용 인디케이터
- `CircleAvatar`: 원형 형태의 아바타 이미지나 텍스트 표시

### ✅ 입력 관련
- `TextField`: 텍스트 입력 칸
- `Checkbox`: 다중 선택을 위한 체크 박스
- `Switch`: ON/OFF 상태 전환용 토글 스위치
- `Radio`: 단일 선택을 위한 라디오 버튼
- `RadioListTile`: 라디오 버튼과 텍스트가 결합된 리스트 항목
- `DropdownButton`: 드롭다운 목록에서 하나 선택

### ✅ 다이얼로그 & 날짜/시간 선택기
- `AlertDialog`: 경고나 알림을 위한 팝업 창
- `DatePicker`: 날짜 선택을 위한 달력 위젯
- `TimePicker`: 시간 선택을 위한 시계 위젯

### ✅ 이벤트
- `GestureDetector`: 터치 제스처 감지 및 처리
- `InkWell`: 터치 시 시각적 효과가 있는 터치 피드백 위젯

### ✅ 애니메이션
- `Hero`: 위젯 전환 시 애니메이션 효과로 자연스러운 화면 이동
- `AnimatedContainer`: 크기, 색상 등의 변화에 애니메이션 적용
- `SliverAppBar`: 스크롤 시 크기가 유동적으로 변하는 앱 바
- `SliverFillRemaining`: 남은 공간을 채워주는 슬리버 위젯
- `SliverList`: 스크롤 가능한 목록을 효율적으로 구성하는 리스트 뷰

### ✅ iOS 디자인 위젯
- `CupertinoAlertDialog`: iOS 스타일의 알림 팝업
- `CupertinoPicker`: iOS 스타일의 선택 휠
"""

## 🔀 6장. 내비게이션

### ✅ 동작 개념
- 화면 전환은 스택 구조 (push/pop)
- 주로 `StatelessWidget`에서 구성

### ✅ 코드로 이동
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPage()));
Navigator.pop(context);
```

### ✅ 이름 기반 이동 (`routes`)
- 앱 내 화면들의 이름(경로)과 실제 위젯을 연결해두고, 이름만으로 화면 전환을 처리하는 방식
- 코드가 깔끔하고 화면 관리가 편함, 앱이 커질수록 이동 흐름 파악이 쉬움
```dart
MaterialApp(
  routes: {
    '/second': (context) => SecondPage(),
  },
);
Navigator.pushNamed(context, '/second');
```

## 🆕 8장. Flutter 2 변경점

## ⚠️ 널 안전한 코드

### 🌟 핵심 개념
| 구분 | 설명 |
|------|------|
| 넌-널러블 (Non-nullable) | `int`, `String` 등 기본 자료형은 기본적으로 null 허용 ❌ |
| 널러블 (Nullable) | 타입 뒤에 `?` 붙여서 null 가능하게 함 → `int?`, `String?` |
| null 체크 연산자 | `?.`, `??`, `!` 등을 활용하여 null 방지 |

### 📌 주요 키워드
- `?` : 널 허용 타입 선언
- `??` : 널 병합 연산자 (null일 경우 기본값 사용)
- `!` : null 아님을 확신할 때 강제 사용 (주의!)
- `?.` : null-safe 접근 연산자

---

```dart
void main() {
  // 넌-널러블 변수 (null 값 불가능)
  String name = '홍길동';
  // name = null; // ❌ 오류 발생

  // 널러블 변수 (null 가능)
  String? nickname;
  print(nickname); // null

  // null 체크 연산자
 String? nickname;
  print(nickname ?? '기본 닉네임'); // 출력: 기본 닉네임

  // null-safe 호출
  int? length = nickname?.length;
  print(length); // null

  // 강제 언래핑 (주의!)
  nickname = '길동이';
  print(nickname!.length); // 안전하게 사용 가능
}
```
