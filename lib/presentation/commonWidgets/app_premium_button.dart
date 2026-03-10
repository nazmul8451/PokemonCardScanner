import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPremiumButton extends StatelessWidget {
  const AppPremiumButton({
    super.key,
    required this.onTap,
    required this.label,
    this.width,
    this.height,
    this.icon,
    this.fontSize,
  });

  final VoidCallback onTap;
  final String label;
  final double? width;
  final double? height;
  final Widget? icon;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r), // Pill shape
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFD740), // Brighter gold/yellow
              Color(0xFFFFB300), // Deep amber/gold
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFB300).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, SizedBox(width: 10.w)],
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize ?? 17.sp,
                  letterSpacing: 0.1,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
