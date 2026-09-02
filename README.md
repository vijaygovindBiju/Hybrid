# Hybrid — Music Player

A portfolio-quality music application built with Flutter, demonstrating strong software-engineering practices through a clean, scalable, feature-based architecture.

---

## Features

| Feature | Status |
|---|---|
| Local music playback | In Progress |
| Library management | In Progress |
| Background playback | Planned |
| Lock-screen / media controls | Planned |
| Online music (Jamendo) | Planned |
| Local + online search | Planned |
| Favorites | Planned |
| Playlists | Planned |
| Offline / downloaded music | Planned |
| Recommendation system | Planned |
| Playlist sharing & ratings | Planned |

---

## Architecture

Hybrid uses a **feature-based + layered architecture**. The project is not organized around pages/screens — it is organized around features, each owning its full vertical slice.

```
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

```
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

Each layer has a clearly defined responsibility:

- **UI** — renders state, handles user interaction. No business logic.
- **Provider / Controller** — owns state, coordinates operations, calls repositories.
- **Repository** — abstracts data origin, coordinates data sources.
- **Data Source** — direct plugin/API/database interaction.

Plugin-specific models (e.g., `OnAudioQuery`) are mapped to Hybrid's own domain models at the data boundary and never leaked into the rest of the application.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | UI framework |
| [Dart](https://dart.dev) | Programming language |
| [Riverpod](https://riverpod.dev) | State management |
| [OnAudioQuery](https://pub.dev/packages/on_audio_query) | Local music discovery |
| [just_audio](https://pub.dev/packages/just_audio) | Audio playback |
| [audio_service](https://pub.dev/packages/audio_service) | Background playback & media controls |
| [go_router](https://pub.dev/packages/go_router) | Navigation |

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.4`
- Android device or emulator (primary target platform)
- Dart SDK `^3.11.4`

### Setup

```bash
# Clone the repository
git clone <repository-url>
cd hybrid

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Android Permissions

The app requires the following permissions on Android:

- `READ_MEDIA_AUDIO` (Android 13+)
- `READ_EXTERNAL_STORAGE` (Android 12 and below)

These are requested at runtime on first launch.

---

## Engineering Principles

- **No business logic in widgets** — widgets render state and dispatch events only.
- **Single source of truth** — state has a clear, singular owner per feature.
- **Plugin isolation** — external plugin types are mapped to Hybrid's own models at the data layer boundary.
- **Explicit error handling** — errors are represented as application state; failures are never silently ignored.
- **Minimal dependencies** — a new package is only introduced when the existing stack cannot solve the problem.
- **Testability** — each layer is independently testable due to clear separation of concerns.

---

## Development Roadmap

```
1.  Project foundation          [done]
2.  Local music discovery       [in progress]
3.  Song model + repository     [in progress]
4.  Player                      [planned]
5.  Background playback         [planned]
6.  Library                     [planned]
7.  Online music                [planned]
8.  Downloads / offline         [planned]
9.  Recommendations             [planned]
10. Authentication / cloud      [planned]
11. Playlist sharing / ratings  [planned]
```

---

## License

This project is for portfolio and learning purposes.
