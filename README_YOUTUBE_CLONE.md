# YouTube Clone - Home Screen

A Flutter implementation of a YouTube-like home screen interface based on the provided design.

## Features Implemented

✅ **Dark Theme UI** - Modern dark theme matching YouTube's aesthetic
✅ **Top Navigation Bar** - YouTube logo, search, and notifications
✅ **Home/Shorts Tabs** - Tab navigation between Home and Shorts sections
✅ **Shorts Section** - Horizontal scrollable carousel for short-form videos
✅ **Video Feed** - Vertical scrollable list of video cards with:
  - Video thumbnail with duration badge
  - Channel avatar
  - Video title
  - Channel name, views, and upload time
  - More options menu button
✅ **Bottom Navigation** - 5-item navigation bar (Home, Shorts, Create, Subscriptions, Library)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── models/
│   └── video_model.dart      # Data models for Video and Shorts
├── screens/
│   └── home_screen.dart      # Main home screen layout
└── widgets/
    ├── video_card.dart       # Video item widget
    └── shorts_section.dart   # Shorts carousel widget
```

## Demo Data

The app currently uses placeholder demo data defined in `models/video_model.dart`:
- 4 sample videos with metadata
- 3 sample shorts

## Adding Your Own Content

### Option 1: Replace Demo Data
Edit `lib/models/video_model.dart` and update the `demoVideos` and `demoShorts` lists.

### Option 2: Add Images
1. Create asset folders:
   ```
   assets/
   assets/thumbnails/
   assets/shorts/
   ```

2. Add your images:
   - Video thumbnails: `assets/thumbnails/`
   - Short videos: `assets/shorts/`
   - YouTube logo (optional): `assets/youtube_logo.png`

3. Update the file names in `video_model.dart` to match your images.

### Option 3: Connect to Backend API
Replace the demo data with API calls to fetch real video data from your backend:

```dart
// Example in home_screen.dart
Future<List<VideoModel>> fetchVideos() async {
  final response = await http.get(Uri.parse('YOUR_API_URL'));
  // Parse and return video data
}
```

## Color Scheme

The app uses YouTube's dark theme colors:
- Background: `#0F0F0F`
- Accent: Red (YouTube brand color)
- Text: White/Grey

## Running the App

1. Ensure Flutter is installed:
   ```bash
   flutter doctor
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Customization

### Change Theme Colors
Edit `lib/app.dart` in the `ThemeData` section:

```dart
theme: ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0F0F0F),
  primaryColor: Colors.red, // Change accent color
  // ...
)
```

### Modify Video Card Layout
Edit `lib/widgets/video_card.dart` to adjust spacing, sizes, or add new elements.

### Update Bottom Navigation
Edit the `bottomNavigationBar` in `lib/screens/home_screen.dart` to add/remove items.

## Next Steps

To make this a fully functional YouTube clone, consider adding:

- Video player screen
- Search functionality
- User authentication
- Video upload feature
- Comments section
- Like/dislike functionality
- Subscription management
- Channel pages
- Integration with video streaming backend

## Notes

- Images are loaded with error builders, so the app won't crash if assets are missing
- Fallback UI shows play icons when images can't be loaded
- All interactive elements (buttons, cards) currently have placeholder `onPressed` handlers

## Dependencies

Current Flutter dependencies from `pubspec.yaml`:
- `cupertino_icons: ^1.0.8`
- `http: ^1.5.0`
- `better_player_plus: ^1.1.2`
