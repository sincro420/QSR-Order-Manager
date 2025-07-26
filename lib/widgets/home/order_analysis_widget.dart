import 'package:flutter/material.dart';
import '../../utils/order_calculations.dart';
import '../../models/app_state.dart';
import '../../constants/sale_prices.dart';

class OrderAnalysisWidget extends StatelessWidget {
  final AppState state;

  const OrderAnalysisWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // FIXED: Added parentheses
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).primaryColor,
                  size: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Order Analysis',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Quick Summary Cards
            _buildQuickSummaryCards(),

            const SizedBox(height: 16.0),
            const Divider(thickness: 1.0),

            // Detailed Breakdown
            _buildDetailedBreakdown(),

            const SizedBox(height: 12.0),
            const Divider(thickness: 1.0),

            // Plate Size Analysis
            _buildPlateSizeAnalysis(),

            const SizedBox(height: 12.0),
            const Divider(thickness: 1.0),

            // Grand Totals
            _buildGrandTotals(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSummaryCards() {
    double totalPlatesWithHalf =
        OrderCalculations.getTotalAllPlatesWithHalfCount(
          state.steamVeg7PieceNo,
          state.steamChicken7PieceNo,
          state.friedVeg7PieceNo,
          state.friedChicken7PieceNo,
          state.steamVeg4PieceNo,
          state.steamChicken4PieceNo,
          state.friedVeg4PieceNo,
          state.friedChicken4PieceNo,
          state.steamVeg8PieceNo,
          state.steamChicken8PieceNo,
          state.friedVeg8PieceNo,
          state.friedChicken8PieceNo,
        );

    double totalAmount = OrderCalculations.calculateTotalAmount(
      state.steamVeg7PieceNo,
      state.steamChicken7PieceNo,
      state.friedVeg7PieceNo,
      state.friedChicken7PieceNo,
      state.steamVeg4PieceNo,
      state.steamChicken4PieceNo,
      state.friedVeg4PieceNo,
      state.friedChicken4PieceNo,
      state.steamVeg8PieceNo,
      state.steamChicken8PieceNo,
      state.friedVeg8PieceNo,
      state.friedChicken8PieceNo,
    );

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Plates',
            OrderCalculations.formatPlateCount(totalPlatesWithHalf),
            Icons.restaurant_menu,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _buildSummaryCard(
            'Total Amount',
            SalePrices.formatPrice(totalAmount),
            Icons.currency_rupee,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.0),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Breakdown',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12.0),

        // Steam Category
        _buildCategoryBreakdown('Steam', true),
        const SizedBox(height: 12.0),

        // Fried Category
        _buildCategoryBreakdown('Fried', false),
      ],
    );
  }

  Widget _buildCategoryBreakdown(String category, bool isSteam) {
    double categoryTotal;
    double categoryPlatesWithHalf;
    Color categoryColor;

    if (isSteam) {
      categoryTotal = OrderCalculations.calculateSteamTotal(
        state.steamVeg7PieceNo,
        state.steamVeg4PieceNo,
        state.steamVeg8PieceNo,
        state.steamChicken7PieceNo,
        state.steamChicken4PieceNo,
        state.steamChicken8PieceNo,
      );
      categoryPlatesWithHalf =
          OrderCalculations.getTotalSteamPlatesWithHalfCount(
            state.steamVeg7PieceNo,
            state.steamVeg4PieceNo,
            state.steamVeg8PieceNo,
            state.steamChicken7PieceNo,
            state.steamChicken4PieceNo,
            state.steamChicken8PieceNo,
          );
      categoryColor = Colors.blue;
    } else {
      categoryTotal = OrderCalculations.calculateFriedTotal(
        state.friedVeg7PieceNo,
        state.friedVeg4PieceNo,
        state.friedVeg8PieceNo,
        state.friedChicken7PieceNo,
        state.friedChicken4PieceNo,
        state.friedChicken8PieceNo,
      );
      categoryPlatesWithHalf =
          OrderCalculations.getTotalFriedPlatesWithHalfCount(
            state.friedVeg7PieceNo,
            state.friedVeg4PieceNo,
            state.friedVeg8PieceNo,
            state.friedChicken7PieceNo,
            state.friedChicken4PieceNo,
            state.friedChicken8PieceNo,
          );
      categoryColor = Colors.orange;
    }

    if (categoryTotal == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(
          left: BorderSide(color: categoryColor, width: 4.0),
        ), // FIXED: Proper Border syntax
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$category Category',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
              Text(
                SalePrices.formatPrice(categoryTotal),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'Plates: ${OrderCalculations.formatPlateCount(categoryPlatesWithHalf)}',
            style: TextStyle(
              fontSize: 12.0,
              color: categoryColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlateSizeAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plate Size Analysis',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12.0),

        // 7-Piece Analysis
        _buildPlateSizeRow(7),
        const SizedBox(height: 8.0),

        // 4-Piece Analysis
        _buildPlateSizeRow(4),
        const SizedBox(height: 8.0),

        // 8-Piece Analysis
        _buildPlateSizeRow(8),
      ],
    );
  }

  Widget _buildPlateSizeRow(int plateSize) {
    int steamCount, friedCount;
    double amount;
    double plateCount;

    switch (plateSize) {
      case 7:
        steamCount = state.steamVeg7PieceNo + state.steamChicken7PieceNo;
        friedCount = state.friedVeg7PieceNo + state.friedChicken7PieceNo;
        amount = OrderCalculations.calculate7PieceAmount(
          state.steamVeg7PieceNo,
          state.steamChicken7PieceNo,
          state.friedVeg7PieceNo,
          state.friedChicken7PieceNo,
        );
        plateCount = (steamCount + friedCount).toDouble();
        break;
      case 4:
        steamCount = state.steamVeg4PieceNo + state.steamChicken4PieceNo;
        friedCount = state.friedVeg4PieceNo + state.friedChicken4PieceNo;
        amount = OrderCalculations.calculate4PieceAmount(
          state.steamVeg4PieceNo,
          state.steamChicken4PieceNo,
          state.friedVeg4PieceNo,
          state.friedChicken4PieceNo,
        );
        plateCount = (steamCount + friedCount) * 0.5; // 4-piece as 0.5
        break;
      case 8:
      default: // FIXED: Added default case
        steamCount = state.steamVeg8PieceNo + state.steamChicken8PieceNo;
        friedCount = state.friedVeg8PieceNo + state.friedChicken8PieceNo;
        amount = OrderCalculations.calculate8PieceAmount(
          state.steamVeg8PieceNo,
          state.steamChicken8PieceNo,
          state.friedVeg8PieceNo,
          state.friedChicken8PieceNo,
        );
        plateCount = (steamCount + friedCount).toDouble();
        break;
    }

    int totalCount = steamCount + friedCount;
    if (totalCount == 0) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$plateSize-Piece',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Count: $totalCount',
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Plates: ${OrderCalculations.formatPlateCount(plateCount)}',
            style: TextStyle(
              fontSize: 12.0,
              color: plateSize == 4 ? Colors.orange : Colors.grey[600],
              fontWeight: plateSize == 4 ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            SalePrices.formatPrice(amount),
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildGrandTotals() {
    double totalPlatesWithHalf =
        OrderCalculations.getTotalAllPlatesWithHalfCount(
          state.steamVeg7PieceNo,
          state.steamChicken7PieceNo,
          state.friedVeg7PieceNo,
          state.friedChicken7PieceNo,
          state.steamVeg4PieceNo,
          state.steamChicken4PieceNo,
          state.friedVeg4PieceNo,
          state.friedChicken4PieceNo,
          state.steamVeg8PieceNo,
          state.steamChicken8PieceNo,
          state.friedVeg8PieceNo,
          state.friedChicken8PieceNo,
        );

    double totalAmount = OrderCalculations.calculateTotalAmount(
      state.steamVeg7PieceNo,
      state.steamChicken7PieceNo,
      state.friedVeg7PieceNo,
      state.friedChicken7PieceNo,
      state.steamVeg4PieceNo,
      state.steamChicken4PieceNo,
      state.friedVeg4PieceNo,
      state.friedChicken4PieceNo,
      state.steamVeg8PieceNo,
      state.steamChicken8PieceNo,
      state.friedVeg8PieceNo,
      state.friedChicken8PieceNo,
    );

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.lightGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GRAND TOTAL',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                'Total Plates: ${OrderCalculations.formatPlateCount(totalPlatesWithHalf)}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.green.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Text(
            SalePrices.formatPrice(totalAmount),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
