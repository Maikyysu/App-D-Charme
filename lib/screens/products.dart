import 'package:flutter/material.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import '../config.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.productsTitle),
      body: const Center(
        child: Text('Tela de peças'),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
