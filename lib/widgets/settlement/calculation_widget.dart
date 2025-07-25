import 'package:flutter/material.dart';
import '../../utils/calculations.dart';

class CalculationWidget extends StatelessWidget {
  final String title;
  final int plateSize;
  final int vegCount;
  final int chickenCount;
  final int paneerCount;

  const CalculationWidget({
    super.key,
    required this.title,
    required this.plateSize,
    required this.vegCount,
    required this.chickenCount,
    required this.paneerCount,
  });

  @override
  Widget build(BuildContext context) {
    final double amount =
        plateSize == 7
            ? Calculations.calculate7PieceAmount(
              vegCount,
              chickenCount,
              paneerCount,
            )
            : Calculations.calculate8PieceAmount(
              vegCount,
              chickenCount,
              paneerCount,
            );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildCountRow(
              'Total Plates',
              plateSize == 7
                  ? ((vegCount + chickenCount + paneerCount) * 7 / 8)
                  : vegCount + chickenCount + paneerCount,
            ),
            const Divider(),
            _buildFormulaText(),
            const SizedBox(height: 8.0),
            _buildAmountRow('Amount to Supplier', amount),
          ],
        ),
      ),
    );
  }

  Widget _buildCountRow(String label, num count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaText() {
    String formula;

    if (plateSize == 7) {
      formula =
          '((Total Veg Momos) ÷ 8) × 30 + ((Total Chicken Momos) ÷ 8) × 35 + ((Total Paneer Momos) ÷ 8) × 40';
    } else {
      formula = 'Veg × 30 + Chicken × 35 + Paneer × 40';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        formula,
        style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
      ),
    );
  }
}
