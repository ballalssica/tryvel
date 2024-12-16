Tryvel 🌍
Tryvel은 소상공인과 인플루언서를 연결하여 맞춤형 여행 정보를 제공하는 위치 기반 여행 플랫폼입니다.
여행지, 축제, 행사와 같은 무료 정보를 실시간으로 제공하고, 인플루언서 매칭 서비스를 통해 지역 사회와 사용자 모두에게 가치를 제공합니다.
이번 프로젝트에서는 그 중에서 소상공인과 인플루언서를 매칭하는 체험단서비스만 구현합니다.

프로젝트 개요 🚀
프로젝트명
Tryvel (Try + Travel)

프로젝트 목표
무료 체험단 서비스를 통해 소상공인과 인플루언서 연결
인플루언서를 통해 여행지 및 소상공인 홍보 지원
지역 소상공인의 마케팅 기회를 확장

주요 기능
체험단 모집 및 신청

소상공인: 체험단을 등록하고 홍보 기회를 제공합니다.
인플루언서: 체험단에 참여하여 매장 및 여행지를 방문하고 리뷰 작성.
위치 기반 정보 제공

사용자의 현재 위치를 기반으로 주변 체험단 및 여행지 정보 제공.
여행 정보 관리

등록된 체험단 정보 실시간 확인 및 수정 가능.
Firebase를 통해 안전하게 데이터 관리.
이미지 업로드 및 리뷰 작성

사용자가 직접 사진을 업로드하고 체험 후기를 작성할 수 있습니다.
기술 스택
기술 설명
Flutter 크로스플랫폼 프레임워크로 앱 개발
Dart Flutter 프로젝트 언어
Firebase 백엔드 데이터 관리 및 호스팅
Flutter Riverpod 상태 관리 솔루션
Image Picker 이미지 선택 및 업로드
Firestore 데이터 저장 및 실시간 동기화
Firebase Storage 이미지 업로드 및 파일 관리
프로젝트 설정
프로젝트 클론

bash
코드 복사
git clone https://github.com/ballalssica/tryvel.git
cd tryvel
의존성 설치
Flutter 프로젝트의 모든 패키지를 설치합니다.

bash
코드 복사
flutter pub get
Firebase 설정

Firebase Console에 접속하여 프로젝트를 생성합니다.
Firebase 설정 파일 (google-services.json 및 GoogleService-Info.plist)을 다운로드하여 각각 Android 및 iOS 프로젝트에 추가합니다.
에뮬레이터 실행

Android, iOS 또는 Chrome 환경에서 앱을 실행합니다.
bash
코드 복사
flutter run
디렉토리 구조
plaintext
코드 복사
lib/
├── core/
│ ├── constants/ # 상수 관리
│ │ ├── categories.dart
│ ├── theme.dart # 앱 테마 설정
│ ├── utils/ # 유틸리티 클래스
│ │ ├── validator_util.dart
│
├── data/
│ ├── model/ # 데이터 모델
│ │ ├── place.dart
│ ├── repository/ # Firestore 통신
│ ├── place_repository.dart
│
├── ui/
│ ├── home/ # 홈 화면
│ │ ├── home_page.dart
│ ├── place/
│ │ ├── place_add/ # 플레이스 추가
│ │ │ ├── place_add_page.dart
│ │ │ ├── place_add_view_model.dart
│ │ ├── place_update/ # 플레이스 수정
│ │ ├── place_update_list.dart
│ │ ├── place_update_page.dart
│ │ ├── place_update_view_model.dart
│ ├── widgets/ # 공통 위젯
│ ├── form_field/ # 입력 필드 위젯
│ ├── button/ # 버튼 위젯
│
├── firebase_options.dart # Firebase 초기화 설정
└── main.dart # 앱 진입점

패키지 버전
프로젝트에서 사용하는 패키지 버전입니다.

패키지 버전
flutter_riverpod ^2.6.1
image_picker ^1.1.2
firebase_core ^2.31.0
cloud_firestore ^4.15.0
firebase_storage ^11.7.0
http ^1.2.1
provider ^6.1.5
스크린샷
추가적으로 스크린샷을 삽입하면 사용자 이해도가 높아집니다.

라이센스
MIT License
LICENSE 파일을 참고하세요.

기여 방법
기여를 원하시는 분들은 CONTRIBUTING.md 파일을 확인해 주세요.
문의사항은 이슈로 남겨주세요.
