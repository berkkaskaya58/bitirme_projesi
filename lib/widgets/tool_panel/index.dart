import 'dart:math';
import 'package:flutter/material.dart';

class ToolPanel extends StatelessWidget {
  final Color penColor;
  final bool isEraser;
  final double eraserSize;
  final Function(Color) onPenSelected;
  final VoidCallback onEraserSelected;

  const ToolPanel({
    super.key,
    required this.penColor,
    required this.isEraser,
    required this.eraserSize,
    required this.onPenSelected,
    required this.onEraserSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 16,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: 'pen',
            onPressed: () {
              onPenSelected(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
            },
            backgroundColor: isEraser ? Colors.grey : penColor,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'eraser',
            onPressed: onEraserSelected,
            backgroundColor: isEraser ? Colors.red : Colors.grey.shade300,
            child: const Icon(Icons.cleaning_services),
          ),
        ],
      ),
    );
  }
}