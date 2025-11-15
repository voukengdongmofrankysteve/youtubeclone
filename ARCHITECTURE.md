# YouTube Clone - Architecture

## Main Screen Structure

The app now uses a centralized navigation system with a main screen that manages all tabs.

### File Structure

```
lib/
├── main.dart                      # App entry point
├── app.dart                       # MaterialApp configuration
├── screens/
│   ├── main_screen.dart          # ⭐ Main container with bottom nav
│   ├── home_screen.dart          # Home feed (no bottom nav)
│   ├── shorts_screen.dart        # Shorts feed (no bottom nav)
│   ├── subscriptions_screen.dart # Subscriptions page
│   └── library_screen.dart       # Library page
├── widgets/
│   ├── custom_bottom_nav.dart    # Unified bottom navigation
│   ├── shorts_section.dart       # Shorts horizontal carousel
│   ├── video_card.dart           # Video item widget
│   └── shorts_video_player.dart  # Shorts video player
└── models/
    └── video_model.dart          # Data models
```

## Navigation Architecture

### MainScreen (main_screen.dart)
- **Central Hub**: Manages all bottom navigation state
- **IndexedStack**: Efficiently switches between screens without rebuilding
- **5 Tabs**: Home, Shorts, Add, Subscriptions, Library
- **Single Bottom Nav**: One instance shared across all screens

### Benefits
✅ **No Navigation Stack Issues**: Screens switch via tabs, not routes
✅ **Persistent State**: Each screen maintains its state when switching tabs
✅ **Single Source of Truth**: Bottom nav controlled in one place
✅ **Clean Architecture**: Separation of concerns

## Screen Responsibilities

### 1. Home Screen
- Video feed display
- Shorts carousel
- Top app bar with search/notifications
- **No bottom nav** (managed by MainScreen)

### 2. Shorts Screen
- Full-screen vertical video feed
- Swipe up/down to navigate
- Action buttons (like, comment, share)
- Overlay controls
- **No bottom nav** (managed by MainScreen)

### 3. Subscriptions Screen
- Placeholder for subscribed channels
- Ready for future implementation

### 4. Library Screen
- History, Watch Later, Liked Videos sections
- Playlists (placeholder)
- Ready for future implementation

## Bottom Navigation Flow

```
User taps bottom nav item
        ↓
MainScreen._onNavItemTapped(index)
        ↓
setState updates _currentIndex
        ↓
IndexedStack displays screen at index
        ↓
Screen renders without rebuilding others
```

## Key Features

### Unified Bottom Navigation
- **Location**: `lib/widgets/custom_bottom_nav.dart`
- **Properties**:
  - `currentIndex`: Which tab is active
  - `onTap`: Callback for tab selection
- **Icons**: Home, Shorts, Add, Subscriptions, Library
- **Styling**: YouTube dark theme

### Screen Switching (IndexedStack)
Instead of pushing/popping routes, screens are layered and visibility is toggled:
```dart
IndexedStack(
  index: _currentIndex,  // Only this screen is visible
  children: _screens,     // All screens loaded but hidden
)
```

**Advantages**:
- ✅ Instant switching (no animation delay)
- ✅ State preservation (scroll position, form data)
- ✅ Memory efficient (Flutter optimizes hidden widgets)

## Usage

### Running the App
```bash
flutter run
```

### Navigating Between Screens
1. Tap bottom nav icons to switch screens
2. All screens stay in memory
3. Return to previous position when switching back

### Adding New Screens
1. Create screen file in `lib/screens/`
2. Add to `_screens` list in `main_screen.dart`
3. Update bottom nav if needed

## Future Enhancements

- [ ] Video playback integration
- [ ] User authentication
- [ ] Real API integration
- [ ] Search functionality
- [ ] Channel pages
- [ ] Comments system
- [ ] Upload feature
- [ ] Watch history tracking
