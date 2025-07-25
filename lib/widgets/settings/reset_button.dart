import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onReset;

  const ResetButton({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24.0),
        child: ElevatedButton(
          onPressed: () {
            // Show confirmation dialog before resetting
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Reset All Counters'),
                    content: const Text(
                      'Are you sure you want to reset all counters to zero? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          onReset();
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'All counters have been reset to zero.',
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'RESET',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
