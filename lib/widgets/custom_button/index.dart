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
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color bgColor = backgroundColor ?? theme.colorScheme.primary;
    final Color fgColor = foregroundColor ?? theme.colorScheme.onPrimary;

    return SizedBox(
      width: width,
      height: height,  // Buton yüksekliği
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(
            vertical: 6,  // Buton içinde yazı için biraz daha alan
            horizontal: 15,  // Buton içinde yazı için biraz daha alan
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: fontSize ?? 18),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize ?? 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}