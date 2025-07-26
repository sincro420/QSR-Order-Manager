import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/app_state.dart';
import '../screens/history_screen.dart'; // Import Transaction class

class AppProvider extends ChangeNotifier {
  AppState _state = const AppState();

  AppState get state => _state;

  AppProvider() {
    loadState();
  }

  // ===== STEAM VEG METHODS =====

  // 7-Piece Steam Veg
  void incrementSteamVeg7Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_veg',
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamVeg7PieceNo: _state.steamVeg7PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamVeg7Piece() {
    if (_state.steamVeg7PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_veg',
          plateSize: 7,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamVeg7PieceNo: _state.steamVeg7PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 4-Piece Steam Veg
  void incrementSteamVeg4Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_veg',
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamVeg4PieceNo: _state.steamVeg4PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamVeg4Piece() {
    if (_state.steamVeg4PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_veg',
          plateSize: 4,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamVeg4PieceNo: _state.steamVeg4PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 8-Piece Steam Veg
  void incrementSteamVeg8Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_veg',
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamVeg8PieceNo: _state.steamVeg8PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamVeg8Piece() {
    if (_state.steamVeg8PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_veg',
          plateSize: 8,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamVeg8PieceNo: _state.steamVeg8PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // ===== STEAM CHICKEN METHODS =====

  // 7-Piece Steam Chicken
  void incrementSteamChicken7Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_chicken',
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamChicken7PieceNo: _state.steamChicken7PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamChicken7Piece() {
    if (_state.steamChicken7PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_chicken',
          plateSize: 7,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamChicken7PieceNo: _state.steamChicken7PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 4-Piece Steam Chicken
  void incrementSteamChicken4Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_chicken',
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamChicken4PieceNo: _state.steamChicken4PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamChicken4Piece() {
    if (_state.steamChicken4PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_chicken',
          plateSize: 4,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamChicken4PieceNo: _state.steamChicken4PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 8-Piece Steam Chicken
  void incrementSteamChicken8Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'steam_chicken',
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      steamChicken8PieceNo: _state.steamChicken8PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementSteamChicken8Piece() {
    if (_state.steamChicken8PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'steam_chicken',
          plateSize: 8,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        steamChicken8PieceNo: _state.steamChicken8PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // ===== FRIED VEG METHODS =====

  // 7-Piece Fried Veg
  void incrementFriedVeg7Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_veg',
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedVeg7PieceNo: _state.friedVeg7PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedVeg7Piece() {
    if (_state.friedVeg7PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_veg',
          plateSize: 7,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedVeg7PieceNo: _state.friedVeg7PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 4-Piece Fried Veg
  void incrementFriedVeg4Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_veg',
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedVeg4PieceNo: _state.friedVeg4PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedVeg4Piece() {
    if (_state.friedVeg4PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_veg',
          plateSize: 4,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedVeg4PieceNo: _state.friedVeg4PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 8-Piece Fried Veg
  void incrementFriedVeg8Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_veg',
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedVeg8PieceNo: _state.friedVeg8PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedVeg8Piece() {
    if (_state.friedVeg8PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_veg',
          plateSize: 8,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedVeg8PieceNo: _state.friedVeg8PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // ===== FRIED CHICKEN METHODS =====

  // 7-Piece Fried Chicken
  void incrementFriedChicken7Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_chicken',
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedChicken7PieceNo: _state.friedChicken7PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedChicken7Piece() {
    if (_state.friedChicken7PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_chicken',
          plateSize: 7,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedChicken7PieceNo: _state.friedChicken7PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 4-Piece Fried Chicken
  void incrementFriedChicken4Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_chicken',
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedChicken4PieceNo: _state.friedChicken4PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedChicken4Piece() {
    if (_state.friedChicken4PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_chicken',
          plateSize: 4,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedChicken4PieceNo: _state.friedChicken4PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // 8-Piece Fried Chicken
  void incrementFriedChicken8Piece() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: 'fried_chicken',
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      friedChicken8PieceNo: _state.friedChicken8PieceNo + 1,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void decrementFriedChicken8Piece() {
    if (_state.friedChicken8PieceNo > 0) {
      final newHistory = List<Transaction>.from(_state.history)..add(
        Transaction(
          action: 'decrement',
          category: 'fried_chicken',
          plateSize: 8,
          timestamp: DateTime.now(),
        ),
      );

      _state = _state.copyWith(
        friedChicken8PieceNo: _state.friedChicken8PieceNo - 1,
        history: newHistory,
      );
      notifyListeners();
      saveState();
    }
  }

  // ===== UTILITY METHODS - UPDATED FOR NEW STRUCTURE =====

  // Reset all counters
  void resetAll() {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'reset',
        category: 'all',
        plateSize: 0,
        timestamp: DateTime.now(),
      ),
    );

    _state = _state.copyWith(
      // Reset all steam counters
      steamVeg7PieceNo: 0,
      steamChicken7PieceNo: 0,
      steamVeg4PieceNo: 0,
      steamChicken4PieceNo: 0,
      steamVeg8PieceNo: 0,
      steamChicken8PieceNo: 0,
      // Reset all fried counters
      friedVeg7PieceNo: 0,
      friedChicken7PieceNo: 0,
      friedVeg4PieceNo: 0,
      friedChicken4PieceNo: 0,
      friedVeg8PieceNo: 0,
      friedChicken8PieceNo: 0,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  // Reset history
  void resetHistory() {
    _state = _state.copyWith(history: []);
    notifyListeners();
    saveState();
  }

  // Toggle theme
  void toggleTheme() {
    _state = _state.copyWith(darkMode: !_state.darkMode);
    notifyListeners();
    saveState();
  }

  // ===== HELPER METHODS FOR TOTALS - UPDATED =====

  // Get total plates for a specific size (combining steam and fried)
  int getTotalPlatesForSize(int plateSize) {
    switch (plateSize) {
      case 7:
        return _state.steamVeg7PieceNo +
            _state.steamChicken7PieceNo +
            _state.friedVeg7PieceNo +
            _state.friedChicken7PieceNo;
      case 4:
        return _state.steamVeg4PieceNo +
            _state.steamChicken4PieceNo +
            _state.friedVeg4PieceNo +
            _state.friedChicken4PieceNo;
      case 8:
        return _state.steamVeg8PieceNo +
            _state.steamChicken8PieceNo +
            _state.friedVeg8PieceNo +
            _state.friedChicken8PieceNo;
      default:
        return 0;
    }
  }

  // Get total plates across all sizes
  int getTotalPlatesAllSizes() {
    return getTotalPlatesForSize(7) +
        getTotalPlatesForSize(4) +
        getTotalPlatesForSize(8);
  }

  // Get total veg plates (steam + fried)
  int getTotalVegPlates() {
    return _state.steamVeg7PieceNo +
        _state.steamVeg4PieceNo +
        _state.steamVeg8PieceNo +
        _state.friedVeg7PieceNo +
        _state.friedVeg4PieceNo +
        _state.friedVeg8PieceNo;
  }

  // Get total chicken plates (steam + fried)
  int getTotalChickenPlates() {
    return _state.steamChicken7PieceNo +
        _state.steamChicken4PieceNo +
        _state.steamChicken8PieceNo +
        _state.friedChicken7PieceNo +
        _state.friedChicken4PieceNo +
        _state.friedChicken8PieceNo;
  }

  // Get total steam plates
  int getTotalSteamPlates() {
    return _state.steamVeg7PieceNo +
        _state.steamChicken7PieceNo +
        _state.steamVeg4PieceNo +
        _state.steamChicken4PieceNo +
        _state.steamVeg8PieceNo +
        _state.steamChicken8PieceNo;
  }

  // Get total fried plates
  int getTotalFriedPlates() {
    return _state.friedVeg7PieceNo +
        _state.friedChicken7PieceNo +
        _state.friedVeg4PieceNo +
        _state.friedChicken4PieceNo +
        _state.friedVeg8PieceNo +
        _state.friedChicken8PieceNo;
  }

  // ===== PERSISTENCE METHODS - UPDATED FOR NEW STATE STRUCTURE =====

  Future<void> saveState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stateJson = jsonEncode(_state.toJson());
      await prefs.setString('app_state', stateJson);
    } catch (e) {
      debugPrint('Error saving state: $e');
    }
  }

  Future<void> loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stateJson = prefs.getString('app_state');
      if (stateJson != null) {
        final stateMap = jsonDecode(stateJson) as Map<String, dynamic>;
        _state = AppState.fromJson(stateMap);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading state: $e');
      // If loading fails, keep default state
    }
  }
}
