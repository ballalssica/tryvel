# 🗺️ **Tryvel - 체험단 중심 위치 기반 여행 플랫폼**

**Tryvel**은 소상공인과 인플루언서를 연결하여 **맞춤형 여행 정보**를 제공하는 **위치 기반 체험단 플랫폼**입니다.  
여행지, 축제, 행사 등 **무료 정보를 실시간으로 제공**하며, **체험단 서비스**를 통해 사용자와 지역사회 모두에게 가치를 제공합니다.

---

## 🚀 **주요 기능**

- ✅ **소상공인 체험단 등록**  
   - 여행지 및 매장을 홍보하고 체험단 서비스를 등록할 수 있습니다.
- ✅ **인플루언서 체험단 신청**  
   - 체험단에 참여하여 여행 정보를 체험하고, 후기를 작성합니다.
- ✅ **위치 기반 정보 제공**  
   - 현재 위치를 기준으로 주변 체험단, 여행지, 축제 정보를 제공합니다.
- ✅ **이미지 업로드 및 리뷰 작성**  
   - 인플루언서 리뷰와 함께 실시간 이미지 업로드 기능을 지원합니다.

---

## 🛠️ **기술 스택**

| **기술**               | **설명**                         |
|-----------------------|--------------------------------|
| **Flutter**           | 크로스플랫폼 UI 프레임워크        |
| **Dart**              | Flutter의 개발 언어               |
| **Firebase**          | 데이터베이스 및 파일 업로드 관리   |
| **Flutter Riverpod**  | 상태 관리 솔루션                  |
| **Image Picker**      | 이미지 선택 및 업로드              |


---

## 📦 **디렉토리 구조**

```plaintext
lib/
├── core/
│   ├── theme.dart                      # 앱 전체 테마 설정
│   ├── constants/
│   │   ├── categories.dart             # 카테고리 상수 파일
│   ├── utils/
│       ├── validator_util.dart         # 폼 유효성 검사 유틸리티
│
├── data/
│   ├── model/
│   │   ├── place.dart                  # 데이터 모델
│   ├── repository/
│       ├── place_repository.dart       # Firestore 통신 및 CRUD
│
├── ui/
│   ├── home/
│   │   ├── home_page.dart              # 메인 홈 화면
│   ├── place/
│   │   ├── place_add/
│   │   │   ├── place_add_page.dart     # 체험단 추가 페이지
│   │   │   ├── place_add_view_model.dart
│   │   ├── place_update/
│   │   │   ├── place_update_page.dart  # 체험단 수정 페이지
│   │   │   ├── place_update_view_model.dart
│   ├── widgets/
│   │   ├── form_field/
│   │   │   ├── place/
│   │   │       ├── address_search_form_field.dart   # 주소 검색 위젯
│   │   │       ├── category_dropdown_form_field.dart # 카테고리 드롭다운 위젯
│   │   │       ├── holiday_form_field.dart          # 휴일 입력 필드
│   │   │       ├── image_uploader.dart              # 이미지 업로더 위젯
│   │   │       ├── operating_hours_form_field.dart  # 운영시간 입력 필드
│   │   │       ├── parking_form_field.dart          # 주차 필드 위젯
│   │   │       ├── store_description_form_field.dart # 설명 입력 필드
│   │   │       ├── store_name_form_field.dart       # 매장 이름 필드
│   │   │       ├── store_number_form_field.dart     # 매장 전화번호 필드
│   │   ├── button/
│   │       ├── bottombutton.dart                    # 하단 버튼 위젯
│
├── firebase_options.dart               # Firebase 초기화 설정
└── main.dart                           # 메인 앱 실행 파일
