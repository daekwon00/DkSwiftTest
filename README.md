# DailyHub - iOS Portfolio Sample App

Swift/SwiftUI의 핵심 기능을 종합적으로 보여주는 포트폴리오용 샘플 앱입니다.

## 기술 스택

| 분류 | 기술 |
|------|------|
| UI | SwiftUI, NavigationStack, TabView |
| 아키텍처 | MVVM, Feature-based 폴더 구조 |
| 데이터 저장 | SwiftData (@Model, @Query) |
| 설정 저장 | @AppStorage (UserDefaults) |
| 네트워크 | URLSession + async/await + typed throws |
| 상태 관리 | @Observable (iOS 17+) |
| 차트 | Swift Charts (Bar, Line, Sector) |
| 동시성 | Swift 6 strict concurrency |

## 앱 구성

### 뉴스피드 탭
- JSONPlaceholder API 연동 (게시글/댓글/유저)
- NSCache 기반 이미지 캐싱
- 검색(.searchable), 당겨서 새로고침(.refreshable)
- NavigationStack으로 목록/상세 화면 전환

### 할 일 탭
- SwiftData를 활용한 CRUD (추가/삭제/완료 토글)
- 우선순위별 색상 구분 (높음/보통/낮음)
- 필터(전체/미완료/완료) 및 정렬(생성일/마감일/우선순위)
- swipeActions, ContentUnavailableView

### 설정 탭
- 프로필 편집 (이름, 이메일)
- 다크 모드 토글, 글자 크기 조절, 테마 색상 선택
- 전체 설정 초기화 (Alert 확인)

### UI 쇼케이스 탭
- Button 스타일 비교
- List 스타일 비교 (Inset/Grouped/Plain/Sidebar)
- Form 컴포넌트 (TextField, Toggle, Slider, Picker, Stepper, DatePicker)
- Alert & Sheet (기본 Alert, 확인 Alert, Sheet, Full Screen Cover)
- Animation (Spring, Rotation, Scale, PhaseAnimator)
- Swift Charts (Bar, Line, Pie)

## 프로젝트 구조

```
DkSwiftTest/
├── DkSwiftTestApp.swift          # 앱 진입점, SwiftData ModelContainer 설정
├── ContentView.swift             # TabView 4탭 구성
├── Core/
│   ├── Network/                  # NetworkService, AppError
│   ├── ImageCache/               # NSCache 기반 이미지 캐싱
│   ├── Components/               # 공통 뷰 (ErrorStateView)
│   └── Extensions/               # Date 포맷 헬퍼
└── Features/
    ├── NewsFeed/                  # Models, ViewModels, Views
    ├── Todo/                     # Models, ViewModels, Views
    ├── Settings/                 # Models, ViewModels, Views
    └── Showcase/Views/           # UI 데모 화면들
```

## 빌드 환경

- Xcode 26.3+
- iOS 26.2+
- Swift 6 (strict concurrency)
- 외부 라이브러리 없음 (순수 Apple 프레임워크)

## 빌드

```bash
xcodebuild -scheme DkSwiftTest -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

## 사용 API

- [JSONPlaceholder](https://jsonplaceholder.typicode.com) - 게시글, 댓글, 유저 데이터
- [picsum.photos](https://picsum.photos) - 썸네일 이미지
