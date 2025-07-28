enum Spender { om, rishiet, allan, revenue }

extension SpenderExtension on Spender {
  String get displayName {
    switch (this) {
      case Spender.om:
        return 'Om';
      case Spender.rishiet:
        return 'Rishiet';
      case Spender.allan:
        return 'Allan';
      case Spender.revenue:
        return 'Revenue';
    }
  }
}

class AccountingTransaction {
  final int? id;
  final DateTime createdAt;
  final String spender;
  final String reason;
  final double amount;
  final bool isIncrement;

  AccountingTransaction({
    this.id,
    required this.createdAt,
    required this.spender,
    required this.reason,
    required this.amount,
    required this.isIncrement,
  });

  factory AccountingTransaction.fromJson(Map<String, dynamic> json) {
    return AccountingTransaction(
      id: json['id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      spender: json['spender'] as String,
      reason: json['reason'] as String,
      amount: (json['amount'] as num).toDouble(),
      isIncrement: json['increment'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'spender': spender,
      'reason': reason,
      'amount': amount,
      'increment': isIncrement,
    };
  }
}
