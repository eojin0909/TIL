# Lambda Layer 정리

## ✅ 개념

- Lambda Layer는 공통 라이브러리나 설정을 여러 Lambda 함수에서 재사용할 수 있도록 분리해둔 구성 요소
- 예: `emoji`, `requests`, `pandas` 같은 외부 라이브러리를 Layer로 묶어서 재활용

## ✅ 구성 순서

1. Python 디렉토리 구조 구성

```
python/lib/python3.13/site-packages/requests
```

2. 해당 폴더를 zip 압축

```bash
zip -r requests-layer.zip python
```

3. AWS Lambda 콘솔 접속 → Layer 생성 → zip 파일 업로드

4. Lambda 함수 편집 → 레이어 추가 클릭 → 생성한 Layer 선택

---

## ✅ 주의 사항

- Python 버전이 맞지 않으면 오류 발생
- zip 압축 시 폴더 구조를 반드시 맞춰야 정상 동작