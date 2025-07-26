import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/app_state.dart';
import '../widgets/home/category_column.dart';
import '../widgets/home/order_analysis_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Momo Counter'), centerTitle: true),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          final state = appProvider.state;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Steam section header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'STEAM',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16.0),

                // Steam categories row
                Row(
                  children: [
                    // Steam Veg Column
                    Expanded(
                      child: CategoryColumn(
                        category: 'steam_veg',
                        title: 'Steam Veg',
                        sevenPieceValue: state.steamVeg7PieceNo,
                        fourPieceValue: state.steamVeg4PieceNo,
                        eightPieceValue: state.steamVeg8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSteamVeg7Piece(),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSteamVeg7Piece(),
                        onIncrementFourPiece:
                            () => appProvider.incrementSteamVeg4Piece(),
                        onDecrementFourPiece:
                            () => appProvider.decrementSteamVeg4Piece(),
                        onIncrementEightPiece:
                            () => appProvider.incrementSteamVeg8Piece(),
                        onDecrementEightPiece:
                            () => appProvider.decrementSteamVeg8Piece(),
                      ),
                    ),

                    const SizedBox(width: 12.0),

                    // Steam Chicken Column
                    Expanded(
                      child: CategoryColumn(
                        category: 'steam_chicken',
                        title: 'Steam Chicken',
                        sevenPieceValue: state.steamChicken7PieceNo,
                        fourPieceValue: state.steamChicken4PieceNo,
                        eightPieceValue: state.steamChicken8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementSteamChicken7Piece(),
                        onDecrementSevenPiece:
                            () => appProvider.decrementSteamChicken7Piece(),
                        onIncrementFourPiece:
                            () => appProvider.incrementSteamChicken4Piece(),
                        onDecrementFourPiece:
                            () => appProvider.decrementSteamChicken4Piece(),
                        onIncrementEightPiece:
                            () => appProvider.incrementSteamChicken8Piece(),
                        onDecrementEightPiece:
                            () => appProvider.decrementSteamChicken8Piece(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24.0),

                // Fried section header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'FRIED',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16.0),

                // Fried categories row
                Row(
                  children: [
                    // Fried Veg Column
                    Expanded(
                      child: CategoryColumn(
                        category: 'fried_veg',
                        title: 'Fried Veg',
                        sevenPieceValue: state.friedVeg7PieceNo,
                        fourPieceValue: state.friedVeg4PieceNo,
                        eightPieceValue: state.friedVeg8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementFriedVeg7Piece(),
                        onDecrementSevenPiece:
                            () => appProvider.decrementFriedVeg7Piece(),
                        onIncrementFourPiece:
                            () => appProvider.incrementFriedVeg4Piece(),
                        onDecrementFourPiece:
                            () => appProvider.decrementFriedVeg4Piece(),
                        onIncrementEightPiece:
                            () => appProvider.incrementFriedVeg8Piece(),
                        onDecrementEightPiece:
                            () => appProvider.decrementFriedVeg8Piece(),
                      ),
                    ),

                    const SizedBox(width: 12.0),

                    // Fried Chicken Column
                    Expanded(
                      child: CategoryColumn(
                        category: 'fried_chicken',
                        title: 'Fried Chicken',
                        sevenPieceValue: state.friedChicken7PieceNo,
                        fourPieceValue: state.friedChicken4PieceNo,
                        eightPieceValue: state.friedChicken8PieceNo,
                        onIncrementSevenPiece:
                            () => appProvider.incrementFriedChicken7Piece(),
                        onDecrementSevenPiece:
                            () => appProvider.decrementFriedChicken7Piece(),
                        onIncrementFourPiece:
                            () => appProvider.incrementFriedChicken4Piece(),
                        onDecrementFourPiece:
                            () => appProvider.decrementFriedChicken4Piece(),
                        onIncrementEightPiece:
                            () => appProvider.incrementFriedChicken8Piece(),
                        onDecrementEightPiece:
                            () => appProvider.decrementFriedChicken8Piece(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32.0),

                OrderAnalysisWidget(state: state),

                const SizedBox(height: 20.0),

                // Order Summary Section
                buildOrderSummary(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  // Complete Order Summary Widget
  Widget buildOrderSummary(BuildContext context, AppState state) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: Theme.of(context).primaryColor,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Steam Items Section
            _buildSectionHeader('Steam Items', Icons.cloud, Colors.blue),
            const SizedBox(height: 8.0),

            if (state.steamVeg7PieceNo > 0)
              _buildSummaryRow('7-Piece Steam Veg', state.steamVeg7PieceNo),
            if (state.steamChicken7PieceNo > 0)
              _buildSummaryRow(
                '7-Piece Steam Chicken',
                state.steamChicken7PieceNo,
              ),
            if (state.steamVeg4PieceNo > 0)
              _buildSummaryRow('4-Piece Steam Veg', state.steamVeg4PieceNo),
            if (state.steamChicken4PieceNo > 0)
              _buildSummaryRow(
                '4-Piece Steam Chicken',
                state.steamChicken4PieceNo,
              ),
            if (state.steamVeg8PieceNo > 0)
              _buildSummaryRow('8-Piece Steam Veg', state.steamVeg8PieceNo),
            if (state.steamChicken8PieceNo > 0)
              _buildSummaryRow(
                '8-Piece Steam Chicken',
                state.steamChicken8PieceNo,
              ),

            // Show steam total if any steam items exist
            if (_getSteamTotal(state) > 0) ...[
              const Divider(),
              _buildSummaryRow(
                'Steam Total',
                _getSteamTotal(state),
                isBold: true,
                color: Colors.blue,
              ),
            ],

            const SizedBox(height: 16.0),

            // Fried Items Section
            _buildSectionHeader(
              'Fried Items',
              Icons.local_fire_department,
              Colors.orange,
            ),
            const SizedBox(height: 8.0),

            if (state.friedVeg7PieceNo > 0)
              _buildSummaryRow('7-Piece Fried Veg', state.friedVeg7PieceNo),
            if (state.friedChicken7PieceNo > 0)
              _buildSummaryRow(
                '7-Piece Fried Chicken',
                state.friedChicken7PieceNo,
              ),
            if (state.friedVeg4PieceNo > 0)
              _buildSummaryRow('4-Piece Fried Veg', state.friedVeg4PieceNo),
            if (state.friedChicken4PieceNo > 0)
              _buildSummaryRow(
                '4-Piece Fried Chicken',
                state.friedChicken4PieceNo,
              ),
            if (state.friedVeg8PieceNo > 0)
              _buildSummaryRow('8-Piece Fried Veg', state.friedVeg8PieceNo),
            if (state.friedChicken8PieceNo > 0)
              _buildSummaryRow(
                '8-Piece Fried Chicken',
                state.friedChicken8PieceNo,
              ),

            // Show fried total if any fried items exist
            if (_getFriedTotal(state) > 0) ...[
              const Divider(),
              _buildSummaryRow(
                'Fried Total',
                _getFriedTotal(state),
                isBold: true,
                color: Colors.orange,
              ),
            ],

            const SizedBox(height: 16.0),

            // Combined Totals by Plate Size
            _buildSectionHeader(
              'Plate Size Totals',
              Icons.analytics,
              Colors.green,
            ),
            const SizedBox(height: 8.0),

            _buildSummaryRow(
              'Total 7-Piece Plates',
              state.steamVeg7PieceNo +
                  state.steamChicken7PieceNo +
                  state.friedVeg7PieceNo +
                  state.friedChicken7PieceNo,
              isBold: true,
            ),

            _buildSummaryRow(
              'Total 4-Piece Plates',
              state.steamVeg4PieceNo +
                  state.steamChicken4PieceNo +
                  state.friedVeg4PieceNo +
                  state.friedChicken4PieceNo,
              isBold: true,
            ),

            _buildSummaryRow(
              'Total 8-Piece Plates',
              state.steamVeg8PieceNo +
                  state.steamChicken8PieceNo +
                  state.friedVeg8PieceNo +
                  state.friedChicken8PieceNo,
              isBold: true,
            ),

            const Divider(thickness: 2.0),

            // Grand Total
            _buildSummaryRow(
              'GRAND TOTAL',
              _getGrandTotal(state),
              isBold: true,
              isGrandTotal: true,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        const SizedBox(width: 6.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: color,
          ),
        ),
      ],
    );
  }

  // Helper method to build summary rows
  Widget _buildSummaryRow(
    String label,
    int count, {
    bool isBold = false,
    bool isGrandTotal = false,
    Color? color,
  }) {
    if (count == 0 && !isGrandTotal) {
      return const SizedBox.shrink(); // Don't show zero counts
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isGrandTotal ? 16.0 : 14.0,
                color: color,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color:
                  isGrandTotal
                      ? (color ?? Colors.red).withOpacity(0.1)
                      : isBold
                      ? (color ?? Colors.grey).withOpacity(0.1)
                      : null,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isGrandTotal ? 16.0 : 14.0,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for calculating totals
  int _getSteamTotal(AppState state) {
    return state.steamVeg7PieceNo +
        state.steamChicken7PieceNo +
        state.steamVeg4PieceNo +
        state.steamChicken4PieceNo +
        state.steamVeg8PieceNo +
        state.steamChicken8PieceNo;
  }

  int _getFriedTotal(AppState state) {
    return state.friedVeg7PieceNo +
        state.friedChicken7PieceNo +
        state.friedVeg4PieceNo +
        state.friedChicken4PieceNo +
        state.friedVeg8PieceNo +
        state.friedChicken8PieceNo;
  }

  int _getGrandTotal(AppState state) {
    return _getSteamTotal(state) + _getFriedTotal(state);
  }
}
