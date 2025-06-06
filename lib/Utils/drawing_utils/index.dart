import 'dart:math';
import 'package:flutter/material.dart';

class DrawingUtils {
  static List<Offset> getLetterGuideLines(String letter, Rect region) {
    List<Offset> lines = [];
    
    switch (letter.toLowerCase()) {
      case 'e':
        // E harfi için çizgiler
        lines.addAll([
          // Üst çizgi
          Offset(region.left + region.width * 0.1, region.top + region.height * 0.2),
          Offset(region.right - region.width * 0.1, region.top + region.height * 0.2),
          // Orta çizgi
          Offset(region.left + region.width * 0.1, region.top + region.height * 0.5),
          Offset(region.right - region.width * 0.1, region.top + region.height * 0.5),
          // Alt çizgi
          Offset(region.left + region.width * 0.1, region.bottom - region.height * 0.2),
          Offset(region.right - region.width * 0.1, region.bottom - region.height * 0.2),
          // Dikey çizgi
          Offset(region.left + region.width * 0.1, region.top + region.height * 0.2),
          Offset(region.left + region.width * 0.1, region.bottom - region.height * 0.2),
        ]);
        break;
      case 'v':
        // V harfi için çizgiler
        lines.addAll([
          // Sol çapraz
          Offset(region.left + region.width * 0.1, region.top + region.height * 0.2),
          Offset(region.left + region.width * 0.5, region.bottom - region.height * 0.2),
          // Sağ çapraz
          Offset(region.right - region.width * 0.1, region.top + region.height * 0.2),
          Offset(region.left + region.width * 0.5, region.bottom - region.height * 0.2),
        ]);
        break;
      // Diğer harfler için benzer şekilde devam edebilirsiniz
      default:
        // Varsayılan olarak basit bir kutu
        lines.addAll([
          Offset(region.left, region.top),
          Offset(region.right, region.top),
          Offset(region.right, region.bottom),
          Offset(region.left, region.bottom),
          Offset(region.left, region.top),
        ]);
    }
    
    return lines;
  }

  static bool isNearLine(Offset point, Offset lineStart, Offset lineEnd, double threshold) {
    // Noktanın çizgiye olan uzaklığını hesapla
    double distance = _distanceToLine(point, lineStart, lineEnd);
    return distance < threshold;
  }

  static double _distanceToLine(Offset point, Offset lineStart, Offset lineEnd) {
    double A = point.dx - lineStart.dx;
    double B = point.dy - lineStart.dy;
    double C = lineEnd.dx - lineStart.dx;
    double D = lineEnd.dy - lineStart.dy;

    double dot = A * C + B * D;
    double len_sq = C * C + D * D;
    double param = -1;

    if (len_sq != 0) {
      param = dot / len_sq;
    }

    double xx, yy;

    if (param < 0) {
      xx = lineStart.dx;
      yy = lineStart.dy;
    } else if (param > 1) {
      xx = lineEnd.dx;
      yy = lineEnd.dy;
    } else {
      xx = lineStart.dx + param * C;
      yy = lineStart.dy + param * D;
    }

    double dx = point.dx - xx;
    double dy = point.dy - yy;

    return sqrt(dx * dx + dy * dy);
  }

  static bool isDrawingCorrect(List<List<Offset?>> paths, Size size, String targetWord) {
    if (paths.isEmpty || paths[0].isEmpty) return false;

    // Her harf için bölge oluştur
    List<String> letters = targetWord.split('');
    List<Rect> letterRegions = [];

    for (int i = 0; i < letters.length; i++) {
      double startX = (i * size.width / letters.length);
      double endX = ((i + 1) * size.width / letters.length);
      letterRegions.add(Rect.fromLTWH(
        startX,
        size.height * 0.2,
        endX - startX,
        size.height * 0.6,
      ));
    }

    // Her çizgi parçasını kontrol et
    for (var path in paths) {
      for (int i = 0; i < path.length - 1; i++) {
        if (path[i] != null && path[i + 1] != null) {
          Offset start = path[i]!;
          Offset end = path[i + 1]!;

          // Çizginin hangi harf bölgesinde olduğunu kontrol et
          for (int j = 0; j < letterRegions.length; j++) {
            if (letterRegions[j].contains(start) && letterRegions[j].contains(end)) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  static Color getLineColor(Offset point, Size size, String targetWord) {
    List<String> letters = targetWord.split('');
    double threshold = 20.0;

    for (int i = 0; i < letters.length; i++) {
      double startX = (i * size.width / letters.length);
      double endX = ((i + 1) * size.width / letters.length);
      Rect region = Rect.fromLTWH(
        startX,
        size.height * 0.2,
        endX - startX,
        size.height * 0.6,
      );

      List<Offset> guideLines = getLetterGuideLines(letters[i], region);
      for (int j = 0; j < guideLines.length - 1; j += 2) {
        if (isNearLine(point, guideLines[j], guideLines[j + 1], threshold)) {
          return Colors.green.withOpacity(0.3);
        }
      }
    }

    return Colors.red.withOpacity(0.3);
  }
}