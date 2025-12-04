import 'package:flutter/material.dart';

class AppConfig {
  // 🎯 IDENTIDADE DA LOJA
  static const String appName = "D'Charme";
  static const String slogan = 'Vestir para impressionar';
  static const String iconApp = 'assets/icon_1.png';



  // 🎨 CORES
  static const Color primaryColor = Color.fromRGBO(246, 239, 55, 1);
  static const Color secondaryColor = Color.fromARGB(255, 0, 0, 0);
  static const Color backgroundColor = Colors.white;

  // 🏷️ TÍTULOS DAS TELAS
  static const String homeTitle = 'Início';
  static const String productsTitle = 'Peças';
  static const String rentalsTitle = 'Aluguéis';
  static const String financeTitle = 'Contabilidade';
  static const String usersTitle = 'Clientes & Funcionários';

  // 🔘 TEXTOS
  static const String loginButtonText = 'Logar';
  static const String userFieldLabel = 'Usuário';
  static const String passwordFieldLabel = 'Senha';

  // 🧭 MENU (LABELS)
  static const String menuHome = 'Home';
  static const String menuProducts = 'Peças';
  static const String menuFinance = 'Contas';
  static const String menuRentals = 'Aluguéis';
  static const String menuUsers = 'Usuários';

  // 🧩 ÍCONES
  static const IconData iconHome = Icons.home;
  static const IconData iconProducts = Icons.checkroom;
  static const IconData iconFinance = Icons.attach_money;
  static const IconData iconRentals = Icons.calendar_today;
  static const IconData iconUsers = Icons.people;

  // 🖼️ FUTURO: LOGO
  static const String logoPath = 'assets/logo.png';
}
