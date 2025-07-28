import 'package:flutter/material.dart';
import '../../../utils/order_calculations.dart';
import '../../../models/app_state.dart';
import '../../../constants/sale_prices.dart';

class OrderAnalysisWidget extends StatelessWidget {
  final AppState state;

  const OrderAnalysisWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            buildHeader(context),
            const SizedBox(height: 16.0),
            // Quick Summary Cards
            buildQuickSummaryCards(context),
            const SizedBox(height: 16.0),
            const Divider(thickness: 1.0),
            // Detailed Breakdown
            buildDetailedBreakdown(context),
            const SizedBox(height: 12.0),
            const Divider(thickness: 1.0),
            // Plate Size Analysis
            buildPlateSizeAnalysis(context),
            const SizedBox(height: 12.0),
            const Divider(thickness: 1.0),
            // Grand Totals
            buildGrandTotals(context),
          ],
        ),
      ),
    );
  }

  // Header Section - Enhanced with BuildContext parameter
  Widget buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          Icons.analytics,
          color:
              isDark ? const Color(0xFF60A5FA) : Theme.of(context).primaryColor,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          'Order Analysis',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color:
                isDark
                    ? const Color(0xFF60A5FA)
                    : Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  // Quick Summary Cards - Enhanced with BuildContext parameter
  Widget buildQuickSummaryCards(BuildContext context) {
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
          child: buildSummaryCard(
            context,
            'Total Plates',
            OrderCalculations.formatPlateCount(totalPlatesWithHalf),
            Icons.restaurant_menu,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: buildSummaryCard(
            context,
            'Total Amount',
            SalePrices.formatPrice(totalAmount),
            Icons.currency_rupee,
            Colors.green,
          ),
        ),
      ],
    );
  }

  // Summary Card - Enhanced with improved dark mode colors
  Widget buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Enhanced color mapping for dark mode
    Color getEnhancedColor(Color originalColor) {
      if (originalColor == Colors.blue) {
        return isDark ? const Color(0xFF60A5FA) : Colors.blue;
      } else if (originalColor == Colors.green) {
        return isDark ? const Color(0xFF4ADE80) : Colors.green;
      } else if (originalColor == Colors.orange) {
        return isDark ? const Color(0xFFFB923C) : Colors.orange;
      } else if (originalColor == Colors.red) {
        return isDark ? const Color(0xFFEF4444) : Colors.red;
      }
      return originalColor;
    }

    final enhancedColor = getEnhancedColor(color);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            isDark ? enhancedColor.withOpacity(0.15) : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark ? enhancedColor.withOpacity(0.4) : color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: enhancedColor, size: 28.0),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              color: enhancedColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: enhancedColor,
            ),
          ),
        ],
      ),
    );
  }

  // Detailed Breakdown - Enhanced with BuildContext parameter
  Widget buildDetailedBreakdown(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Breakdown',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12.0),
        // Steam Category
        buildCategoryBreakdown(context, 'Steam', true),
        const SizedBox(height: 12.0),
        // Fried Category
        buildCategoryBreakdown(context, 'Fried', false),
      ],
    );
  }

  // Category Breakdown - Enhanced with improved dark mode colors
  Widget buildCategoryBreakdown(
    BuildContext context,
    String category,
    bool isSteam,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

    // Enhanced color mapping
    Color getEnhancedColor(Color originalColor) {
      if (originalColor == Colors.blue) {
        return isDark ? const Color(0xFF60A5FA) : Colors.blue;
      } else if (originalColor == Colors.orange) {
        return isDark ? const Color(0xFFFB923C) : Colors.orange;
      }
      return originalColor;
    }

    final enhancedColor = getEnhancedColor(categoryColor);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            isDark
                ? enhancedColor.withOpacity(0.1)
                : categoryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(left: BorderSide(color: enhancedColor, width: 4.0)),
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
                  color: enhancedColor,
                ),
              ),
              Text(
                SalePrices.formatPrice(categoryTotal),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: enhancedColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'Plates: ${OrderCalculations.formatPlateCount(categoryPlatesWithHalf)}',
            style: TextStyle(
              fontSize: 12.0,
              color: enhancedColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  // Plate Size Analysis - Enhanced with BuildContext parameter
  Widget buildPlateSizeAnalysis(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plate Size Analysis',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12.0),
        // 7-Piece Analysis
        buildPlateSizeRow(context, 7),
        const SizedBox(height: 8.0),
        // 4-Piece Analysis
        buildPlateSizeRow(context, 4),
        const SizedBox(height: 8.0),
        // 8-Piece Analysis
        buildPlateSizeRow(context, 8),
      ],
    );
  }

  // Plate Size Row - Enhanced with BuildContext parameter and improved colors
  Widget buildPlateSizeRow(BuildContext context, int plateSize) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
      default:
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$plateSize-Piece',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
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
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontWeight:
                    plateSize == 4 ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              SalePrices.formatPrice(amount),
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Grand Totals - Enhanced with improved dark mode colors
  Widget buildGrandTotals(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        color:
            isDark
                ? const Color(0xFF4ADE80).withOpacity(0.15)
                : Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color:
              isDark
                  ? const Color(0xFF4ADE80).withOpacity(0.4)
                  : Colors.lightGreen.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GRAND TOTAL',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF4ADE80) : Colors.green,
                ),
              ),
              Text(
                'Total Plates: ${OrderCalculations.formatPlateCount(totalPlatesWithHalf)}',
                style: TextStyle(
                  fontSize: 12.0,
                  color:
                      isDark
                          ? const Color(0xFF4ADE80).withOpacity(0.8)
                          : Colors.green.withOpacity(0.8),
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
              boxShadow: [
                BoxShadow(
                  color: (isDark ? const Color(0xFF4ADE80) : Colors.green)
                      .withOpacity(0.3),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              SalePrices.formatPrice(totalAmount),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
