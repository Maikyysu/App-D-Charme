import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import '../../config.dart';
import '../../models/theme_provider.dart'; 

//aqui eu mudei pra consumer mestre
class AddFloatingButton extends ConsumerStatefulWidget {
  final VoidCallback onPressed;

  const AddFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  ConsumerState<AddFloatingButton> createState() => _AddFloatingButtonState();
}

class _AddFloatingButtonState extends ConsumerState<AddFloatingButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.85);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    Future.delayed(const Duration(milliseconds: 120), () {
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    // on tap pra mudar de cor
    ref.watch(themeProvider);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            // Usa a cor dinâmica do Config 
            color: AppConfig.primaryColor, 
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                // Sombra continua preta com transparência 
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ],
          ),
          child: Icon(
            Icons.add,
            size: 32,
            color: AppConfig.secondaryColor, 
          ),
        ),
      ),
    );
  }
}