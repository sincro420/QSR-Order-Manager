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
              buildBreakdownSection(context),
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
  Widget buildBreakdownSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Breakdown',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),
        // 7-Piece Total
        buildBreakdownRow(
          context,
          '7-Piece Plates Total',
          sevenPieceTotal,
          Icons.restaurant,
          Colors.blue,
        ),
        // 4-Piece Total
        buildBreakdownRow(
          context,
          '4-Piece Plates Total',
          fourPieceTotal,
          Icons.lunch_dining,
          Colors.green,
        ),
        // 8-Piece Total
        buildBreakdownRow(
          context,
          '8-Piece Plates Total',
          eightPieceTotal,
          Icons.dinner_dining,
          Colors.orange,
        ),
      ],
    );
  }

  // Breakdown Row - Enhanced with improved dark mode colors
  Widget buildBreakdownRow(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    // Enhanced dark mode colors
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Improved color mappings for dark mode
    Color getEnhancedDarkColor(Color originalColor) {
      if (originalColor == Colors.blue) {
        return isDark
            ? const Color(0xFF4FC3F7)
            : Colors.blue; // Light cyan blue
      } else if (originalColor == Colors.green) {
        return isDark
            ? const Color(0xFF66BB6A)
            : Colors.green; // Material green
      } else if (originalColor == Colors.orange) {
        return isDark ? const Color(0xFFFFB74D) : Colors.orange; // Warm amber
      }
      return originalColor;
    }

    final enhancedColor = getEnhancedDarkColor(color);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        // Enhanced background colors
        color:
            isDark
                ? enhancedColor.withOpacity(
                  0.15,
                ) // Slightly more opacity for better visibility
                : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark
                  ? enhancedColor.withOpacity(0.4) // Better border visibility
                  : color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              // Enhanced icon background
              color:
                  isDark
                      ? enhancedColor.withOpacity(0.25)
                      : color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Icon(
              icon,
              size: 18.0,
              color: enhancedColor, // Use enhanced color for icon
            ),
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
              color: enhancedColor, // Use enhanced color for amount
            ),
          ),
        ],
      ),
    );
  }

  // Grand Total Section - Enhanced with improved dark mode colors
  Widget buildGrandTotalSection(BuildContext context, double totalAmount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [
                    const Color(
                      0xFFE57373,
                    ).withOpacity(0.2), // Softer red for dark mode
                    const Color(0xFFEF5350).withOpacity(0.15),
                  ]
                  : [Colors.red.shade50, Colors.red.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFFE57373).withOpacity(0.5)
                  : Colors.red.shade300,
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total to Pay',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFE57373) : Colors.red,
                ),
              ),
              Text(
                'Final Settlement Amount',
                style: TextStyle(
                  fontSize: 12.0,
                  color: isDark ? Colors.grey.shade400 : Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFFE57373) : Colors.red,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? const Color(0xFFE57373) : Colors.red)
                      .withOpacity(0.3),
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
