import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state_provider.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import '../config.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
    appBar: DefaultAppBar(
      title: AppConfig.homeTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          tooltip: 'Sair',
          onPressed: () {
            ref.read(appStateProvider.notifier).logout();

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        ),
      ],
    ),

      body: Center(
        child: Text(
          AppConfig.slogan,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
