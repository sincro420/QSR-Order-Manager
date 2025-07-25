import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; //For date formatting
import '../providers/app_provider.dart';

// Define the Transaction model
class Transaction {
  final String action; // 'increment' or 'decrement'
  final String category; // 'veg', 'chicken', 'paneer'
  final int plateSize; // 7 or 8
  final DateTime timestamp;

  Transaction({
    required this.action,
    required this.category,
    required this.plateSize,
    required this.timestamp,
  });

  // Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'category': category,
      'plateSize': plateSize,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create from JSON for persistence
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      action: json['action'],
      category: json['category'],
      plateSize: json['plateSize'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          final history = appProvider.state.history;
          if (history.isEmpty) {
            return const Center(child: Text('No transactions yet.'));
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              // Display in reverse chronological order
              final transaction = history[history.length - 1 - index];
              return ListTile(
                title: Text(
                  '${transaction.action.capitalize()} ${transaction.category.capitalize()} ${transaction.plateSize}-Piece',
                ),
                subtitle: Text(
                  DateFormat.yMd().add_jm().format(transaction.timestamp),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Extension to capitalize strings for better display
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
