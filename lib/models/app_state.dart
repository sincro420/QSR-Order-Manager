import '../screens/history_screen.dart'; // Import Transaction class

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

  // History of transactions
  final List<Transaction> history;

  AppState({
    this.veg7PieceNo = 0,
    this.chicken7PieceNo = 0,
    this.paneer7PieceNo = 0,
    this.veg8PieceNo = 0,
    this.chicken8PieceNo = 0,
    this.paneer8PieceNo = 0,
    this.darkMode = false,
    this.history = const [],
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
    List<Transaction>? history,
  }) {
    return AppState(
      veg7PieceNo: veg7PieceNo ?? this.veg7PieceNo,
      chicken7PieceNo: chicken7PieceNo ?? this.chicken7PieceNo,
      paneer7PieceNo: paneer7PieceNo ?? this.paneer7PieceNo,
      veg8PieceNo: veg8PieceNo ?? this.veg8PieceNo,
      chicken8PieceNo: chicken8PieceNo ?? this.chicken8PieceNo,
      paneer8PieceNo: paneer8PieceNo ?? this.paneer8PieceNo,
      darkMode: darkMode ?? this.darkMode,
      history: history ?? this.history,
    );
  }

  // Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'veg7PieceNo': veg7PieceNo,
      'chicken7PieceNo': chicken7PieceNo,
      'paneer7PieceNo': paneer7PieceNo,
      'veg8PieceNo': veg8PieceNo,
      'chicken8PieceNo': chicken8PieceNo,
      'paneer8PieceNo': paneer8PieceNo,
      'darkMode': darkMode,
      'history': history.map((t) => t.toJson()).toList(),
    };
  }

  // Create from JSON for persistence
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      veg7PieceNo: json['veg7PieceNo'] ?? 0,
      chicken7PieceNo: json['chicken7PieceNo'] ?? 0,
      paneer7PieceNo: json['paneer7PieceNo'] ?? 0,
      veg8PieceNo: json['veg8PieceNo'] ?? 0,
      chicken8PieceNo: json['chicken8PieceNo'] ?? 0,
      paneer8PieceNo: json['paneer8PieceNo'] ?? 0,
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
