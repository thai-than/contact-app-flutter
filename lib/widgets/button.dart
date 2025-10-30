import 'package:flutter/material.dart';

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
        return Colors.green.shade300;
      case 'danger':
        return Colors.red.shade300;
      case 'info':
      default:
        return const Color(0xFF67B6C4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}
