# 💡 프로젝트 계획서

## 📅 2025-04-29

### 📌 프로젝트 주제  
**운동 루틴 & 헬스 기록 앱 - 마음가GYM**

---

### 📝 요구사항 수집 및 분석

#### 👤 사용자 대상
- 운동을 즐겨하는 사람
- 운동을 기록하고 체계적으로 관리하고 싶은 사람

#### 🎯 주요 니즈
- 📋 **개인 운동 루틴 저장 기능**
- 🖊️ **매일 운동 내용을 쉽게 기록 가능**
- 📈 **체중/운동량 변화 추이 시각화 (차트 제공)**
- ⏰ **운동 목표 알람 및 시간 알림 기능**

#### 🔍 벤치마킹
- **플릭**
- **플랜핏**
- **오늘의 운동**

---

### 📊 간트차트

![간트차트](./image/간트차트_001.png)

---

# 🧠 Flutter 개발환경 세팅 + Firebase 연동 + Firestore 설계

## 📅 2025-05-12

## 📌 1. Flutter 개발환경 세팅

### ✅ 필수 도구 설치
```bash
# Flutter SDK 설치
https://docs.flutter.dev/get-started/install

# Android Studio 설치 + Flutter, Dart 플러그인 설치
# Android SDK & Emulator 설치 포함
```

### ✅ 새 프로젝트 생성
```bash
flutter create mind_gym
cd mind_gym
```

### ✅ 디바이스 확인
```bash
flutter devices
```

---

## 🔌 2. Firebase 연결 세팅 (Android 기준)

### ✅ Firebase 프로젝트 연결
```text
1. https://console.firebase.google.com 접속
2. 프로젝트 생성 → Android 앱 추가
3. Android 패키지명 입력 (예: com.example.mind_gym)
4. google-services.json 다운로드 → android/app/ 에 넣기
```

### ✅ 프로젝트 레벨 build.gradle.kts 수정
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.3.15")
    }
}
```

### ✅ 앱 레벨 build.gradle.kts 수정
```kotlin
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services") // Firebase 플러그인 추가
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.1.1"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}
```

### ✅ Flutter 초기화
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

---

## 🗂 3. Cloud Firestore DB 설계

### ✅ Firestore 활성화
```text
Firebase 콘솔 → Firestore Database → 시작하기 → 테스트 모드 사용
```

### ✅ 설계 구조 (예: 마음가GYM)
```plaintext
users (컬렉션)
 ┗ userId (문서)
    ┣ routines (컬렉션)
    ┃ ┗ routineId
    ┣ logs (컬렉션)
    ┃ ┗ logId
    ┗ weightRecords (배열 또는 하위 컬렉션)
```


---

## ✅ 기타 유틸 명령어

```bash
flutter pub get           # 의존성 설치
flutter run               # 앱 실행
flutter clean             # 캐시 삭제
flutter doctor            # 환경 진단
```

---

