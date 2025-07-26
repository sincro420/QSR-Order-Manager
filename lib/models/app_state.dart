import '../screens/history_screen.dart'; // Import Transaction class

class AppState {
  // 7-piece plates counters
  int veg7PieceNo;
  int chicken7PieceNo;

  // 4-piece plates counters
  int veg4PieceNo;
  int chicken4PieceNo;

  // 8-piece plates counters
  int veg8PieceNo;
  int chicken8PieceNo;

  // Theme settings
  bool darkMode;

  // History of transactions
  final List<Transaction> history;

  AppState({
    this.veg7PieceNo = 0,
    this.chicken7PieceNo = 0,
    this.veg4PieceNo = 0,
    this.chicken4PieceNo = 0,
    this.veg8PieceNo = 0,
    this.chicken8PieceNo = 0,
    this.darkMode = false,
    this.history = const [],
  });

  // Copy constructor for immutability - FULLY UPDATED
  AppState copyWith({
    int? veg7PieceNo,
    int? chicken7PieceNo,
    int? veg4PieceNo,
    int? chicken4PieceNo,
    int? veg8PieceNo,
    int? chicken8PieceNo,
    bool? darkMode,
    List<Transaction>? history,
  }) {
    return AppState(
      veg7PieceNo: veg7PieceNo ?? this.veg7PieceNo,
      chicken7PieceNo: chicken7PieceNo ?? this.chicken7PieceNo,
      veg4PieceNo: veg4PieceNo ?? this.veg4PieceNo,
      chicken4PieceNo: chicken4PieceNo ?? this.chicken4PieceNo,
      veg8PieceNo: veg8PieceNo ?? this.veg8PieceNo,
      chicken8PieceNo: chicken8PieceNo ?? this.chicken8PieceNo,
      darkMode: darkMode ?? this.darkMode,
      history: history ?? this.history,
    );
  }

  // Convert to JSON for persistence - FULLY UPDATED
  Map<String, dynamic> toJson() {
    return {
      'veg7PieceNo': veg7PieceNo,
      'chicken7PieceNo': chicken7PieceNo,
      'veg4PieceNo': veg4PieceNo,
      'chicken4PieceNo': chicken4PieceNo,
      'veg8PieceNo': veg8PieceNo,
      'chicken8PieceNo': chicken8PieceNo,
      'darkMode': darkMode,
      'history': history.map((t) => t.toJson()).toList(),
    };
  }

  // Create from JSON for persistence - FULLY UPDATED
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      veg7PieceNo: json['veg7PieceNo'] ?? 0,
      chicken7PieceNo: json['chicken7PieceNo'] ?? 0,
      veg4PieceNo: json['veg4PieceNo'] ?? 0,
      chicken4PieceNo: json['chicken4PieceNo'] ?? 0,
      veg8PieceNo: json['veg8PieceNo'] ?? 0,
      chicken8PieceNo: json['chicken8PieceNo'] ?? 0,
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
