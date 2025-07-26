class SalePrices {
  // Steam Plate Prices
  static const double steamSevenPiecePrice = 59.0;
  static const double steamFourPiecePrice = 39.0;
  static const double steamEightPiecePrice = 59.0;

  // Fried Plate Prices
  static const double friedSevenPiecePrice = 69.0;
  static const double friedFourPiecePrice = 49.0;
  static const double friedEightPiecePrice = 69.0;

  // Get price by cooking method and plate size
  static double getPrice(String cookingMethod, int plateSize) {
    switch (cookingMethod.toLowerCase()) {
      case 'steam':
        return getSteamPrice(plateSize);
      case 'fried':
        return getFriedPrice(plateSize);
      default:
        return 0.0;
    }
  }

  // Get steam price by plate size
  static double getSteamPrice(int plateSize) {
    switch (plateSize) {
      case 7:
        return steamSevenPiecePrice;
      case 4:
        return steamFourPiecePrice;
      case 8:
        return steamEightPiecePrice;
      default:
        return 0.0;
    }
  }

  // Get fried price by plate size
  static double getFriedPrice(int plateSize) {
    switch (plateSize) {
      case 7:
        return friedSevenPiecePrice;
      case 4:
        return friedFourPiecePrice;
      case 8:
        return friedEightPiecePrice;
      default:
        return 0.0;
    }
  }

  // Utility methods for common calculations
  static double calculateSteamAmount(int plateSize, int count) {
    return getSteamPrice(plateSize) * count;
  }

  static double calculateFriedAmount(int plateSize, int count) {
    return getFriedPrice(plateSize) * count;
  }

  // Get price difference between steam and fried for same plate size
  static double getPriceDifference(int plateSize) {
    return getFriedPrice(plateSize) - getSteamPrice(plateSize);
  }

  // Format price for display
  static String formatPrice(double price) {
    return '₹${price.toStringAsFixed(2)}';
  }

  // Get all prices as a map for easy access
  static Map<String, Map<int, double>> getAllPrices() {
    return {
      'steam': {
        7: steamSevenPiecePrice,
        4: steamFourPiecePrice,
        8: steamEightPiecePrice,
      },
      'fried': {
        7: friedSevenPiecePrice,
        4: friedFourPiecePrice,
        8: friedEightPiecePrice,
      },
    };
  }
}
