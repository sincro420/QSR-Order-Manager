import 'package:flutter/material.dart';

enum CounterSize { large, small }

class CounterWidget extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final CounterSize size;

  const CounterWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.size = CounterSize.large,
  });

  @override
  Widget build(BuildContext context) {
    final isLarge = size == CounterSize.large;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 16.0 : 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              icon: Icons.add,
              onPressed: onIncrement,
              isLarge: isLarge,
            ),
            Container(
              width: isLarge ? 60.0 : 35.0,
              height: isLarge ? 60.0 : 40.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: isLarge ? 24.0 : 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildButton(
              icon: Icons.remove,
              onPressed: onDecrement,
              isLarge: isLarge,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isLarge,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(isLarge ? 50.0 : 25.0, isLarge ? 50.0 : 30.0),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Icon(icon, size: isLarge ? 24.0 : 16.0),
      ),
    );
  }
}
