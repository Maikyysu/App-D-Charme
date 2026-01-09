import 'package:flutter/material.dart';
import '../../config.dart';

class AnimatedConfirmButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const AnimatedConfirmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<AnimatedConfirmButton> createState() => _AnimatedConfirmButtonState();
}

class _AnimatedConfirmButtonState extends State<AnimatedConfirmButton> {
  bool _isSuccess = false;

  void _triggerAnimation() async {
    // os tiros da animação pokerogue
    widget.onPressed();

    // muda pra sucesso
    setState(() => _isSuccess = true);

    // 3. pequeno delay pra mostra o check
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() => _isSuccess = false); // Reseta se necessário
      Navigator.pop(context); // Fecha a janelinha (Sheet)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isSuccess ? null : _triggerAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _isSuccess ? 60 : double.infinity, // Encolhe o botão
        height: 50,
        decoration: BoxDecoration(
          color: _isSuccess ? Colors.green : AppConfig.primaryColor, // Amarelo -> Verde
          borderRadius: BorderRadius.circular(_isSuccess ? 50 : 18), // Retângulo -> Bola
        ),
        alignment: Alignment.center,
        child: _isSuccess
            ? const Icon(Icons.check, color: Colors.white, size: 30) // Mostra o Check
            : Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto preto no amarelo
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}