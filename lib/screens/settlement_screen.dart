import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/settlement/total_widget.dart';
import '../widgets/settlement/calculation_widget.dart';
import '../utils/settlement_calculations.dart';

class SettlementScreen extends StatelessWidget {
  const SettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settlement'), centerTitle: true),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          final state = appProvider.state;

          // CALCULATION LOGIC UPDATED - Aggregate steam + fried counts by plate size and category
          // This maintains the original 6-category structure that the existing UI and calculations expect

          // 7-Piece Totals (Steam + Fried combined)
          final int total7PieceVeg =
              state.steamVeg7PieceNo + state.friedVeg7PieceNo;
          final int total7PieceChicken =
              state.steamChicken7PieceNo + state.friedChicken7PieceNo;

          // 4-Piece Totals (Steam + Fried combined)
          final int total4PieceVeg =
              state.steamVeg4PieceNo + state.friedVeg4PieceNo;
          final int total4PieceChicken =
              state.steamChicken4PieceNo + state.friedChicken4PieceNo;

          // 8-Piece Totals (Steam + Fried combined)
          final int total8PieceVeg =
              state.steamVeg8PieceNo + state.friedVeg8PieceNo;
          final int total8PieceChicken =
              state.steamChicken8PieceNo + state.friedChicken8PieceNo;

          // Calculate amounts using existing calculation methods (no changes needed to calculations.dart)
          final double sevenPieceAmount =
              SettlementCalculations.calculate7PieceAmount(
                total7PieceVeg,
                total7PieceChicken,
              );
          final double fourPieceAmount =
              SettlementCalculations.calculate4PieceAmount(
                total4PieceVeg,
                total4PieceChicken,
              );
          final double eightPieceAmount =
              SettlementCalculations.calculate8PieceAmount(
                total8PieceVeg,
                total8PieceChicken,
              );

          // UI REMAINS EXACTLY THE SAME - No changes below this line
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Total summary widget - uses aggregated amounts
                TotalWidget(
                  sevenPieceTotal: sevenPieceAmount,
                  fourPieceTotal: fourPieceAmount,
                  eightPieceTotal: eightPieceAmount,
                ),
                const SizedBox(height: 20.0),

                // 7-Piece calculation breakdown - uses aggregated counts
                CalculationWidget(
                  title: 'Total No. of 7-Piece Plates',
                  plateSize: 7,
                  vegCount: total7PieceVeg,
                  chickenCount: total7PieceChicken,
                ),
                const SizedBox(height: 16.0),

                // 4-Piece calculation breakdown - uses aggregated counts
                CalculationWidget(
                  title: 'Total No. of 4-Piece Plates',
                  plateSize: 4,
                  vegCount: total4PieceVeg,
                  chickenCount: total4PieceChicken,
                ),
                const SizedBox(height: 16.0),

                // 8-Piece calculation breakdown - uses aggregated counts
                CalculationWidget(
                  title: 'Total No. of 8-Piece Plates',
                  plateSize: 8,
                  vegCount: total8PieceVeg,
                  chickenCount: total8PieceChicken,
                ),

                // const SizedBox(height: 20.0),

                // buildFormulaReference(),
              ],
            ),
          );
        },
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
}
