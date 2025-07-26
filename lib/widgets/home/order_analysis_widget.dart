import 'package:flutter/material.dart';
import '../../models/app_state.dart';
import '../../utils/order_calculations.dart';

class OrderAnalysisWidget extends StatelessWidget {
  final AppState state;

  const OrderAnalysisWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Aggregate Steam + Fried counts for Veg and Chicken
    final int totalVeg =
        state.steamVeg7PieceNo +
        state.steamVeg4PieceNo +
        state.steamVeg8PieceNo +
        state.friedVeg7PieceNo +
        state.friedVeg4PieceNo +
        state.friedVeg8PieceNo;

    final int totalChicken =
        state.steamChicken7PieceNo +
        state.steamChicken4PieceNo +
        state.steamChicken8PieceNo +
        state.friedChicken7PieceNo +
        state.friedChicken4PieceNo +
        state.friedChicken8PieceNo;

    final int totalPlates = totalVeg + totalChicken;

    // Calculate amounts for Veg vs Chicken
    final double vegAmount = OrderCalculations.calculateVegTotal(
      state.steamVeg7PieceNo + state.friedVeg7PieceNo,
      state.steamVeg4PieceNo + state.friedVeg4PieceNo,
      state.steamVeg8PieceNo + state.friedVeg8PieceNo,
    );

    final double chickenAmount = OrderCalculations.calculateChickenTotal(
      state.steamChicken7PieceNo + state.friedChicken7PieceNo,
      state.steamChicken4PieceNo + state.friedChicken4PieceNo,
      state.steamChicken8PieceNo + state.friedChicken8PieceNo,
    );

    // Calculate amounts for Steam vs Fried
    final double steamAmount =
        OrderCalculations.calculateVegTotal(
          state.steamVeg7PieceNo,
          state.steamVeg4PieceNo,
          state.steamVeg8PieceNo,
        ) +
        OrderCalculations.calculateChickenTotal(
          state.steamChicken7PieceNo,
          state.steamChicken4PieceNo,
          state.steamChicken8PieceNo,
        );

    final double friedAmount =
        OrderCalculations.calculateVegTotal(
          state.friedVeg7PieceNo,
          state.friedVeg4PieceNo,
          state.friedVeg8PieceNo,
        ) +
        OrderCalculations.calculateChickenTotal(
          state.friedChicken7PieceNo,
          state.friedChicken4PieceNo,
          state.friedChicken8PieceNo,
        );

    final int totalSteam =
        state.steamVeg7PieceNo +
        state.steamChicken7PieceNo +
        state.steamVeg4PieceNo +
        state.steamChicken4PieceNo +
        state.steamVeg8PieceNo +
        state.steamChicken8PieceNo;

    final int totalFried =
        state.friedVeg7PieceNo +
        state.friedChicken7PieceNo +
        state.friedVeg4PieceNo +
        state.friedChicken4PieceNo +
        state.friedVeg8PieceNo +
        state.friedChicken8PieceNo;

    final double totalAmount = vegAmount + chickenAmount;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(
                    Icons.analytics,
                    color: Colors.green,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                const Text(
                  'Order Analysis',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (totalPlates > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      '₹${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20.0),

            if (totalPlates > 0) ...[
              // Ingredient Type Analysis (Veg vs Chicken)
              _buildSectionHeader(
                'Ingredient Breakdown',
                Icons.restaurant_menu,
                Colors.purple,
              ),
              const SizedBox(height: 12.0),

              _buildEnhancedCategoryCard(
                'Vegetarian',
                totalVeg,
                vegAmount,
                totalPlates,
                totalAmount,
                Colors.green,
                Icons.eco,
              ),
              const SizedBox(height: 8.0),

              _buildEnhancedCategoryCard(
                'Chicken',
                totalChicken,
                chickenAmount,
                totalPlates,
                totalAmount,
                Colors.orange,
                Icons.set_meal,
              ),

              const SizedBox(height: 24.0),

              // Cooking Method Analysis (Steam vs Fried)
              _buildSectionHeader(
                'Cooking Method Breakdown',
                Icons.local_fire_department,
                Colors.red,
              ),
              const SizedBox(height: 12.0),

              if (totalSteam > 0)
                _buildEnhancedCategoryCard(
                  'Steam',
                  totalSteam,
                  steamAmount,
                  totalPlates,
                  totalAmount,
                  Colors.blue,
                  Icons.cloud,
                ),
              if (totalSteam > 0 && totalFried > 0) const SizedBox(height: 8.0),

              if (totalFried > 0)
                _buildEnhancedCategoryCard(
                  'Fried',
                  totalFried,
                  friedAmount,
                  totalPlates,
                  totalAmount,
                  Colors.deepOrange,
                  Icons.local_fire_department,
                ),

              const SizedBox(height: 20.0),

              // Summary Stats
              _buildSummaryStats(
                totalPlates,
                totalAmount,
                vegAmount,
                chickenAmount,
                steamAmount,
                friedAmount,
              ),
            ] else
              _buildEmptyState(),
          ],
        ),
      ),
    );
  }

  // Enhanced category card with better visualization
  Widget _buildEnhancedCategoryCard(
    String title,
    int count,
    double amount,
    int totalPlates,
    double totalAmount,
    Color color,
    IconData icon,
  ) {
    final double platePercentage =
        totalPlates > 0 ? (count / totalPlates) * 100 : 0;
    final double amountPercentage =
        totalAmount > 0 ? (amount / totalAmount) * 100 : 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.05), color.withOpacity(0.02)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.2), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(icon, color: color, size: 18.0),
                ),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.purple.shade700,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.purple.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12.0),

            // Progress bars and stats
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plates: $count',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${platePercentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.purple.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      _buildProgressBar(platePercentage / 100, color),

                      const SizedBox(height: 8.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Revenue Share',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${amountPercentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.purple.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      _buildProgressBar(
                        amountPercentage / 100,
                        color.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom progress bar widget
  Widget _buildProgressBar(double progress, Color color) {
    return Container(
      height: 6.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.grey.shade200,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
          ),
        ),
      ),
    );
  }

  // Section header widget
  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.purple.shade700,
          ),
        ),
      ],
    );
  }

  // Summary statistics widget
  Widget _buildSummaryStats(
    int totalPlates,
    double totalAmount,
    double vegAmount,
    double chickenAmount,
    double steamAmount,
    double friedAmount,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade100, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.summarize, color: Colors.grey.shade600, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          Wrap(
            spacing: 16.0,
            runSpacing: 8.0,
            children: [
              _buildStatChip(
                'Total Plates',
                totalPlates.toString(),
                Icons.restaurant,
                Colors.blue,
              ),
              _buildStatChip(
                'Avg. Price',
                '₹${(totalAmount / totalPlates).toStringAsFixed(1)}',
                Icons.trending_up,
                Colors.green,
              ),
              if (vegAmount > chickenAmount)
                _buildStatChip(
                  'Top Category',
                  'Vegetarian',
                  Icons.eco,
                  Colors.green,
                )
              else if (chickenAmount > vegAmount)
                _buildStatChip(
                  'Top Category',
                  'Chicken',
                  Icons.set_meal,
                  Colors.orange,
                )
              else
                _buildStatChip(
                  'Categories',
                  'Balanced',
                  Icons.balance,
                  Colors.purple,
                ),
              if (steamAmount > friedAmount)
                _buildStatChip(
                  'Preferred Method',
                  'Steam',
                  Icons.cloud,
                  Colors.blue,
                )
              else if (friedAmount > steamAmount)
                _buildStatChip(
                  'Preferred Method',
                  'Fried',
                  Icons.local_fire_department,
                  Colors.deepOrange,
                )
              else
                _buildStatChip(
                  'Cooking Methods',
                  'Mixed',
                  Icons.restaurant_menu,
                  Colors.grey,
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Individual stat chip
  Widget _buildStatChip(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: color),
          const SizedBox(width: 4.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.analytics,
              size: 48.0,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Start adding items to see detailed analysis',
            style: TextStyle(fontSize: 14.0, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
