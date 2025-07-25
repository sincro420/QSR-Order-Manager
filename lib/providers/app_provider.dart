import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_state.dart';
import '../screens/history_screen.dart'; // Import Transaction class

class AppProvider extends ChangeNotifier {
  AppState _state = AppState();

  AppState get state => _state;

  // 7-piece plate increment methods
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
      case 'paneer':
        _state = _state.copyWith(
          paneer7PieceNo: _state.paneer7PieceNo + 1,
          history: newHistory,
        );
        break;
    }
    notifyListeners();
    _saveState();
  }

  // 7-piece plate decrement methods
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
      case 'paneer':
        if (_state.paneer7PieceNo > 0) {
          _state = _state.copyWith(
            paneer7PieceNo: _state.paneer7PieceNo - 1,
            history: newHistory,
          );
        }
        break;
    }
    notifyListeners();
    _saveState();
  }

  // 8-piece plate increment methods
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
      case 'paneer':
        _state = _state.copyWith(
          paneer8PieceNo: _state.paneer8PieceNo + 1,
          history: newHistory,
        );
        break;
    }
    notifyListeners();
    _saveState();
  }

  // 8-piece plate decrement methods
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
      case 'paneer':
        if (_state.paneer8PieceNo > 0) {
          _state = _state.copyWith(
            paneer8PieceNo: _state.paneer8PieceNo - 1,
            history: newHistory,
          );
        }
        break;
    }
    notifyListeners();
    _saveState();
  }

  // Reset all counters to zero
  void resetAll() {
    _state = AppState(darkMode: _state.darkMode);
    notifyListeners();
    _saveState();
  }

  // Toggle between light and dark themes
  void toggleTheme() {
    _state = _state.copyWith(darkMode: !_state.darkMode);
    notifyListeners();
    _saveState();
  }

  // Save state to SharedPreferences
  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateJson = jsonEncode(_state.toJson());
    await prefs.setString('app_state', stateJson);
  }

  // Load state from SharedPreferences
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
      // If there's an error loading the state, use the default state
      _state = AppState();
    }
  }
}
