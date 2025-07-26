import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../utils/calculations.dart';
import '../widgets/settlement/calculation_widget.dart';
import '../widgets/settlement/total_widget.dart';

class SettlementScreen extends StatelessWidget {
  const SettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settlement')),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          final state = appProvider.state;
          final double sevenPieceAmount = Calculations.calculate7PieceAmount(
            state.veg7PieceNo,
            state.chicken7PieceNo,
          );

          final double fourPieceAmount = Calculations.calculate4PieceAmount(
            state.veg4PieceNo,
            state.chicken4PieceNo,
          );

          final double eightPieceAmount = Calculations.calculate8PieceAmount(
            state.veg8PieceNo,
            state.chicken8PieceNo,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TotalWidget(
                  sevenPieceTotal: sevenPieceAmount,
                  fourPieceTotal: fourPieceAmount,
                  eightPieceTotal: eightPieceAmount,
                ),

                const SizedBox(height: 20.0),

                CalculationWidget(
                  title: 'Total No. of 7-Piece Plates',
                  plateSize: 7,
                  vegCount: state.veg7PieceNo,
                  chickenCount: state.chicken7PieceNo,
                ),
                const SizedBox(height: 16.0),

                CalculationWidget(
                  title: 'Total No. of 4-Piece Plates',
                  plateSize: 4,
                  vegCount: state.veg4PieceNo,
                  chickenCount: state.chicken4PieceNo,
                ),
                const SizedBox(height: 16.0),

                CalculationWidget(
                  title: 'Total No. of 8-Piece Plates',
                  plateSize: 8,
                  vegCount: state.veg8PieceNo,
                  chickenCount: state.chicken8PieceNo,
                ),
                const SizedBox(height: 24.0),

                buildDetailedBreakdown(
                  state,
                  sevenPieceAmount,
                  fourPieceAmount,
                  eightPieceAmount,
                ),

                const SizedBox(height: 20.0),

                
                buildFormulaReference(),

                const SizedBox(height: 20.0),

                
                buildCategoryAnalysis(state),
              ],
            ),
          );
        },
      ),
    );
  }

  
  Widget buildSettlementHeader(double grandTotal) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          const Icon(Icons.receipt_long, size: 40.0, color: Colors.blue),
          const SizedBox(height: 12.0),
          const Text(
            'Settlement Summary',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Total Amount: ₹${grandTotal.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget buildDetailedBreakdown(
    dynamic state,
    double sevenPieceAmount,
    double fourPieceAmount,
    double eightPieceAmount,
  ) {
    final double grandTotal =
        sevenPieceAmount + fourPieceAmount + eightPieceAmount;

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics, color: Colors.orange),
                SizedBox(width: 8.0),
                Text(
                  'Detailed Breakdown',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // =============================================================================
            // PLATE COUNT BREAKDOWN
            // =============================================================================
            buildBreakdownSection('Plate Count Summary', [
              buildDetailRow(
                '7-Piece Veg Plates',
                state.veg7PieceNo.toString(),
              ),
              buildDetailRow(
                '7-Piece Chicken Plates',
                state.chicken7PieceNo.toString(),
              ),
              buildDetailRow(
                '7-Piece Total',
                (state.veg7PieceNo + state.chicken7PieceNo).toString(),
                isSubTotal: true,
              ),

              const Divider(),

              buildDetailRow(
                '4-Piece Veg Plates',
                state.veg4PieceNo.toString(),
              ),
              buildDetailRow(
                '4-Piece Chicken Plates',
                state.chicken4PieceNo.toString(),
              ),
              buildDetailRow(
                '4-Piece Total',
                (state.veg4PieceNo + state.chicken4PieceNo).toString(),
                isSubTotal: true,
              ),

              const Divider(),

              buildDetailRow(
                '8-Piece Veg Plates',
                state.veg8PieceNo.toString(),
              ),
              buildDetailRow(
                '8-Piece Chicken Plates',
                state.chicken8PieceNo.toString(),
              ),
              buildDetailRow(
                '8-Piece Total',
                (state.veg8PieceNo + state.chicken8PieceNo).toString(),
                isSubTotal: true,
              ),
            ]),

            const SizedBox(height: 20.0),

            // =============================================================================
            // AMOUNT BREAKDOWN
            // =============================================================================
            buildBreakdownSection('Amount Breakdown', [
              buildDetailRow(
                '7-Piece Plates Amount',
                '₹${sevenPieceAmount.toStringAsFixed(2)}',
              ),
              buildDetailRow(
                '4-Piece Plates Amount',
                '₹${fourPieceAmount.toStringAsFixed(2)}',
              ),
              buildDetailRow(
                '8-Piece Plates Amount',
                '₹${eightPieceAmount.toStringAsFixed(2)}',
              ),

              const Divider(thickness: 2.0),

              buildDetailRow(
                'Grand Total',
                '₹${grandTotal.toStringAsFixed(2)}',
                isGrandTotal: true,
              ),
            ]),

            const SizedBox(height: 20.0),

            // =============================================================================
            // PERCENTAGE BREAKDOWN
            // =============================================================================
            buildPercentageBreakdown(
              sevenPieceAmount,
              fourPieceAmount,
              eightPieceAmount,
              grandTotal,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget buildPercentageBreakdown(
    double sevenAmount,
    double fourAmount,
    double eightAmount,
    double total,
  ) {
    if (total == 0) return const SizedBox.shrink();

    final double sevenPercent = (sevenAmount / total) * 100;
    final double fourPercent = (fourAmount / total) * 100;
    final double eightPercent = (eightAmount / total) * 100;

    return buildBreakdownSection('Revenue Distribution', [
      buildPercentageRow('7-Piece Plates', sevenPercent, Colors.blue),
      buildPercentageRow('4-Piece Plates', fourPercent, Colors.green),
      buildPercentageRow('8-Piece Plates', eightPercent, Colors.orange),
    ]);
  }

  Widget buildPercentageRow(String label, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(fontSize: 14.0)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 20.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 50.0,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget buildFormulaReference() {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.calculate, color: Colors.purple),
                SizedBox(width: 8.0),
                Text(
                  'Calculation Formulas',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            buildFormulaItem(
              '7-Piece Plates:',
              'Total Momos ÷ 8 × Price per 8-piece',
              'Example: 3 plates = (3 × 7 ÷ 8) × ₹30 = ₹78.75',
            ),

            const Divider(),

            buildFormulaItem(
              '4-Piece Plates:',
              'Veg: ₹15 per plate, Chicken: ₹17.5 per plate',
              'Example: 2 veg + 1 chicken = (2 × ₹15) + (1 × ₹17.5) = ₹47.5',
            ),

            const Divider(),

            buildFormulaItem(
              '8-Piece Plates:',
              'Veg: ₹30 per plate, Chicken: ₹35 per plate',
              'Example: 1 veg + 1 chicken = ₹30 + ₹35 = ₹65',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormulaItem(String title, String formula, String example) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            formula,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            example,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  
  Widget buildCategoryAnalysis(dynamic state) {
    final int totalVeg =
        state.veg7PieceNo + state.veg4PieceNo + state.veg8PieceNo;
    final int totalChicken =
        state.chicken7PieceNo + state.chicken4PieceNo + state.chicken8PieceNo;
    final int totalPlates = totalVeg + totalChicken;

    final double vegAmount = Calculations.calculateVegTotal(
      state.veg7PieceNo,
      state.veg4PieceNo,
      state.veg8PieceNo,
    );
    final double chickenAmount = Calculations.calculateChickenTotal(
      state.chicken7PieceNo,
      state.chicken4PieceNo,
      state.chicken8PieceNo,
    );

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.pie_chart, color: Colors.green),
                SizedBox(width: 8.0),
                Text(
                  'Category Analysis',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            if (totalPlates > 0) ...[
              buildCategoryRow('Veg Items', totalVeg, vegAmount, totalPlates),
              const Divider(),
              buildCategoryRow(
                'Chicken Items',
                totalChicken,
                chickenAmount,
                totalPlates,
              ),
            ] else
              const Text(
                'No items in the order yet.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryRow(
    String category,
    int count,
    double amount,
    int totalPlates,
  ) {
    final double percentage = totalPlates > 0 ? (count / totalPlates) * 100 : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '₹${amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            '$count plates (${percentage.toStringAsFixed(1)}% of total)',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  

  Widget buildBreakdownSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12.0),
        ...children,
      ],
    );
  }

  Widget buildDetailRow(
    String label,
    String value, {
    bool isSubTotal = false,
    bool isGrandTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight:
                  isGrandTotal
                      ? FontWeight.bold
                      : (isSubTotal ? FontWeight.w600 : FontWeight.normal),
              fontSize: isGrandTotal ? 18.0 : (isSubTotal ? 15.0 : 14.0),
              color:
                  isGrandTotal
                      ? Colors.green
                      : (isSubTotal ? Colors.blue : null),
            ),
          ),
          Container(
            padding:
                isGrandTotal
                    ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0)
                    : null,
            decoration:
                isGrandTotal
                    ? BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    )
                    : null,
            child: Text(
              value,
              style: TextStyle(
                fontWeight:
                    isGrandTotal
                        ? FontWeight.bold
                        : (isSubTotal ? FontWeight.w600 : FontWeight.w500),
                fontSize: isGrandTotal ? 20.0 : (isSubTotal ? 15.0 : 14.0),
                color:
                    isGrandTotal
                        ? Colors.green
                        : (isSubTotal ? Colors.blue : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
