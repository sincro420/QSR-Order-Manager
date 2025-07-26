import '../screens/history_screen.dart'; // Import Transaction class

class AppState {
  // Steam counters - 7-piece plates
  final int steamVeg7PieceNo;
  final int steamChicken7PieceNo;

  // Steam counters - 4-piece plates
  final int steamVeg4PieceNo;
  final int steamChicken4PieceNo;

  // Steam counters - 8-piece plates
  final int steamVeg8PieceNo;
  final int steamChicken8PieceNo;

  // Fried counters - 7-piece plates
  final int friedVeg7PieceNo;
  final int friedChicken7PieceNo;

  // Fried counters - 4-piece plates
  final int friedVeg4PieceNo;
  final int friedChicken4PieceNo;

  // Fried counters - 8-piece plates
  final int friedVeg8PieceNo;
  final int friedChicken8PieceNo;

  // Theme settings
  final bool darkMode;

  // History of transactions
  final List<Transaction> history;

  const AppState({
    this.steamVeg7PieceNo = 0,
    this.steamChicken7PieceNo = 0,
    this.steamVeg4PieceNo = 0,
    this.steamChicken4PieceNo = 0,
    this.steamVeg8PieceNo = 0,
    this.steamChicken8PieceNo = 0,
    this.friedVeg7PieceNo = 0,
    this.friedChicken7PieceNo = 0,
    this.friedVeg4PieceNo = 0,
    this.friedChicken4PieceNo = 0,
    this.friedVeg8PieceNo = 0,
    this.friedChicken8PieceNo = 0,
    this.darkMode = false,
    this.history = const [],
  });

  // Copy constructor for immutability - FULLY UPDATED
  AppState copyWith({
    int? steamVeg7PieceNo,
    int? steamChicken7PieceNo,
    int? steamVeg4PieceNo,
    int? steamChicken4PieceNo,
    int? steamVeg8PieceNo,
    int? steamChicken8PieceNo,
    int? friedVeg7PieceNo,
    int? friedChicken7PieceNo,
    int? friedVeg4PieceNo,
    int? friedChicken4PieceNo,
    int? friedVeg8PieceNo,
    int? friedChicken8PieceNo,
    bool? darkMode,
    List<Transaction>? history,
  }) {
    return AppState(
      steamVeg7PieceNo: steamVeg7PieceNo ?? this.steamVeg7PieceNo,
      steamChicken7PieceNo: steamChicken7PieceNo ?? this.steamChicken7PieceNo,
      steamVeg4PieceNo: steamVeg4PieceNo ?? this.steamVeg4PieceNo,
      steamChicken4PieceNo: steamChicken4PieceNo ?? this.steamChicken4PieceNo,
      steamVeg8PieceNo: steamVeg8PieceNo ?? this.steamVeg8PieceNo,
      steamChicken8PieceNo: steamChicken8PieceNo ?? this.steamChicken8PieceNo,
      friedVeg7PieceNo: friedVeg7PieceNo ?? this.friedVeg7PieceNo,
      friedChicken7PieceNo: friedChicken7PieceNo ?? this.friedChicken7PieceNo,
      friedVeg4PieceNo: friedVeg4PieceNo ?? this.friedVeg4PieceNo,
      friedChicken4PieceNo: friedChicken4PieceNo ?? this.friedChicken4PieceNo,
      friedVeg8PieceNo: friedVeg8PieceNo ?? this.friedVeg8PieceNo,
      friedChicken8PieceNo: friedChicken8PieceNo ?? this.friedChicken8PieceNo,
      darkMode: darkMode ?? this.darkMode,
      history: history ?? this.history,
    );
  }

  // Convert to JSON for persistence - FULLY UPDATED
  Map<String, dynamic> toJson() {
    return {
      'steamVeg7PieceNo': steamVeg7PieceNo,
      'steamChicken7PieceNo': steamChicken7PieceNo,
      'steamVeg4PieceNo': steamVeg4PieceNo,
      'steamChicken4PieceNo': steamChicken4PieceNo,
      'steamVeg8PieceNo': steamVeg8PieceNo,
      'steamChicken8PieceNo': steamChicken8PieceNo,
      'friedVeg7PieceNo': friedVeg7PieceNo,
      'friedChicken7PieceNo': friedChicken7PieceNo,
      'friedVeg4PieceNo': friedVeg4PieceNo,
      'friedChicken4PieceNo': friedChicken4PieceNo,
      'friedVeg8PieceNo': friedVeg8PieceNo,
      'friedChicken8PieceNo': friedChicken8PieceNo,
      'darkMode': darkMode,
      'history': history.map((t) => t.toJson()).toList(),
    };
  }

  // Create from JSON for persistence - FULLY UPDATED
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      steamVeg7PieceNo: json['steamVeg7PieceNo'] ?? 0,
      steamChicken7PieceNo: json['steamChicken7PieceNo'] ?? 0,
      steamVeg4PieceNo: json['steamVeg4PieceNo'] ?? 0,
      steamChicken4PieceNo: json['steamChicken4PieceNo'] ?? 0,
      steamVeg8PieceNo: json['steamVeg8PieceNo'] ?? 0,
      steamChicken8PieceNo: json['steamChicken8PieceNo'] ?? 0,
      friedVeg7PieceNo: json['friedVeg7PieceNo'] ?? 0,
      friedChicken7PieceNo: json['friedChicken7PieceNo'] ?? 0,
      friedVeg4PieceNo: json['friedVeg4PieceNo'] ?? 0,
      friedChicken4PieceNo: json['friedChicken4PieceNo'] ?? 0,
      friedVeg8PieceNo: json['friedVeg8PieceNo'] ?? 0,
      friedChicken8PieceNo: json['friedChicken8PieceNo'] ?? 0,
      darkMode: json['darkMode'] ?? false,
      history:
          json['history'] != null
              ? List<Transaction>.from(
                (json['history'] as List<dynamic>).map(
                  (item) => Transaction.fromJson(item as Map<String, dynamic>),
                ),
              )
              : [],
    );
  }
}
