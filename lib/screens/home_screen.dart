import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../providers/app_provider.dart';
import '../widgets/home/category_column.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Order Management')),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          final state = appProvider.state;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Category Columns
                Row(
                  children: [
                    // VEG COLUMN
                    Expanded(
                      child: CategoryColumn(
                        category: 'veg',
                        title: 'Veg',
                        sevenPieceValue: state.veg7PieceNo,
                        fourPieceValue: state.veg4PieceNo,
                        eightPieceValue: state.veg8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSevenPiece('veg'),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSevenPiece('veg'),
                        onIncrementFourPiece:
                            () => appProvider.incrementFourPiece('veg'), // NEW
                        onDecrementFourPiece:
                            () => appProvider.decrementFourPiece('veg'), // NEW
                        onIncrementEightPiece:
                            () => appProvider.incrementEightPiece('veg'),
                        onDecrementEightPiece:
                            () => appProvider.decrementEightPiece('veg'),
                      ),
                    ),
                    const SizedBox(width: 8.0),

                    // CHICKEN COLUMN
                    Expanded(
                      child: CategoryColumn(
                        category: 'chicken',
                        title: 'Chicken',
                        sevenPieceValue: state.chicken7PieceNo,
                        fourPieceValue: state.chicken4PieceNo,
                        eightPieceValue: state.chicken8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSevenPiece('chicken'),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSevenPiece('chicken'),
                        onIncrementFourPiece:
                            () => appProvider.incrementFourPiece(
                              'chicken',
                            ), // NEW
                        onDecrementFourPiece:
                            () => appProvider.decrementFourPiece(
                              'chicken',
                            ), // NEW
                        onIncrementEightPiece:
                            () => appProvider.incrementEightPiece('chicken'),
                        onDecrementEightPiece:
                            () => appProvider.decrementEightPiece('chicken'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24.0),

                // Order Summary
                buildSummary(state),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build Summary Method
  Widget buildSummary(AppState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // 7-Piece Plates Section
            buildSummaryRow('7-Piece Veg Plates', state.veg7PieceNo),
            buildSummaryRow('7-Piece Chicken Plates', state.chicken7PieceNo),

            const Divider(),

            // 4-Piece Plates Section
            buildSummaryRow('4-Piece Veg Plates', state.veg4PieceNo),
            buildSummaryRow('4-Piece Chicken Plates', state.chicken4PieceNo),

            const Divider(),

            // 8-Piece Plates Section
            buildSummaryRow('8-Piece Veg Plates', state.veg8PieceNo),
            buildSummaryRow('8-Piece Chicken Plates', state.chicken8PieceNo),

            const Divider(),

            // Totals Section
            buildSummaryRow(
              'Total 7-Piece Plates',
              state.veg7PieceNo + state.chicken7PieceNo,
              isBold: true,
            ),
            buildSummaryRow(
              'Total 4-Piece Plates',
              state.veg4PieceNo + state.chicken4PieceNo,
              isBold: true,
            ),
            buildSummaryRow(
              'Total 8-Piece Plates',
              state.veg8PieceNo + state.chicken8PieceNo,
              isBold: true,
            ),

            const Divider(thickness: 2.0),

            // Grand Totals
            buildSummaryRow(
              'Total All Plates',
              (state.veg7PieceNo + state.chicken7PieceNo) + // 7-piece total
                  (state.veg4PieceNo + state.chicken4PieceNo) + // 4-piece total
                  (state.veg8PieceNo + state.chicken8PieceNo), // 8-piece total
              isBold: true,
              isGrandTotal: true,
            ),

            // Category totals
            const SizedBox(height: 8.0),
            buildSummaryRow(
              'Total Veg Items',
              state.veg7PieceNo + state.veg4PieceNo + state.veg8PieceNo,
              isBold: true,
            ),
            buildSummaryRow(
              'Total Chicken Items',
              state.chicken7PieceNo +
                  state.chicken4PieceNo +
                  state.chicken8PieceNo,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  // Build Summary Row Method
  Widget buildSummaryRow(
    String label,
    int value, {
    bool isBold = false,
    bool isGrandTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isGrandTotal ? 16.0 : 14.0,
              color: isGrandTotal ? Colors.blue : null,
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
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    )
                    : null,
            child: Text(
              value.toString(),
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isGrandTotal ? 18.0 : 14.0,
                color: isGrandTotal ? Colors.blue : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
