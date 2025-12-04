import 'package:flutter/material.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import '../config.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.usersTitle),
      body: const Center(
        child: Text('Tela de usuários'),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 4),
    );
  }
}
