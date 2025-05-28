import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onUndo;
  final VoidCallback onRedo;

  const ActionButtons({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.onUndo,
    required this.onRedo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: onPrevious,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Geri'),
          ),
          Row(
            children: [
              IconButton(onPressed: onUndo, icon: const Icon(Icons.undo)),
              IconButton(onPressed: onRedo, icon: const Icon(Icons.redo)),
            ],
          ),
          ElevatedButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('İleri'),
          ),
        ],
      ),
    );
  }
}