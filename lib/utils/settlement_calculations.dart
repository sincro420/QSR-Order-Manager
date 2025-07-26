import '../constants/prices.dart';

class SettlementCalculations {
  /// Calculate the amount for 7-piece plates
  /// Formula: (plate_count * 7 / 8) * price_per_8_pieces
  static double calculate7PieceAmount(
    int vegCount,
    int chickenCount,
    // REMOVED: int paneerCount
  ) {
    double vegAmount = (vegCount * 7 / 8) * Prices.VEG_PRICE;
    double chickenAmount = (chickenCount * 7 / 8) * Prices.CHICKEN_PRICE;
    // REMOVED: double paneerAmount = (paneerCount * 7 / 8) * Prices.PANEER_PRICE;

    return vegAmount + chickenAmount;
  }

  /// Calculate the amount for 4-piece plates
  /// Formula: veg = count * 15 (30/2), chicken = count * 17.5 (35/2)
  static double calculate4PieceAmount(int vegCount, int chickenCount) {
    double vegAmount = vegCount * 15.0; // 30/2 = 15
    double chickenAmount = chickenCount * 17.5; // 35/2 = 17.5

    return vegAmount + chickenAmount;
  }

  /// Calculate the amount for 8-piece plates
  /// Formula: plate_count * price_per_8_pieces
  static double calculate8PieceAmount(int vegCount, int chickenCount) {
    double vegAmount = vegCount * Prices.VEG_PRICE;
    double chickenAmount = chickenCount * Prices.CHICKEN_PRICE;

    return vegAmount + chickenAmount;
  }

  /// Calculate the total amount across all plate sizes
  /// Now includes 4-piece plates
  static double calculateTotalAmount(
    int veg7Count,
    int chicken7Count,
    int veg4Count,
    int chicken4Count,
    int veg8Count,
    int chicken8Count,
  ) {
    double amount7Piece = calculate7PieceAmount(veg7Count, chicken7Count);

    double amount4Piece = calculate4PieceAmount(veg4Count, chicken4Count);

    double amount8Piece = calculate8PieceAmount(veg8Count, chicken8Count);

    return amount7Piece + amount4Piece + amount8Piece;
  }

  /// Calculate total amount for veg items across all plate sizes
  static double calculateVegTotal(int veg7Count, int veg4Count, int veg8Count) {
    double veg7Amount = (veg7Count * 7 / 8) * Prices.VEG_PRICE;
    double veg4Amount = veg4Count * 15.0;
    double veg8Amount = veg8Count * Prices.VEG_PRICE;

    return veg7Amount + veg4Amount + veg8Amount;
  }

  /// Calculate total amount for chicken items across all plate sizes
  static double calculateChickenTotal(
    int chicken7Count,
    int chicken4Count,
    int chicken8Count,
  ) {
    double chicken7Amount = (chicken7Count * 7 / 8) * Prices.CHICKEN_PRICE;
    double chicken4Amount = chicken4Count * 17.5;
    double chicken8Amount = chicken8Count * Prices.CHICKEN_PRICE;

    return chicken7Amount + chicken4Amount + chicken8Amount;
  }

  /// Get total plates for a specific size across all categories
  static int getTotalPlatesForSize(
    int plateSize,
    int vegCount,
    int chickenCount,
  ) {
    return vegCount + chickenCount;
  }

  /// Get total count of all plates across all sizes and categories
  static int getTotalAllPlates(
    int veg7Count,
    int chicken7Count,
    int veg4Count,
    int chicken4Count,
    int veg8Count,
    int chicken8Count,
  ) {
    int total7Piece = getTotalPlatesForSize(7, veg7Count, chicken7Count);
    int total4Piece = getTotalPlatesForSize(4, veg4Count, chicken4Count);
    int total8Piece = getTotalPlatesForSize(8, veg8Count, chicken8Count);

    return total7Piece + total4Piece + total8Piece;
  }

  /// Get the calculation formula as a string for display purposes
  static String getFormulaForPlateSize(int plateSize) {
    switch (plateSize) {
      case 7:
        return 'Total Momos ÷ 8 × Price per 8-piece';
      case 4:
        return 'Veg: ₹15 per plate, Chicken: ₹17.5 per plate';
      case 8:
        return 'Veg: ₹30 per 8-piece, Chicken: ₹35 per 8-piece';
      default:
        return 'Unknown plate size';
    }
  }

  /// Get the per-piece rate for a specific category and plate size
  static double getPerPieceRate(String category, int plateSize) {
    switch (plateSize) {
      case 7:
        // 7-piece plates are calculated as (count * 7/8) * 8-piece price
        // So per piece = (7/8) * 8-piece price / 7 = 8-piece price / 8
        switch (category) {
          case 'veg':
            return Prices.VEG_PRICE / 8;
          case 'chicken':
            return Prices.CHICKEN_PRICE / 8;
          default:
            return 0.0;
        }
      case 4:
        switch (category) {
          case 'veg':
            return 15.0 / 4; // ₹15 per 4-piece plate = ₹3.75 per piece
          case 'chicken':
            return 17.5 / 4; // ₹17.5 per 4-piece plate = ₹4.375 per piece
          default:
            return 0.0;
        }
      case 8:
        switch (category) {
          case 'veg':
            return Prices.VEG_PRICE / 8;
          case 'chicken':
            return Prices.CHICKEN_PRICE / 8;
          default:
            return 0.0;
        }
      default:
        return 0.0;
    }
  }

  /// Validate that plate counts are non-negative
  static bool validatePlateCounts(List<int> counts) {
    return counts.every((count) => count >= 0);
  }

  /// Calculate savings/difference between different plate combinations
  static double calculateSavings(
    int originalVeg8,
    int originalChicken8,
    int newVeg7,
    int newChicken7,
    int newVeg4,
    int newChicken4,
    int newVeg8,
    int newChicken8,
  ) {
    double originalAmount = calculate8PieceAmount(
      originalVeg8,
      originalChicken8,
    );
    double newAmount = calculateTotalAmount(
      newVeg7,
      newChicken7,
      newVeg4,
      newChicken4,
      newVeg8,
      newChicken8,
    );

    return originalAmount - newAmount;
  }
}
