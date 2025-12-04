import 'package:flutter/material.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import '../config.dart';

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.rentalsTitle),
      body: const Center(
        child: Text('Tela de aluguéis'),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }
}
