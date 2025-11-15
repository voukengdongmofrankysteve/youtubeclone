# YouTube Clone

A Flutter implementation of a YouTube-like application with a modern UI and smooth video playback experience.

## Features

- **Dark Theme UI** - Modern dark theme matching YouTube's aesthetic
- **Video Feed** - Scrollable list of video cards with thumbnails and metadata
- **Shorts Section** - Horizontal scrollable carousel for short-form videos
- **Responsive Design** - Works on both mobile and tablet devices
- **Video Playback** - Integrated video player with controls
- **Search Functionality** - Search for videos and channels

## Screenshots

*Screenshots will be added soon*

## Getting Started

### Repository Setup

This project is maintained in two repositories for backup and mirroring purposes. Here's how to set up both remotes:

#### Step 1 — Add the FIRST repo (origin)
If not added yet:
```bash
git remote add origin https://github.com/voukengdongmofrankysteve/youtubeclone.git
```

Check remotes:
```bash
git remote -v
```

#### Step 2 — Add the SECOND repo (public)
Add another remote called public:
```bash
git remote add public https://github.com/voukengdongmofrankysteve/youtube-clone.git
```

Check remotes again:
```bash
git remote -v
```

You should see:
```
origin  https://github.com/voukengdongmofrankysteve/youtubeclone.git (fetch)
origin  https://github.com/voukengdongmofrankysteve/youtubeclone.git (push)
public  https://github.com/voukengdongmofrankysteve/youtube-clone.git (fetch)
public  https://github.com/voukengdongmofrankysteve/youtube-clone.git (push)
```

#### Pushing Changes to Both Repositories

Push to origin (youtubeclone):
```bash
git push origin main
```

Push to public (youtube-clone):
```bash
git push public main
```

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/voukengdongmofrankysteve/youtube-clone.git
   cd youtube-clone
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── app.dart               # MaterialApp configuration
├── models/               # Data models
├── screens/              # App screens
├── services/             # API and service classes
└── widgets/              # Reusable widgets
```

## Dependencies

- `cupertino_icons: ^1.0.8`
- `http: ^1.5.0`
- `better_player_plus: ^1.1.2`
- `provider: ^6.1.1`
- `cached_network_image: ^3.3.0`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by YouTube's design and functionality
- Built with Flutter
- Special thanks to all contributors
