import 'package:flutter/material.dart';
import 'package:sample_project/utils/constant.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String variant;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = 'info',
  });

  Color _getBackgroundColor() {
    switch (variant) {
      case 'success':
        return kSuccessColor;
      case 'danger':
        return kDangerColor;
      case 'info':
      default:
        return kPrimaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
