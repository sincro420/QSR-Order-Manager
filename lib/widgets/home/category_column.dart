import 'package:flutter/material.dart';
import '../common/counter_widget.dart';

class CategoryColumn extends StatelessWidget {
  final String category;
  final String title;
  final int sevenPieceValue;
  final int fourPieceValue;
  final int eightPieceValue;
  final VoidCallback onIncrementSevenPiece;
  final VoidCallback onDecrementSevenPiece;
  final VoidCallback onIncrementFourPiece;
  final VoidCallback onDecrementFourPiece;
  final VoidCallback onIncrementEightPiece;
  final VoidCallback onDecrementEightPiece;

  const CategoryColumn({
    super.key,
    required this.category,
    required this.title,
    required this.sevenPieceValue,
    required this.fourPieceValue,
    required this.eightPieceValue,
    required this.onIncrementSevenPiece,
    required this.onDecrementSevenPiece,
    required this.onIncrementFourPiece,
    required this.onDecrementFourPiece,
    required this.onIncrementEightPiece,
    required this.onDecrementEightPiece,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =============================================================================
          // CATEGORY TITLE
          // =============================================================================
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),

          // =============================================================================
          // 7-PIECE PLATES COUNTER (Large Size)
          // =============================================================================
          CounterWidget(
            label: '7-Piece Plates',
            value: sevenPieceValue,
            onIncrement: onIncrementSevenPiece,
            onDecrement: onDecrementSevenPiece,
            size: CounterSize.large,
          ),
          const SizedBox(height: 16.0),

          // =============================================================================
          // 4-PIECE PLATES COUNTER (Large Size)
          // =============================================================================
          CounterWidget(
            label: '4-Piece Plates',
            value: fourPieceValue,
            onIncrement: onIncrementFourPiece,
            onDecrement: onDecrementFourPiece,
            size: CounterSize.large, // Same size as 7-piece
          ),
          const SizedBox(height: 24.0),

          // =============================================================================
          // DIVIDER SECTION
          // =============================================================================
          const Divider(),
          const SizedBox(height: 16.0),

          // =============================================================================
          // 8-PIECE PLATES COUNTER (Small Size)
          // =============================================================================
          CounterWidget(
            label: '8-Piece Plates',
            value: eightPieceValue,
            onIncrement: onIncrementEightPiece,
            onDecrement: onDecrementEightPiece,
            size: CounterSize.small,
          ),
        ],
      ),
    );
  }
}
