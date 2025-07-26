import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/app_state.dart';
import '../widgets/home/category_column.dart';
import '../widgets/home/order_analysis_widget.dart';
import '../widgets/home/order_summary.dart';

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
                OrderSummary(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}
