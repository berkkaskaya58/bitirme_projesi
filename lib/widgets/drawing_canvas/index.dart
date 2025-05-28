import 'package:flutter/material.dart';

class DrawingCanvas extends StatelessWidget {
  final List<List<Offset?>> paths;
  final int pathIndex;
  final Color penColor;
  final double penWidth;
  final double eraserSize;
  final bool isEraser;
  final String animatedText;
  final bool isCorrect;
  final VoidCallback onPanStart;
  final Function(Offset offset) onPanUpdate;
  final Function(Size size) onPanEnd;

  const DrawingCanvas({
    super.key,
    required this.paths,
    required this.pathIndex,
    required this.penColor,
    required this.penWidth,
    required this.eraserSize,
    required this.isEraser,
    required this.animatedText,
    required this.isCorrect,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => onPanStart(),
      onPanUpdate: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset local = box.globalToLocal(details.globalPosition);
        onPanUpdate(local);
      },
      onPanEnd: (_) {
        RenderBox box = context.findRenderObject() as RenderBox;
        onPanEnd(box.size);
      },
      child: CustomPaint(
        painter: _DrawingPainter(
          paths: paths.sublist(0, pathIndex + 1),
          color: penColor,
          strokeWidth: isEraser ? eraserSize : penWidth,
          isEraser: isEraser,
          animatedText: animatedText,
        ),
        child: Container(),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<List<Offset?>> paths;
  final Color color;
  final double strokeWidth;
  final bool isEraser;
  final String animatedText;

  _DrawingPainter({
    required this.paths,
    required this.color,
    required this.strokeWidth,
    required this.isEraser,
    required this.animatedText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgText = TextPainter(
      text: TextSpan(
        text: animatedText,
        style: TextStyle(fontSize: 140, color: Colors.grey.shade300, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    bgText.paint(canvas, Offset((size.width - bgText.width) / 2, (size.height - bgText.height) / 2));

    final paint = Paint()
      ..color = isEraser ? Colors.white : color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (final path in paths) {
      for (int i = 0; i < path.length - 1; i++) {
        if (path[i] != null && path[i + 1] != null) {
          canvas.drawLine(path[i]!, path[i + 1]!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}