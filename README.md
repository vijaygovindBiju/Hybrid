# Hybrid — Music Player

A Flutter music player focused on local music discovery and playback, built with a feature-based and layered architecture designed for maintainability and future online music support.

## Overview

Hybrid is being developed as a modern music application that brings local playback together with a foundation for online music, search, playlists, offline access, and recommendations.

The current implementation focuses on the local music workflow and establishes the application's core architecture.

## Current Features

- Local music discovery with `OnAudioQuery`
- Application-specific song/domain models
- Feature-based project organization
- Layered separation between UI, state, repositories, and data sources
- Riverpod-based state management
- Audio playback foundation with `just_audio`

## Roadmap

| Feature | Status |
|---|---|
| Project foundation | ✅ Complete |
| Local music discovery | 🚧 In progress |
| Song model + repository | 🚧 In progress |
| Player | 🚧 In progress |
| Background playback | Planned |
| Lock-screen / media controls | Planned |
| Library management | Planned |
| Online music | Planned |
| Local + online search | Planned |
| Downloads / offline music | Planned |
| Favorites | Planned |
| Playlists | Planned |
| Recommendation system | Planned |
| Authentication / cloud | Planned |
| Playlist sharing & ratings | Planned |

## Architecture

Hybrid follows a **feature-based + layered architecture**. Features own their UI, state, and data flow instead of organizing the application primarily around pages or screens.

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── router/
│   └── utils/
│
├── features/
│   ├── home/
│   ├── player/
│   ├── library/
│   ├── search/
│   ├── playlist/
│   ├── favorites/
│   ├── settings/
│   └── profile/
│
└── main.dart
```

### Data Flow

```text
UI
 ↓
Provider / Controller
 ↓
Repository
 ↓
Data Source
 ↓
Plugin / API / Database
```

Responsibilities are intentionally separated:

- **UI** — renders state and handles user interaction.
- **Provider / Controller** — owns feature state and coordinates operations.
- **Repository** — coordinates data sources and hides data-origin details.
- **Data Source** — performs direct plugin, API, or database operations.

External plugin models are mapped to application-owned models at the data boundary instead of leaking into the rest of the application.

## Tech Stack

- **Flutter** — cross-platform UI framework
- **Dart** — application language
- **Riverpod** — state management
- **OnAudioQuery** — local music discovery
- **just_audio** — audio playback
- **audio_service** — background playback and media controls planned/integration path
- **go_router** — navigation

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.4`
- Dart SDK `^3.11.4`
- Android device or emulator for the current target workflow

### Setup

```bash
git clone https://github.com/vijaygovindBiju/Hybrid.git
cd Hybrid
flutter pub get
flutter run
```

### Android permissions

Local audio discovery requires Android media permissions appropriate to the Android version, including `READ_MEDIA_AUDIO` on Android 13+ and legacy external-storage access on supported older versions.

## Engineering Principles

- Keep business logic out of widgets.
- Maintain a clear source of truth for feature state.
- Isolate third-party plugins at the data boundary.
- Represent failures explicitly instead of silently ignoring them.
- Prefer small, purposeful dependencies.
- Keep layers independently testable.

## Status

Hybrid is an active learning and portfolio project. The architecture is being established first so additional player, online, and recommendation features can be added without turning the codebase into a tightly coupled application.

## License

This project is for portfolio and learning purposes.
