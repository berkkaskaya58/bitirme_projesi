import 'dart:math';
import 'package:flutter/material.dart';

bool isDrawingCorrect(List<List<Offset?>> paths, Size size) {
  final points = paths.expand((p) => p).whereType<Offset>().toList();
  if (points.isEmpty) return false;

  final xs = points.map((p) => p.dx).toList();
  final ys = points.map((p) => p.dy).toList();
  final minX = xs.reduce(min);
  final maxX = xs.reduce(max);
  final minY = ys.reduce(min);
  final maxY = ys.reduce(max);
  final coverageX = (maxX - minX) / size.width;
  final coverageY = (maxY - minY) / size.height;

  return coverageX > 0.6 && coverageY > 0.2 && points.length > 120;
}