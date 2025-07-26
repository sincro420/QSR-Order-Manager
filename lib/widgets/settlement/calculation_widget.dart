import 'package:flutter/material.dart';
import '../../utils/settlement_calculations.dart';
import '../../constants/prices.dart';

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
    final double amount = _calculateAmount();
    final int totalPlates = vegCount + chickenCount;

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =============================================================================
            // HEADER SECTION
            // =============================================================================
            buildHeader(),
            const SizedBox(height: 16.0),

            // Counts Display
            buildCountsSection(),
            const SizedBox(height: 16.0),

            // Calculation Breakdown
            buildCalculationBreakdown(),
            const SizedBox(height: 16.0),

            // Formula Display
            buildFormulaSection(),
            const SizedBox(height: 16.0),

            // Total Amount
            buildTotalSection(amount, totalPlates),
          ],
        ),
      ),
    );
  }

  // Calculate Amount
  double _calculateAmount() {
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

  // Header Section
  Widget buildHeader() {
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

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: plateColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(plateIcon, color: plateColor, size: 24.0),
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
                '${plateSize}-piece plates calculation',
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Counts Section
  Widget buildCountsSection() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Plate Counts:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8.0),
          Center(
            child: buildCountItem(
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
              buildCountItem('Veg', vegCount, Colors.green),
              buildCountItem('Chicken', chickenCount, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCountItem(
    String label,
    int count,
    Color color, {
    bool isTotal = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
            border: isTotal ? Border.all(color: color, width: 2.0) : null,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 16.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // =============================================================================
  // CALCULATION BREAKDOWN
  // =============================================================================
  Widget buildCalculationBreakdown() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calculate, color: Colors.blue, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'Calculation Breakdown:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Veg calculation
          if (vegCount > 0)
            buildCalculationRow('Veg', vegCount, _getVegAmount()),

          // Chicken calculation
          if (chickenCount > 0)
            buildCalculationRow('Chicken', chickenCount, _getChickenAmount()),

          const Divider(),
          buildCalculationRow(
            'Total',
            vegCount + chickenCount,
            _calculateAmount(),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget buildCalculationRow(
    String category,
    int count,
    double amount, {
    bool isTotal = false,
  }) {
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
              color: isTotal ? Colors.blue : null,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Colors.green : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // INDIVIDUAL AMOUNT CALCULATIONS
  // =============================================================================
  double _getVegAmount() {
    switch (plateSize) {
      case 7:
        return (vegCount * 7 / 8) * Prices.VEG_PRICE;
      case 4:
        return vegCount * 15.0; // ₹30/2 = ₹15
      case 8:
        return vegCount * Prices.VEG_PRICE;
      default:
        return 0.0;
    }
  }

  double _getChickenAmount() {
    switch (plateSize) {
      case 7:
        return (chickenCount * 7 / 8) * Prices.CHICKEN_PRICE;
      case 4:
        return chickenCount * 17.5; // ₹35/2 = ₹17.5
      case 8:
        return chickenCount * Prices.CHICKEN_PRICE;
      default:
        return 0.0;
    }
  }

  // =============================================================================
  // FORMULA SECTION
  // =============================================================================
  Widget buildFormulaSection() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.functions, color: Colors.amber, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'Formula Used:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          buildFormulaText(),
          const SizedBox(height: 8.0),
          buildExampleCalculation(),
        ],
      ),
    );
  }

  Widget buildFormulaText() {
    String formula = _getFormulaString();

    return Text(
      formula,
      style: const TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: Colors.black87,
      ),
    );
  }

  Widget buildExampleCalculation() {
    String example = _getExampleString();

    return Text(
      'Example: $example',
      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
    );
  }

  String _getFormulaString() {
    switch (plateSize) {
      case 7:
        return 'Total Momos ÷ 8 × Price per 8-piece\nVeg: (count × 7 ÷ 8) × ₹30\nChicken: (count × 7 ÷ 8) × ₹35';
      case 4:
        return 'Fixed rate per 4-piece plate\nVeg: count × ₹15\nChicken: count × ₹17.5';
      case 8:
        return 'Direct multiplication by plate price\nVeg: count × ₹30\nChicken: count × ₹35';
      default:
        return 'Unknown plate size';
    }
  }

  String _getExampleString() {
    switch (plateSize) {
      case 7:
        return '2 veg plates = (2 × 7 ÷ 8) × ₹30 = ₹52.50';
      case 4:
        return '2 veg + 1 chicken = (2 × ₹15) + (1 × ₹17.5) = ₹47.50';
      case 8:
        return '2 veg + 1 chicken = (2 × ₹30) + (1 × ₹35) = ₹95';
      default:
        return 'No example available';
    }
  }

  Widget buildTotalSection(double amount, int totalPlates) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
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
                    '${plateSize}-Piece Total',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '$totalPlates plates',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade600,
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
                  color: Colors.green,
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
            const Divider(color: Colors.green),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, size: 16.0, color: Colors.green),
                const SizedBox(width: 4.0),
                Text(
                  'Average: ₹${(amount / totalPlates).toStringAsFixed(2)} per plate',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
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
