import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/products.dart';
import 'screens/finance.dart';
import 'screens/rentals.dart';
import 'screens/users.dart';

import 'config.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 190, 134, 3),
        ),
        scaffoldBackgroundColor: AppConfig.backgroundColor,
        useMaterial3: true,
      ),
      home: const LoginScreen(), // tela inicial
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) => const ProductsScreen(),
        '/finance': (context) => const FinanceScreen(),
        '/rentals': (context) => const RentalsScreen(),
        '/users': (context) => const UsersScreen(),
            },
    );
  }
}
