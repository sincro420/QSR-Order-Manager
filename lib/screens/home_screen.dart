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
                Row(
                  children: [
                    Expanded(
                      child: CategoryColumn(
                        category: 'steam',
                        title: 'Veg',
                        sevenPieceValue: state.veg7PieceNo,
                        eightPieceValue: state.veg8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSevenPiece('veg'),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSevenPiece('veg'),
                        onIncrementEightPiece:
                            () => appProvider.incrementEightPiece('veg'),
                        onDecrementEightPiece:
                            () => appProvider.decrementEightPiece('veg'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: CategoryColumn(
                        category: 'steam',
                        title: 'Chicken',
                        sevenPieceValue: state.chicken7PieceNo,
                        eightPieceValue: state.chicken8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSevenPiece('chicken'),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSevenPiece('chicken'),
                        onIncrementEightPiece:
                            () => appProvider.incrementEightPiece('chicken'),
                        onDecrementEightPiece:
                            () => appProvider.decrementEightPiece('chicken'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: CategoryColumn(
                        category: 'fry',
                        title: 'Veg',
                        sevenPieceValue: state.paneer7PieceNo,
                        eightPieceValue: state.paneer8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSevenPiece('paneer'),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSevenPiece('paneer'),
                        onIncrementEightPiece:
                            () => appProvider.incrementEightPiece('paneer'),
                        onDecrementEightPiece:
                            () => appProvider.decrementEightPiece('paneer'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                _buildSummary(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummary(AppState state) {
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
            _buildSummaryRow('7-Piece Veg Plates', state.veg7PieceNo),
            _buildSummaryRow('7-Piece Chicken Plates', state.chicken7PieceNo),
            _buildSummaryRow('7-Piece Paneer Plates', state.paneer7PieceNo),
            const Divider(),
            _buildSummaryRow('8-Piece Veg Plates', state.veg8PieceNo),
            _buildSummaryRow('8-Piece Chicken Plates', state.chicken8PieceNo),
            _buildSummaryRow('8-Piece Paneer Plates', state.paneer8PieceNo),
            const Divider(),
            _buildSummaryRow(
              'Total 7-Piece Plates',
              state.veg7PieceNo + state.chicken7PieceNo + state.paneer7PieceNo,
              isBold: true,
            ),
            _buildSummaryRow(
              'Total 8-Piece Plates',
              state.veg8PieceNo + state.chicken8PieceNo + state.paneer8PieceNo,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
