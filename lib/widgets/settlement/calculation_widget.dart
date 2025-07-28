import 'package:flutter/material.dart';
import '../../../utils/settlement_calculations.dart';
import '../../../constants/prices.dart';

class CalculationWidget extends StatelessWidget {
  final String title;
  final int plateSize;
  final int vegCount;
  final int chickenCount;

  const CalculationWidget({
    super.key,
    required this.title,
    required this.plateSize,
    required this.vegCount,
    required this.chickenCount,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate Amount
    final double amount = calculateAmount();
    final int totalPlates = vegCount + chickenCount;

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION
            buildHeader(context),
            const SizedBox(height: 16.0),
            // Counts Display
            buildCountsSection(context),
            const SizedBox(height: 16.0),
            // Calculation Breakdown
            buildCalculationBreakdown(context),
            const SizedBox(height: 16.0),
            // Formula Display
            buildFormulaSection(context),
            const SizedBox(height: 16.0),
            // Total Amount
            buildTotalSection(context, amount, totalPlates),
          ],
        ),
      ),
    );
  }

  // Calculate Amount
  double calculateAmount() {
    switch (plateSize) {
      case 7:
        return SettlementCalculations.calculate7PieceAmount(
          vegCount,
          chickenCount,
        );
      case 4:
        return SettlementCalculations.calculate4PieceAmount(
          vegCount,
          chickenCount,
        );
      case 8:
        return SettlementCalculations.calculate8PieceAmount(
          vegCount,
          chickenCount,
        );
      default:
        return 0.0;
    }
  }

  // Header Section - Updated with BuildContext parameter
  Widget buildHeader(BuildContext context) {
    IconData plateIcon;
    Color plateColor;

    switch (plateSize) {
      case 7:
        plateIcon = Icons.restaurant;
        plateColor = Colors.blue;
        break;
      case 4:
        plateIcon = Icons.lunch_dining;
        plateColor = Colors.green;
        break;
      case 8:
        plateIcon = Icons.dinner_dining;
        plateColor = Colors.orange;
        break;
      default:
        plateIcon = Icons.fastfood;
        plateColor = Colors.grey;
    }

    // Enhanced color for dark mode
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color getEnhancedColor(Color originalColor) {
      if (originalColor == Colors.blue) {
        return isDark ? const Color(0xFF60A5FA) : Colors.blue;
      } else if (originalColor == Colors.green) {
        return isDark ? const Color(0xFF4ADE80) : Colors.green;
      } else if (originalColor == Colors.orange) {
        return isDark ? const Color(0xFFFB923C) : Colors.orange;
      }
      return originalColor;
    }

    final enhancedColor = getEnhancedColor(plateColor);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:
                isDark
                    ? enhancedColor.withOpacity(0.15)
                    : plateColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(plateIcon, color: enhancedColor, size: 24.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
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
              Text(
                '$plateSize-piece plates calculation',
                style: TextStyle(
                  fontSize: 14.0,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Counts Section - Enhanced with improved dark mode colors
  Widget buildCountsSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF2C2C2C) // Dark grey instead of cardColor
                : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF404040) // Subtle border
                  : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Plate Counts',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8.0),
          Center(
            child: buildCountItem(
              context,
              'Total',
              vegCount + chickenCount,
              Colors.blue,
              isTotal: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCountItem(context, 'Veg', vegCount, Colors.green),
              buildCountItem(context, 'Chicken', chickenCount, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCountItem(
    BuildContext context,
    String label,
    int count,
    Color color, {
    bool isTotal = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Enhanced color mapping
    Color getEnhancedColor(Color originalColor) {
      if (originalColor == Colors.blue) {
        return isDark ? const Color(0xFF60A5FA) : Colors.blue;
      } else if (originalColor == Colors.green) {
        return isDark ? const Color(0xFF4ADE80) : Colors.green;
      } else if (originalColor == Colors.red) {
        return isDark ? const Color(0xFFEF4444) : Colors.red;
      }
      return originalColor;
    }

    final enhancedColor = getEnhancedColor(color);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color:
                isDark
                    ? enhancedColor.withOpacity(0.2)
                    : color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
            border:
                isTotal ? Border.all(color: enhancedColor, width: 2.0) : null,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 16.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: enhancedColor,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // CALCULATION BREAKDOWN - Enhanced with improved dark mode colors
  Widget buildCalculationBreakdown(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF1E3A8A).withOpacity(
                  0.2,
                ) // Deep blue background
                : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF3B82F6).withOpacity(0.4) // Blue border
                  : Colors.blue.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: isDark ? const Color(0xFF60A5FA) : Colors.blue,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Calculation Breakdown',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFF60A5FA) : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Veg calculation
          if (vegCount > 0)
            buildCalculationRow(context, 'Veg', vegCount, getVegAmount()),
          // Chicken calculation
          if (chickenCount > 0)
            buildCalculationRow(
              context,
              'Chicken',
              chickenCount,
              getChickenAmount(),
            ),
          const Divider(),
          buildCalculationRow(
            context,
            'Total',
            vegCount + chickenCount,
            calculateAmount(),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget buildCalculationRow(
    BuildContext context,
    String category,
    int count,
    double amount, {
    bool isTotal = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category ($count plates)',
            style: TextStyle(
              fontSize: isTotal ? 16.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color:
                  isTotal
                      ? (isDark ? const Color(0xFF60A5FA) : Colors.blue)
                      : null,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color:
                  isTotal
                      ? (isDark ? const Color(0xFF4ADE80) : Colors.green)
                      : (isDark ? const Color(0xFF60A5FA) : Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // INDIVIDUAL AMOUNT CALCULATIONS
  double getVegAmount() {
    switch (plateSize) {
      case 7:
        return vegCount * (7 / 8) * Prices.VEG_PRICE;
      case 4:
        return vegCount * 15.0; // 30/2 = 15
      case 8:
        return vegCount * Prices.VEG_PRICE;
      default:
        return 0.0;
    }
  }

  double getChickenAmount() {
    switch (plateSize) {
      case 7:
        return chickenCount * (7 / 8) * Prices.CHICKEN_PRICE;
      case 4:
        return chickenCount * 17.5; // 35/2 = 17.5
      case 8:
        return chickenCount * Prices.CHICKEN_PRICE;
      default:
        return 0.0;
    }
  }

  // FORMULA SECTION - Enhanced with improved dark mode colors
  Widget buildFormulaSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFFF59E0B).withOpacity(
                  0.15,
                ) // Warm amber background
                : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFFF59E0B).withOpacity(0.4) // Amber border
                  : Colors.amber.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.functions,
                color: isDark ? const Color(0xFFFBBF24) : Colors.amber,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Formula Used',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFFBBF24) : Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          buildFormulaText(context),
          const SizedBox(height: 8.0),
          buildExampleCalculation(context),
        ],
      ),
    );
  }

  Widget buildFormulaText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String formula = getFormulaString();

    return Text(
      formula,
      style: TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: isDark ? Colors.grey.shade300 : Colors.black87,
      ),
    );
  }

  Widget buildExampleCalculation(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String example = getExampleString();

    return Text(
      'Example: $example',
      style: TextStyle(
        fontSize: 12.0,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
      ),
    );
  }

  String getFormulaString() {
    switch (plateSize) {
      case 7:
        return 'Total Momos ÷ 8 × Price per 8-piece\n(count × 7/8 × ₹30) + (count × 7/8 × ₹35)';
      case 4:
        return 'Fixed rate per 4-piece plate\n(count × ₹15) + (count × ₹17.5)';
      case 8:
        return 'Direct multiplication by plate price\n(count × ₹30) + (count × ₹35)';
      default:
        return 'Unknown plate size';
    }
  }

  String getExampleString() {
    switch (plateSize) {
      case 7:
        return '2 veg plates: 2 × 7/8 × 30 = ₹52.50';
      case 4:
        return '2 veg + 1 chicken: (2 × 15) + (1 × 17.5) = ₹47.50';
      case 8:
        return '2 veg + 1 chicken: (2 × 30) + (1 × 35) = ₹95';
      default:
        return 'No example available';
    }
  }

  // Total Section - Enhanced with improved dark mode colors
  Widget buildTotalSection(
    BuildContext context,
    double amount,
    int totalPlates,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [
                    const Color(0xFF4ADE80).withOpacity(0.2),
                    const Color(0xFF22C55E).withOpacity(0.15),
                  ]
                  : [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF4ADE80).withOpacity(0.5)
                  : Colors.green.shade300,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$plateSize-Piece Total',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFF4ADE80) : Colors.green,
                    ),
                  ),
                  Text(
                    '$totalPlates plates',
                    style: TextStyle(
                      fontSize: 14.0,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF4ADE80) : Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  '₹${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (totalPlates > 0) ...[
            const SizedBox(height: 12.0),
            Divider(color: isDark ? const Color(0xFF4ADE80) : Colors.green),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: isDark ? const Color(0xFF4ADE80) : Colors.green,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Average: ₹${(amount / totalPlates).toStringAsFixed(2)} per plate',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: isDark ? const Color(0xFF4ADE80) : Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
