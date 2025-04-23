
# 📈 AWS Auto Scaling 요약

## 📌 Scaling 개념
- **Scale-Up**: 인스턴스 성능 업그레이드 (단순, 고비용, 재시작 필요)
- **Scale-Out**: 인스턴스 수 증가 (무중단, 복잡한 구조 필요)

## 🔁 Auto Scaling
- 자동으로 EC2 인스턴스를 증가/감소
- 비용 절감 + 고가용성

## 🔧 구성 요소
- **Launch Template**: 인스턴스 설계도 (AMI, 타입, UserData 포함)
- **ASG**: 인스턴스 그룹, 최소/최대/원하는 용량 설정
- **Scaling Policy**: 트리거 조건 (Target, Step, Scheduled)
- **CloudWatch**: 지표 감시 및 알람 트리거

## 🧪 실습
- 템플릿 작성 + Auto Scaling Group 생성 (Desired=2)
- EC2 종료 시 자동 복구 확인
- stress-ng로 부하 테스트 → 인스턴스 수 자동 증가
- 시간 기반 스케일링 테스트
