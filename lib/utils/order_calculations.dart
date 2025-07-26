import '../constants/sale_prices.dart';

class OrderCalculations {
  // Steam plate pricing - individual methods using SalePrices
  static double calculate7PieceSteamVegAmount(int count) {
    return SalePrices.calculateSteamAmount(7, count);
  }

  static double calculate7PieceSteamChickenAmount(int count) {
    return SalePrices.calculateSteamAmount(7, count);
  }

  static double calculate8PieceSteamVegAmount(int count) {
    return SalePrices.calculateSteamAmount(8, count);
  }

  static double calculate8PieceSteamChickenAmount(int count) {
    return SalePrices.calculateSteamAmount(8, count);
  }

  static double calculate4PieceSteamVegAmount(int count) {
    return SalePrices.calculateSteamAmount(4, count);
  }

  static double calculate4PieceSteamChickenAmount(int count) {
    return SalePrices.calculateSteamAmount(4, count);
  }

  // Fried plate pricing - individual methods using SalePrices
  static double calculate7PieceFriedVegAmount(int count) {
    return SalePrices.calculateFriedAmount(7, count);
  }

  static double calculate7PieceFriedChickenAmount(int count) {
    return SalePrices.calculateFriedAmount(7, count);
  }

  static double calculate8PieceFriedVegAmount(int count) {
    return SalePrices.calculateFriedAmount(8, count);
  }

  static double calculate8PieceFriedChickenAmount(int count) {
    return SalePrices.calculateFriedAmount(8, count);
  }

  static double calculate4PieceFriedVegAmount(int count) {
    return SalePrices.calculateFriedAmount(4, count);
  }

  static double calculate4PieceFriedChickenAmount(int count) {
    return SalePrices.calculateFriedAmount(4, count);
  }

  // Combined calculations by plate size using SalePrices
  static double calculate7PieceAmount(
    int steamVegCount,
    int steamChickenCount,
    int friedVegCount,
    int friedChickenCount,
  ) {
    double steamAmount = SalePrices.calculateSteamAmount(
      7,
      steamVegCount + steamChickenCount,
    );
    double friedAmount = SalePrices.calculateFriedAmount(
      7,
      friedVegCount + friedChickenCount,
    );
    return steamAmount + friedAmount;
  }

  static double calculate4PieceAmount(
    int steamVegCount,
    int steamChickenCount,
    int friedVegCount,
    int friedChickenCount,
  ) {
    double steamAmount = SalePrices.calculateSteamAmount(
      4,
      steamVegCount + steamChickenCount,
    );
    double friedAmount = SalePrices.calculateFriedAmount(
      4,
      friedVegCount + friedChickenCount,
    );
    return steamAmount + friedAmount;
  }

  static double calculate8PieceAmount(
    int steamVegCount,
    int steamChickenCount,
    int friedVegCount,
    int friedChickenCount,
  ) {
    double steamAmount = SalePrices.calculateSteamAmount(
      8,
      steamVegCount + steamChickenCount,
    );
    double friedAmount = SalePrices.calculateFriedAmount(
      8,
      friedVegCount + friedChickenCount,
    );
    return steamAmount + friedAmount;
  }

  // Total calculations for steam category using SalePrices
  static double calculateSteamVegTotal(
    int count7Piece,
    int count4Piece,
    int count8Piece,
  ) {
    return SalePrices.calculateSteamAmount(7, count7Piece) +
        SalePrices.calculateSteamAmount(4, count4Piece) +
        SalePrices.calculateSteamAmount(8, count8Piece);
  }

  static double calculateSteamChickenTotal(
    int count7Piece,
    int count4Piece,
    int count8Piece,
  ) {
    return SalePrices.calculateSteamAmount(7, count7Piece) +
        SalePrices.calculateSteamAmount(4, count4Piece) +
        SalePrices.calculateSteamAmount(8, count8Piece);
  }

  static double calculateSteamTotal(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    return calculateSteamVegTotal(veg7Count, veg4Count, veg8Count) +
        calculateSteamChickenTotal(chicken7Count, chicken4Count, chicken8Count);
  }

  // Total calculations for fried category using SalePrices
  static double calculateFriedVegTotal(
    int count7Piece,
    int count4Piece,
    int count8Piece,
  ) {
    return SalePrices.calculateFriedAmount(7, count7Piece) +
        SalePrices.calculateFriedAmount(4, count4Piece) +
        SalePrices.calculateFriedAmount(8, count8Piece);
  }

  static double calculateFriedChickenTotal(
    int count7Piece,
    int count4Piece,
    int count8Piece,
  ) {
    return SalePrices.calculateFriedAmount(7, count7Piece) +
        SalePrices.calculateFriedAmount(4, count4Piece) +
        SalePrices.calculateFriedAmount(8, count8Piece);
  }

  static double calculateFriedTotal(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    return calculateFriedVegTotal(veg7Count, veg4Count, veg8Count) +
        calculateFriedChickenTotal(chicken7Count, chicken4Count, chicken8Count);
  }

  // Grand total calculation using SalePrices
  static double calculateTotalAmount(
    int steamVeg7Count,
    int steamChicken7Count,
    int friedVeg7Count,
    int friedChicken7Count,
    int steamVeg4Count,
    int steamChicken4Count,
    int friedVeg4Count,
    int friedChicken4Count,
    int steamVeg8Count,
    int steamChicken8Count,
    int friedVeg8Count,
    int friedChicken8Count,
  ) {
    double steamTotal = calculateSteamTotal(
      steamVeg7Count,
      steamVeg4Count,
      steamVeg8Count,
      steamChicken7Count,
      steamChicken4Count,
      steamChicken8Count,
    );

    double friedTotal = calculateFriedTotal(
      friedVeg7Count,
      friedVeg4Count,
      friedVeg8Count,
      friedChicken7Count,
      friedChicken4Count,
      friedChicken8Count,
    );

    return steamTotal + friedTotal;
  }

  // Plate count calculations (regular count)
  static int getTotalSteamPlates(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    return veg7Count +
        veg4Count +
        veg8Count +
        chicken7Count +
        chicken4Count +
        chicken8Count;
  }

  static int getTotalFriedPlates(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    return veg7Count +
        veg4Count +
        veg8Count +
        chicken7Count +
        chicken4Count +
        chicken8Count;
  }

  static int getTotalAllPlates(
    int steamVeg7Count,
    int steamChicken7Count,
    int friedVeg7Count,
    int friedChicken7Count,
    int steamVeg4Count,
    int steamChicken4Count,
    int friedVeg4Count,
    int friedChicken4Count,
    int steamVeg8Count,
    int steamChicken8Count,
    int friedVeg8Count,
    int friedChicken8Count,
  ) {
    return getTotalSteamPlates(
          steamVeg7Count,
          steamVeg4Count,
          steamVeg8Count,
          steamChicken7Count,
          steamChicken4Count,
          steamChicken8Count,
        ) +
        getTotalFriedPlates(
          friedVeg7Count,
          friedVeg4Count,
          friedVeg8Count,
          friedChicken7Count,
          friedChicken4Count,
          friedChicken8Count,
        );
  }

  // Plate count with 4-piece plates counted as 0.5
  static double getTotalSteamPlatesWithHalfCount(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    int fullPlates = veg7Count + veg8Count + chicken7Count + chicken8Count;
    int halfPlates = veg4Count + chicken4Count;
    return fullPlates + (halfPlates * 0.5);
  }

  static double getTotalFriedPlatesWithHalfCount(
    int veg7Count,
    int veg4Count,
    int veg8Count,
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    int fullPlates = veg7Count + veg8Count + chicken7Count + chicken8Count;
    int halfPlates = veg4Count + chicken4Count;
    return fullPlates + (halfPlates * 0.5);
  }

  static double getTotalAllPlatesWithHalfCount(
    int steamVeg7Count,
    int steamChicken7Count,
    int friedVeg7Count,
    int friedChicken7Count,
    int steamVeg4Count,
    int steamChicken4Count,
    int friedVeg4Count,
    int friedChicken4Count,
    int steamVeg8Count,
    int steamChicken8Count,
    int friedVeg8Count,
    int friedChicken8Count,
  ) {
    return getTotalSteamPlatesWithHalfCount(
          steamVeg7Count,
          steamVeg4Count,
          steamVeg8Count,
          steamChicken7Count,
          steamChicken4Count,
          steamChicken8Count,
        ) +
        getTotalFriedPlatesWithHalfCount(
          friedVeg7Count,
          friedVeg4Count,
          friedVeg8Count,
          friedChicken7Count,
          friedChicken4Count,
          friedChicken8Count,
        );
  }

  // Savings calculations (using original prices from your existing code)
  static double calculateVegSavings(int count) {
    // You'll need to import your original PRICES constant for this calculation
    // Placeholder implementation - adjust based on your original prices.dart
    return 0.0; // Implement based on your existing PRICES constant
  }

  static double calculateChickenSavings(int count) {
    // You'll need to import your original PRICES constant for this calculation
    // Placeholder implementation - adjust based on your original prices.dart
    return 0.0; // Implement based on your existing PRICES constant
  }

  static double calculateTotalSavings(int vegCount, int chickenCount) {
    return calculateVegSavings(vegCount) +
        calculateChickenSavings(chickenCount);
  }

  // Utility methods for formatting
  static String formatAmount(double amount) {
    return SalePrices.formatPrice(amount);
  }

  static String formatPlateCount(double count) {
    return count % 1 == 0 ? count.toInt().toString() : count.toStringAsFixed(1);
  }

  // Additional utility methods for easy price access
  static double getPlatePrice(String cookingMethod, int plateSize) {
    return SalePrices.getPrice(cookingMethod, plateSize);
  }

  static double getPriceDifference(int plateSize) {
    return SalePrices.getPriceDifference(plateSize);
  }
}
