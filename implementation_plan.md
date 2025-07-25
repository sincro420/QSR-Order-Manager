# Food Ordering and Settlement Tracking Application - Implementation Plan

## Project Overview

This document outlines the comprehensive implementation plan for a food ordering and settlement tracking application with three main pages:

1. **Home Page**: For tracking food orders across three categories (Veg, Chicken, Paneer) with 7-piece and 8-piece plate options
2. **Settlement Page**: For calculating payments to suppliers based on ordered quantities
3. **Settings Page**: For resetting values and toggling theme preferences

## 1. Architecture and Technology Stack

### Recommended Technology Stack

- **Framework**: Flutter with Dart
- **State Management**: Provider or Riverpod for reactive state management
- **Styling**: Flutter's built-in theming and Material Design components
- **Storage**: SharedPreferences for persistence between sessions
- **Build Tool**: Flutter SDK and Dart DevTools
- **Testing**: Flutter Test framework for widget, unit, and integration tests

### Project Structure

```
lib/
├── assets/            # Static assets like icons
├── widgets/           # Reusable UI widgets
│   ├── common/        # Buttons, inputs, etc.
│   ├── home/          # Home page specific widgets
│   ├── settlement/    # Settlement page specific widgets
│   └── settings/      # Settings page specific widgets
├── models/            # Data models
├── providers/         # State management
│   ├── app_provider.dart    # Main application state
│   └── theme_provider.dart  # Theme management
├── screens/           # Main screen widgets
│   ├── home_screen.dart
│   ├── settlement_screen.dart
│   └── settings_screen.dart
├── utils/             # Helper functions
│   └── calculations.dart    # Settlement calculations
├── constants/         # App constants
├── theme/             # Theme configuration
├── main.dart          # Entry point
└── app.dart           # Main application widget
```

## 2. Data Model

### Core State Model

```dart
class AppState {
  // 7-piece plates counters
  int veg7PieceNo;
  int chicken7PieceNo;
  int paneer7PieceNo;
  
  // 8-piece plates counters
  int veg8PieceNo;
  int chicken8PieceNo;
  int paneer8PieceNo;
  
  // Theme settings
  bool darkMode;
  
  AppState({
    this.veg7PieceNo = 0,
    this.chicken7PieceNo = 0,
    this.paneer7PieceNo = 0,
    this.veg8PieceNo = 0,
    this.chicken8PieceNo = 0,
    this.paneer8PieceNo = 0,
    this.darkMode = false,
  });
  
  // Copy constructor for immutability
  AppState copyWith({
    int? veg7PieceNo,
    int? chicken7PieceNo,
    int? paneer7PieceNo,
    int? veg8PieceNo,
    int? chicken8PieceNo,
    int? paneer8PieceNo,
    bool? darkMode,
  }) {
    return AppState(
      veg7PieceNo: veg7PieceNo ?? this.veg7PieceNo,
      chicken7PieceNo: chicken7PieceNo ?? this.chicken7PieceNo,
      paneer7PieceNo: paneer7PieceNo ?? this.paneer7PieceNo,
      veg8PieceNo: veg8PieceNo ?? this.veg8PieceNo,
      chicken8PieceNo: chicken8PieceNo ?? this.chicken8PieceNo,
      paneer8PieceNo: paneer8PieceNo ?? this.paneer8PieceNo,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
```

### Constants

```dart
class Prices {
  static const double VEG_PRICE = 30;      // ₹30 per 8 pieces
  static const double CHICKEN_PRICE = 35;   // ₹35 per 8 pieces
  static const double PANEER_PRICE = 40;    // ₹40 per 8 pieces
}
```

## 3. Component Design

### Home Screen Widgets

1. **CategoryColumn**
   - Parameters: category, sevenPieceValue, eightPieceValue, onIncrementSevenPiece, onDecrementSevenPiece, onIncrementEightPiece, onDecrementEightPiece
   - Responsibilities: Display category name, current values, and increment/decrement buttons

2. **CounterWidget**
   - Parameters: label, value, onIncrement, onDecrement, size (large or small)
   - Responsibilities: Display counter with plus/minus buttons

### Settlement Screen Widgets

1. **CalculationWidget**
   - Parameters: title, plateSize, vegCount, chickenCount, paneerCount
   - Responsibilities: Calculate and display the settlement amount for a specific plate size

2. **TotalWidget**
   - Parameters: sevenPieceTotal, eightPieceTotal
   - Responsibilities: Display the combined total amount

### Settings Screen Widgets

1. **ResetButton**
   - Parameters: onReset
   - Responsibilities: Reset all counters to zero

2. **ThemeToggle**
   - Parameters: darkMode, onToggle
   - Responsibilities: Toggle between light and dark themes using Flutter's ThemeMode

## 4. State Management

### State Management with Provider

```dart
class AppProvider extends ChangeNotifier {
  AppState _state = AppState();
  
  AppState get state => _state;
  
  void incrementSevenPiece(String category) {
    switch (category) {
      case 'veg':
        _state = _state.copyWith(veg7PieceNo: _state.veg7PieceNo + 1);
        break;
      case 'chicken':
        _state = _state.copyWith(chicken7PieceNo: _state.chicken7PieceNo + 1);
        break;
      case 'paneer':
        _state = _state.copyWith(paneer7PieceNo: _state.paneer7PieceNo + 1);
        break;
    }
    notifyListeners();
    _saveState();
  }
  
  void decrementSevenPiece(String category) {
    switch (category) {
      case 'veg':
        if (_state.veg7PieceNo > 0) {
          _state = _state.copyWith(veg7PieceNo: _state.veg7PieceNo - 1);
        }
        break;
      case 'chicken':
        if (_state.chicken7PieceNo > 0) {
          _state = _state.copyWith(chicken7PieceNo: _state.chicken7PieceNo - 1);
        }
        break;
      case 'paneer':
        if (_state.paneer7PieceNo > 0) {
          _state = _state.copyWith(paneer7PieceNo: _state.paneer7PieceNo - 1);
        }
        break;
    }
    notifyListeners();
    _saveState();
  }
  
  // Similar methods for incrementEightPiece and decrementEightPiece
  
  void resetAll() {
    _state = AppState();
    notifyListeners();
    _saveState();
  }
  
  void toggleTheme() {
    _state = _state.copyWith(darkMode: !_state.darkMode);
    notifyListeners();
    _saveState();
  }
  
  // Methods for persistence
  Future<void> _saveState() async {
    // Implementation for saving to SharedPreferences
  }
  
  Future<void> loadState() async {
    // Implementation for loading from SharedPreferences
  }
}

### Calculation Functions

1. **calculate7PieceAmount**: Calculate the amount for 7-piece plates
   - Formula: `((veg7PieceNo*7)/8)*30 + ((chicken7PieceNo*7)/8)*35 + ((paneer7PieceNo*7)/8)*40`

2. **calculate8PieceAmount**: Calculate the amount for 8-piece plates
   - Formula: `veg8PieceNo*30 + chicken8PieceNo*35 + paneer8PieceNo*40`

3. **calculateTotalAmount**: Sum of 7-piece and 8-piece amounts

## 5. Navigation and Routing

Implement Flutter navigation with the following routes:

- `/` - Home Screen
- `/settlement` - Settlement Screen
- `/settings` - Settings Screen

Use Flutter's BottomNavigationBar or TabBar for navigation between screens with appropriate icons.

## 6. Persistence

Implement SharedPreferences to persist the application state between sessions:

1. Save state to SharedPreferences whenever it changes
2. Load state from SharedPreferences when the application starts
3. Handle fallback to default values if no saved state exists
4. Use JSON serialization for storing complex state objects

## 7. Theme Implementation

1. Use Flutter's built-in ThemeData for theme configuration
2. Create light and dark ThemeData instances
3. Use MaterialApp's theme and darkTheme properties
4. Toggle between themes using ThemeMode.light and ThemeMode.dark
5. Persist theme preference in SharedPreferences

## 8. Error Handling and Validation

1. Implement input validation to prevent negative values
2. Add error boundaries to catch and handle unexpected errors
3. Implement graceful degradation for calculation errors

## 9. Testing Strategy

### Unit Tests

1. Test calculation functions for accuracy
2. Test provider methods for correct state updates
3. Test utility functions

### Widget Tests

1. Test rendering of widgets with different parameters
2. Test user interactions (button taps, etc.)
3. Test theme switching functionality

### Integration Tests

1. Test the complete order flow
2. Test settlement calculations with various inputs
3. Test persistence functionality
4. Use Flutter's integration_test package for end-to-end testing

## 10. Implementation Phases

### Phase 1: Project Setup and Core Structure

1. Initialize project with Flutter CLI (`flutter create`)
2. Set up Dart and Flutter SDK configuration
3. Create basic project structure
4. Implement state management with Provider

### Phase 2: Home Screen Implementation

1. Create UI widgets for the Home Screen
2. Implement counter functionality
3. Style the widgets according to the design using Flutter's Material Design components

### Phase 3: Settlement Screen Implementation

1. Create UI widgets for the Settlement Screen
2. Implement calculation logic
3. Style the widgets according to the design using Flutter's Material Design components

### Phase 4: Settings Screen Implementation

1. Create UI widgets for the Settings Screen
2. Implement reset functionality
3. Implement theme toggle using Flutter's ThemeMode
4. Style the widgets according to the design using Flutter's Material Design components

### Phase 5: Navigation and Integration

1. Implement routing between screens using Navigator 2.0 or GoRouter
2. Ensure consistent state across screens using Provider
3. Add navigation UI with BottomNavigationBar or TabBar

### Phase 6: Persistence and Refinement

1. Implement SharedPreferences persistence
2. Add error handling with try-catch blocks
3. Optimize performance using Flutter DevTools
4. Implement proper state management patterns

### Phase 7: Testing and Quality Assurance

1. Write unit tests
2. Write component tests
3. Write integration tests
4. Perform manual testing

## 11. Quality Assurance Checklist

- [ ] All calculations are accurate
- [ ] UI is responsive and works on different screen sizes
- [ ] Theme switching works correctly
- [ ] State persists between sessions
- [ ] No console errors or warnings
- [ ] All tests pass
- [ ] Code is well-documented
- [ ] Accessibility standards are met

## 12. Deployment Strategy

1. Build the application for production (`flutter build`)
2. Generate platform-specific builds (APK for Android, IPA for iOS)
3. Deploy to app stores (Google Play Store, Apple App Store)
4. Set up continuous integration/continuous deployment (CI/CD) with GitHub Actions or Codemagic

## 13. Future Enhancements

1. Add user authentication for multiple users
2. Implement history tracking for past settlements
3. Add export functionality for reports
4. Create a mobile app version
5. Add notifications for important events

---

This implementation plan provides a comprehensive roadmap for developing the food ordering and settlement tracking application. By following this structured approach, we can ensure a high-quality, maintainable, and error-free application that meets all the requirements.