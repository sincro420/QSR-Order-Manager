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

          // Calculate amounts
          final double sevenPieceAmount = Calculations.calculate7PieceAmount(
            state.veg7PieceNo,
            state.chicken7PieceNo,
            state.paneer7PieceNo,
          );

          final double eightPieceAmount = Calculations.calculate8PieceAmount(
            state.veg8PieceNo,
            state.chicken8PieceNo,
            state.paneer8PieceNo,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculationWidget(
                  title: 'Total No. of 7-Piece Plates',
                  plateSize: 7,
                  vegCount: state.veg7PieceNo,
                  chickenCount: state.chicken7PieceNo,
                  paneerCount: state.paneer7PieceNo,
                ),
                const SizedBox(height: 16.0),
                CalculationWidget(
                  title: 'Total No. of 8-Piece Plates',
                  plateSize: 8,
                  vegCount: state.veg8PieceNo,
                  chickenCount: state.chicken8PieceNo,
                  paneerCount: state.paneer8PieceNo,
                ),
                const SizedBox(height: 24.0),
                TotalWidget(
                  sevenPieceTotal: sevenPieceAmount,
                  eightPieceTotal: eightPieceAmount,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
