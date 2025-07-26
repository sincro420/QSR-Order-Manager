import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/app_state.dart';
import '../screens/history_screen.dart'; // Import Transaction class

class AppProvider extends ChangeNotifier {
  AppState _state = AppState();

  AppState get state => _state;

  AppProvider() {
    loadState();
  }

  // 7-Piece Plate Methods

  void incrementSevenPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: category,
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        _state = _state.copyWith(
          veg7PieceNo: _state.veg7PieceNo + 1,
          history: newHistory,
        );
        break;
      case 'chicken':
        _state = _state.copyWith(
          chicken7PieceNo: _state.chicken7PieceNo + 1,
          history: newHistory,
        );
        break;
    }
    notifyListeners();
    saveState();
  }

  void decrementSevenPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'decrement',
        category: category,
        plateSize: 7,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        if (_state.veg7PieceNo > 0) {
          _state = _state.copyWith(
            veg7PieceNo: _state.veg7PieceNo - 1,
            history: newHistory,
          );
        }
        break;
      case 'chicken':
        if (_state.chicken7PieceNo > 0) {
          _state = _state.copyWith(
            chicken7PieceNo: _state.chicken7PieceNo - 1,
            history: newHistory,
          );
        }
        break;
    }
    notifyListeners();
    saveState();
  }

  // 4-Piece Plate Methods

  void incrementFourPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: category,
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        _state = _state.copyWith(
          veg4PieceNo: _state.veg4PieceNo + 1,
          history: newHistory,
        );
        break;
      case 'chicken':
        _state = _state.copyWith(
          chicken4PieceNo: _state.chicken4PieceNo + 1,
          history: newHistory,
        );
        break;
    }
    notifyListeners();
    saveState();
  }

  void decrementFourPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'decrement',
        category: category,
        plateSize: 4,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        if (_state.veg4PieceNo > 0) {
          _state = _state.copyWith(
            veg4PieceNo: _state.veg4PieceNo - 1,
            history: newHistory,
          );
        }
        break;
      case 'chicken':
        if (_state.chicken4PieceNo > 0) {
          _state = _state.copyWith(
            chicken4PieceNo: _state.chicken4PieceNo - 1,
            history: newHistory,
          );
        }
        break;
    }
    notifyListeners();
    saveState();
  }

  // 8-Piece Plate Methods

  void incrementEightPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'increment',
        category: category,
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        _state = _state.copyWith(
          veg8PieceNo: _state.veg8PieceNo + 1,
          history: newHistory,
        );
        break;
      case 'chicken':
        _state = _state.copyWith(
          chicken8PieceNo: _state.chicken8PieceNo + 1,
          history: newHistory,
        );
        break;
    }
    notifyListeners();
    saveState();
  }

  void decrementEightPiece(String category) {
    final newHistory = List<Transaction>.from(_state.history)..add(
      Transaction(
        action: 'decrement',
        category: category,
        plateSize: 8,
        timestamp: DateTime.now(),
      ),
    );

    switch (category) {
      case 'veg':
        if (_state.veg8PieceNo > 0) {
          _state = _state.copyWith(
            veg8PieceNo: _state.veg8PieceNo - 1,
            history: newHistory,
          );
        }
        break;
      case 'chicken':
        if (_state.chicken8PieceNo > 0) {
          _state = _state.copyWith(
            chicken8PieceNo: _state.chicken8PieceNo - 1,
            history: newHistory,
          );
        }
        break;
    }
    notifyListeners();
    saveState();
  }

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
      veg7PieceNo: 0,
      chicken7PieceNo: 0,
      veg4PieceNo: 0, // NEW
      chicken4PieceNo: 0, // NEW
      veg8PieceNo: 0,
      chicken8PieceNo: 0,
      history: newHistory,
    );
    notifyListeners();
    saveState();
  }

  void resetHistory() {
    _state = _state.copyWith(history: []);
    notifyListeners();
    saveState();
  }

  // =============================================================================
  // THEME METHODS - UNCHANGED
  // =============================================================================

  void toggleTheme() {
    _state = _state.copyWith(darkMode: !_state.darkMode);
    notifyListeners();
    saveState();
  }

  // =============================================================================
  // PERSISTENCE METHODS - UPDATED (Compatible with new state structure)
  // =============================================================================

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

  // Get total plates for a specific size
  int getTotalPlatesForSize(int plateSize) {
    switch (plateSize) {
      case 7:
        return _state.veg7PieceNo + _state.chicken7PieceNo;
      case 4:
        return _state.veg4PieceNo + _state.chicken4PieceNo;
      case 8:
        return _state.veg8PieceNo + _state.chicken8PieceNo;
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

  // Get category totals across all plate sizes
  int getCategoryTotal(String category) {
    switch (category) {
      case 'veg':
        return _state.veg7PieceNo + _state.veg4PieceNo + _state.veg8PieceNo;
      case 'chicken':
        return _state.chicken7PieceNo +
            _state.chicken4PieceNo +
            _state.chicken8PieceNo;
      default:
        return 0;
    }
  }
}
