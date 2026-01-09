import 'package:flutter/material.dart';

class AppConfig {
  
  static const String appName = "D'Charme";
  static const String slogan = 'Vestir para impressionar';
  static const String iconApp = 'assets/icon_1.png';

  
  static const double fontSizeTitle = 26.0;
  static const double fontSizeSubtitle = 14.0;
  static const double fontSizeBody = 16.0;
  
  // mestre aqui eu removi o const e coloquei o textcolor
  
  
  static Color primaryColor = const Color.fromRGBO(246, 239, 55, 1);
  static Color secondaryColor = const Color.fromARGB(255, 0, 0, 0);
  static Color backgroundColor = Colors.white;
  static Color textColor = Colors.black;

  
 
  static const String homeTitle = 'Início';
  static const String productsTitle = 'Peças';
  static const String rentalsTitle = 'Aluguéis';
  static const String financeTitle = 'Contabilidade';
  static const String usersTitle = 'Clientes';

  
  static const String loginButtonText = 'Logar';
  static const String userFieldLabel = 'Usuário';
  static const String passwordFieldLabel = 'Senha';

  
  static const String menuHome = 'Home';
  static const String menuProducts = 'Peças';
  static const String menuFinance = 'Contas';
  static const String menuRentals = 'Aluguéis';
  static const String menuUsers = 'Usuários';

  // Ícones da navbar
  static const IconData iconHome = Icons.home;
  static const IconData iconProducts = Icons.checkroom;
  static const IconData iconFinance = Icons.attach_money;
  static const IconData iconRentals = Icons.calendar_today;
  static const IconData iconUsers = Icons.people;

 
  static const String logoPath = 'assets/logo.png';
}