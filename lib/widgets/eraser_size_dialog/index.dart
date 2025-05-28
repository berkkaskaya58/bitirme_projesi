import 'package:flutter/material.dart';

void showEraserSizeDialog(BuildContext context, double currentSize, Function(double) onSizeChanged) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Silgi Boyutu'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Slider(
            value: currentSize,
            min: 5,
            max: 40,
            onChanged: (v) {
              setState(() => onSizeChanged(v));
            },
          );
        },
      ),
    ),
  );
}