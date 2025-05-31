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
  final VoidCallback? onIconTap;

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
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? const Color.fromARGB(255, 62, 86, 109);
    final Color fgColor = foregroundColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize ?? 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (icon != null)
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: onIconTap,
                  icon: Icon(icon),
                  color: fgColor,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}