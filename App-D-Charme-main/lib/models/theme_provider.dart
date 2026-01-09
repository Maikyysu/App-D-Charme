import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config.dart'; // Importa o Config para alterar as variáveis dele, ja que eu coloquei dinamimos nas mesmas

// guarda apenas "true" (Escuro) ou "false" (Claro)
class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false; // Começa no modo Claro(talvez eu mude o background também)
  }

  void toggleTheme() {
    state = !state; // Inverte: se era claro vira escuro, e vice-versa

    if (state == true) {
      // Aqui mestre eu Alterei as variáveis de cor do config 
      AppConfig.primaryColor = const Color(0xFFD4D42B); // Amarelo Escuro
      AppConfig.secondaryColor = Colors.white;
      AppConfig.backgroundColor = const Color(0xFF121212); // Preto
      AppConfig.textColor = Colors.white;
    } else {
      
      //  já no modo claro volta  monkahmmm 
      AppConfig.primaryColor = const Color.fromRGBO(246, 239, 55, 1);
      AppConfig.secondaryColor = Colors.black;
      AppConfig.backgroundColor = Colors.white;
      AppConfig.textColor = Colors.black;
    }
  }
}

// aqui é so pra avisar a tela que o config mudou "
final themeProvider = NotifierProvider<ThemeNotifier, bool>(() => ThemeNotifier());