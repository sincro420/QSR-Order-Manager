import '../constants/prices.dart';

class Calculations {
  // Calculate the amount for 7-piece plates
  // Formula: ((veg7PieceNo*7)/8)*30 + ((chicken7PieceNo*7)/8)*35 + ((paneer7PieceNo*7)/8)*40
  static double calculate7PieceAmount(
    int vegCount,
    int chickenCount,
    int paneerCount,
  ) {
    double vegAmount = ((vegCount * 7) / 8) * Prices.VEG_PRICE;
    double chickenAmount = ((chickenCount * 7) / 8) * Prices.CHICKEN_PRICE;
    double paneerAmount = ((paneerCount * 7) / 8) * Prices.PANEER_PRICE;

    return vegAmount + chickenAmount + paneerAmount;
  }

  // Calculate the amount for 8-piece plates
  // Formula: veg8PieceNo*30 + chicken8PieceNo*35 + paneer8PieceNo*40
  static double calculate8PieceAmount(
    int vegCount,
    int chickenCount,
    int paneerCount,
  ) {
    double vegAmount = vegCount * Prices.VEG_PRICE;
    double chickenAmount = chickenCount * Prices.CHICKEN_PRICE;
    double paneerAmount = paneerCount * Prices.PANEER_PRICE;

    return vegAmount + chickenAmount + paneerAmount;
  }

  // Calculate the total amount (sum of 7-piece and 8-piece amounts)
  static double calculateTotalAmount(
    int veg7Count,
    int chicken7Count,
    int paneer7Count,
    int veg8Count,
    int chicken8Count,
    int paneer8Count,
  ) {
    double amount7Piece = calculate7PieceAmount(
      veg7Count,
      chicken7Count,
      paneer7Count,
    );
    double amount8Piece = calculate8PieceAmount(
      veg8Count,
      chicken8Count,
      paneer8Count,
    );

    return amount7Piece + amount8Piece;
  }
}
