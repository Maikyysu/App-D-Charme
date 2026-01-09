import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; //  o firebase de lei

import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/products.dart';
import 'screens/finance.dart';
import 'screens/rentals.dart';
import 'screens/users.dart';
import 'config.dart';

void main() async {
  // 1. inicializa o flutter aqui
  WidgetsFlutterBinding.ensureInitialized();

  // 2. firebase conecatdo
  await Firebase.initializeApp();

  // 3. e o app rodando suave
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.primaryColor),
        scaffoldBackgroundColor: AppConfig.backgroundColor,
        useMaterial3: true,
      ),
      // Começa pela Splash Screen (Animação)
      home: const SplashScreen(),
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