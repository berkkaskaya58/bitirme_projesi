import 'package:flutter/material.dart';

class FeedbackIcon extends StatelessWidget {
  const FeedbackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.check_circle, color: Colors.green, size: 100),
    );
  }
}