# 시험 대비 Docker + 가상화 + Lambda/RDS 요약

## 1. 가상화 개념

-   **VM**: 하이퍼바이저 위에서 Guest OS 실행 → 무겁고 느림.
-   **컨테이너**: 호스트 OS 커널 공유, 프로세스 격리 → 가볍고 빠름.

## 2. Docker 기본

-   **이미지(Image)**: 실행 전 설계도(불변).
-   **컨테이너(Container)**: 이미지 실행 인스턴스. \### 주요 명령어

```{=html}
<!-- -->
```
    docker run  
    docker stop  
    docker start  
    docker rm  
    docker exec -it  
    docker ps  
    docker images

## 3. Dockerfile 핵심

주요 지시어:

    FROM  
    RUN  
    COPY  
    ENV  
    CMD  
    ENTRYPOINT

빌드:

    docker build -t name .

## 4. Volume & Bind Mount

### Bind Mount

-   호스트 디렉토리 연결.

### Volume

-   Docker 관리 스토리지.

```{=html}
<!-- -->
```
    docker volume create  
    docker run -v

## 5. Docker Compose

핵심 키워드:\
- `services:`\
- `ports:`\
- `volumes:`\
- `depends_on:`\
- `build:`

명령어:

    docker compose up -d  
    docker compose down

## 6. Lambda Layer(PyMySQL)

-   Lambda는 PyMySQL 없음 → Layer 생성 필요.

## 7. Lambda + RDS 연동

환경변수:\
`DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`

### Base64 디코딩

``` python
import base64
decoded = base64.b64decode(os.environ['DB_PASSWORD']).decode('utf-8')
```

## 8. Secrets Manager

-   DB PW 안전 저장
-   자동 암호화 / IAM 제어
