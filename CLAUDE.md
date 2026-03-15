# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Command

```bash
xcodebuild -scheme DkSwiftTest -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

No test target exists yet.

## Swift 6 Concurrency Requirements

This project uses **strict Swift 6 concurrency** with these build settings:
- `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` — all types are implicitly `@MainActor`
- `SWIFT_APPROACHABLE_CONCURRENCY = YES`
- `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`

**Key implications:**
- Model structs that need `Codable + Sendable` (for network decoding) must be marked `nonisolated`
- `NetworkService.fetch` uses typed throws: `throws(AppError)` — callers must use `do throws(AppError)` or cast appropriately
- ViewModels using `@Observable` are naturally MainActor-isolated, which is correct for SwiftUI

## Project Configuration

- **Xcode 26.3**, iOS 26.2 deployment target
- `PBXFileSystemSynchronizedRootGroup` — files added to `DkSwiftTest/` are auto-discovered by Xcode; no `project.pbxproj` edits needed for new files
- Pure Apple frameworks only (no SPM dependencies)
- SwiftData `ModelContainer` configured in `DkSwiftTestApp.swift` for `[TodoItem.self]`

## Architecture

MVVM with feature-based folder organization. Four-tab app (뉴스피드/할 일/설정/쇼케이스):

- **Core/** — shared infrastructure (NetworkService with typed throws, NSCache-based ImageCacheService, ErrorStateView, Date extensions)
- **Features/{FeatureName}/** — each feature has Models/, ViewModels/, Views/ subdirectories
- **Entry point:** `ContentView.swift` hosts `TabView`; `DkSwiftTestApp.swift` sets up SwiftData container

Key patterns:
- `NetworkService.shared.fetch<T>()` — generic async/await URLSession wrapper returning `AppError` typed throws
- `CachedImageView` — drop-in replacement for AsyncImage with NSCache backing
- `@Observable` ViewModels, `@Query` for SwiftData, `@AppStorage` for UserDefaults
- External APIs: JSONPlaceholder (`jsonplaceholder.typicode.com`), picsum.photos for thumbnails
