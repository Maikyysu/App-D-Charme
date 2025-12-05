import 'package:flutter/material.dart';
import '/config.dart';

class AddFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 16,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppConfig.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ],
          ),
          child: const Icon(
            Icons.add,
            size: 32,
            color: AppConfig.backgroundColor,
          ),
        ),
      ),
    );
  }
}
