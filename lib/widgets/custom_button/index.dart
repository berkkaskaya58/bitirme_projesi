import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final double? fontSize;
  final VoidCallback? func;
  final VoidCallback? onIconTap; // 🔹 Yeni eklenen parametre

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.fontSize,
    this.func,
    this.onIconTap, // 🔹 Yeni parametreyi ekliyoruz
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color bgColor = backgroundColor ?? theme.colorScheme.primary;
    final Color fgColor = foregroundColor ?? theme.colorScheme.onPrimary;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        child: Stack(
          children: [
            // Ortalanmış metin
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize ?? 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Sol üst köşeye ikon
            if (icon != null)
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: onIconTap, // 🔹 İkon basılınca çalışacak fonksiyon
                  icon: Icon(icon),
                  color: fgColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}