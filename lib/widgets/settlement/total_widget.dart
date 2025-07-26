import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  final double sevenPieceTotal;
  final double fourPieceTotal;
  final double eightPieceTotal;

  const TotalWidget({
    super.key,
    required this.sevenPieceTotal,
    required this.fourPieceTotal,
    required this.eightPieceTotal,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate Grand Total
    final double totalAmount =
        sevenPieceTotal + fourPieceTotal + eightPieceTotal;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header Section
              buildHeader(context, totalAmount),

              const Divider(thickness: 2.0),

              // Breakdown Section
              buildBreakdownSection(),

              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 10.0),

              // Grand Total Section
              buildGrandTotalSection(context, totalAmount),
            ],
          ),
        ),
      ),
    );
  }

  // Header Section
  Widget buildHeader(BuildContext context, double totalAmount) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(
            Icons.account_balance_wallet,
            size: 32.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Total Payment Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Breakdown Section
  Widget buildBreakdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Breakdown:',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),

        // 7-Piece Total
        buildBreakdownRow(
          '7-Piece Plates Total',
          sevenPieceTotal,
          Icons.restaurant,
          Colors.blue,
        ),

        // 4-Piece Total
        buildBreakdownRow(
          '4-Piece Plates Total',
          fourPieceTotal,
          Icons.lunch_dining,
          Colors.green,
        ),

        // 8-Piece Total
        buildBreakdownRow(
          '8-Piece Plates Total',
          eightPieceTotal,
          Icons.dinner_dining,
          Colors.orange,
        ),
      ],
    );
  }

  // Breakdown Row
  Widget buildBreakdownRow(
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Icon(icon, size: 18.0, color: color),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Grand Total Section
  Widget buildGrandTotalSection(BuildContext context, double totalAmount) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.red.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total to Pay',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                'Final Settlement Amount',
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '₹${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
