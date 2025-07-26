import 'package:flutter/material.dart';
import '../../models/app_state.dart';
import '../../utils/order_calculations.dart';
import '../../constants/sale_prices.dart';

class OrderSummary extends StatelessWidget {
  final AppState state;

  const OrderSummary({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            buildSectionHeader(
              'Order Summary',
              Icons.receipt_long,
              Colors.blue,
            ),
            const SizedBox(height: 16.0),

            // Steam Category Summary
            if (_hasItemsInCategory(true)) ...[
              buildSectionHeader(
                'Steam Category',
                Icons.local_fire_department,
                Colors.blue,
              ),
              const SizedBox(height: 8.0),
              _buildSteamCategorySummary(),
              const SizedBox(height: 12.0),
            ],

            // Fried Category Summary
            if (_hasItemsInCategory(false)) ...[
              buildSectionHeader(
                'Fried Category',
                Icons.restaurant,
                Colors.orange,
              ),
              const SizedBox(height: 8.0),
              _buildFriedCategorySummary(),
              const SizedBox(height: 12.0),
            ],

            // Combined Totals by Plate Size
            buildSectionHeader(
              'Plate Size Totals',
              Icons.analytics,
              Colors.green,
            ),
            const SizedBox(height: 8.0),
            _buildPlateSizeTotals(),
            const SizedBox(height: 12.0),

            const Divider(thickness: 2.0, height: 24.0),

            // Grand Total
            _buildGrandTotal(),
          ],
        ),
      ),
    );
  }

  // Helper method to check if category has items
  bool _hasItemsInCategory(bool isSteam) {
    if (isSteam) {
      return (state.steamVeg7PieceNo +
              state.steamChicken7PieceNo +
              state.steamVeg4PieceNo +
              state.steamChicken4PieceNo +
              state.steamVeg8PieceNo +
              state.steamChicken8PieceNo) >
          0;
    } else {
      return (state.friedVeg7PieceNo +
              state.friedChicken7PieceNo +
              state.friedVeg4PieceNo +
              state.friedChicken4PieceNo +
              state.friedVeg8PieceNo +
              state.friedChicken8PieceNo) >
          0;
    }
  }

  // Steam category breakdown
  Widget _buildSteamCategorySummary() {
    return Column(
      children: [
        buildSummaryRow('Steam Veg 7-Piece', state.steamVeg7PieceNo),
        buildSummaryRow('Steam Veg 4-Piece', state.steamVeg4PieceNo),
        buildSummaryRow('Steam Veg 8-Piece', state.steamVeg8PieceNo),
        buildSummaryRow('Steam Chicken 7-Piece', state.steamChicken7PieceNo),
        buildSummaryRow('Steam Chicken 4-Piece', state.steamChicken4PieceNo),
        buildSummaryRow('Steam Chicken 8-Piece', state.steamChicken8PieceNo),
        const Divider(),
        buildSummaryRowDouble(
          'Steam Total Plates',
          getSteamTotalWithHalfCount(),
          isBold: true,
          color: Colors.blue,
        ),
      ],
    );
  }

  // Fried category breakdown
  Widget _buildFriedCategorySummary() {
    return Column(
      children: [
        buildSummaryRow('Fried Veg 7-Piece', state.friedVeg7PieceNo),
        buildSummaryRow('Fried Veg 4-Piece', state.friedVeg4PieceNo),
        buildSummaryRow('Fried Veg 8-Piece', state.friedVeg8PieceNo),
        buildSummaryRow('Fried Chicken 7-Piece', state.friedChicken7PieceNo),
        buildSummaryRow('Fried Chicken 4-Piece', state.friedChicken4PieceNo),
        buildSummaryRow('Fried Chicken 8-Piece', state.friedChicken8PieceNo),
        const Divider(),
        buildSummaryRowDouble(
          'Fried Total Plates',
          getFriedTotalWithHalfCount(),
          isBold: true,
          color: Colors.orange,
        ),
      ],
    );
  }

  // Plate size totals
  Widget _buildPlateSizeTotals() {
    return Column(
      children: [
        buildSummaryRowDouble(
          'Total 7-Piece Plates',
          (state.steamVeg7PieceNo +
                  state.steamChicken7PieceNo +
                  state.friedVeg7PieceNo +
                  state.friedChicken7PieceNo)
              .toDouble(),
          isBold: true,
        ),
        buildSummaryRowDouble(
          'Total 4-Piece Plates (as 0.5)',
          (state.steamVeg4PieceNo +
                  state.steamChicken4PieceNo +
                  state.friedVeg4PieceNo +
                  state.friedChicken4PieceNo) *
              0.5,
          isBold: true,
          color: Colors.orange,
        ),
        buildSummaryRowDouble(
          'Total 8-Piece Plates',
          (state.steamVeg8PieceNo +
                  state.steamChicken8PieceNo +
                  state.friedVeg8PieceNo +
                  state.friedChicken8PieceNo)
              .toDouble(),
          isBold: true,
        ),
      ],
    );
  }

  // Grand total section
  Widget _buildGrandTotal() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          buildSummaryRowDouble(
            'GRAND TOTAL PLATES',
            getGrandTotalWithHalfCount(),
            isBold: true,
            isGrandTotal: true,
            color: Colors.green.shade400,
          ),
        ],
      ),
    );
  }

  // Helper methods for calculating totals with 4-piece as 0.5
  double getSteamTotalWithHalfCount() {
    int fullPlates =
        state.steamVeg7PieceNo +
        state.steamChicken7PieceNo +
        state.steamVeg8PieceNo +
        state.steamChicken8PieceNo;
    int halfPlates = state.steamVeg4PieceNo + state.steamChicken4PieceNo;
    return fullPlates + (halfPlates * 0.5);
  }

  double getFriedTotalWithHalfCount() {
    int fullPlates =
        state.friedVeg7PieceNo +
        state.friedChicken7PieceNo +
        state.friedVeg8PieceNo +
        state.friedChicken8PieceNo;
    int halfPlates = state.friedVeg4PieceNo + state.friedChicken4PieceNo;
    return fullPlates + (halfPlates * 0.5);
  }

  double getGrandTotalWithHalfCount() {
    return getSteamTotalWithHalfCount() + getFriedTotalWithHalfCount();
  }

  // UI Building Helper Methods
  Widget buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget buildSummaryRow(
    String label,
    int count, {
    bool isBold = false,
    Color? color,
  }) {
    if (count == 0) return const SizedBox.shrink();

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
                fontSize: 14.0,
                color: color,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: isBold ? (color ?? Colors.grey).withOpacity(0.1) : null,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 14.0,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryRowDouble(
    String label,
    double count, {
    bool isBold = false,
    bool isGrandTotal = false,
    Color? color,
  }) {
    if (count == 0 && !isGrandTotal) return const SizedBox.shrink();

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
                      ? (color ?? Colors.green).withOpacity(0.1)
                      : isBold
                      ? (color ?? Colors.grey).withOpacity(0.1)
                      : null,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              OrderCalculations.formatPlateCount(count),
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
}
