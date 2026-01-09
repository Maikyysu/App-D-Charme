import 'package:flutter/material.dart';

class SlideFadeItem extends StatelessWidget {
  final Widget child;
  final int index; 

  const SlideFadeItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Calcula um atraso baseado no índice (ex: item 0 = 0ms, item 1 = 100ms...)
    final delay = index * 100; 

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + delay), 
      curve: Curves.easeOutQuad,
      builder: (context, value, child) {
        // Só começa a animar quando o "value" passa de um certo ponto relativo ao delay
        
        
        
        double opacity = value;
        double slide = 50 * (1 - value); // Começa 50px para baixo e sobe para 0

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, slide), // Movimento vertical
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}