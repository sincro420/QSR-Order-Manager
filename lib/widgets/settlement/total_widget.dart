import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  final double sevenPieceTotal;
  final double eightPieceTotal;

  const TotalWidget({
    super.key,
    required this.sevenPieceTotal,
    required this.eightPieceTotal,
  });

  @override
  Widget build(BuildContext context) {
    final double totalAmount = sevenPieceTotal + eightPieceTotal;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Total to Pay',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              '₹${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(),
            _buildBreakdownRow('7-Piece Total', sevenPieceTotal),
            _buildBreakdownRow('8-Piece Total', eightPieceTotal),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
