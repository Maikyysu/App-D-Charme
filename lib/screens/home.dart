import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state_provider.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/cards.dart';
import '../config.dart';
import './widgets/search_box.dart';

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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SearchBox(),

            const SizedBox(height: 24),

            const Text(
              "Resumo rápido",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: HomeStatsCard(
                    label: "Aluguéis ativos",
                    value: "12",
                    icon: Icons.play_circle_fill,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: HomeStatsCard(
                    label: "Clientes",
                    value: "10",
                    icon: Icons.people,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: HomeStatsCard(
                    label: "Hoje",
                    value: "3",
                    icon: Icons.today,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: HomeStatsCard(
                    label: "Pendentes",
                    value: "2",
                    icon: Icons.error_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              "Próximos aluguéis",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            const UpcomingRentalCard(
              name: "João Silva",
              date: "10 Dez 2025",
              item: "Sapatos de Madeira",
            ),

            const SizedBox(height: 10),

            const UpcomingRentalCard(
              name: "Maria Costa",
              date: "11 Dez 2025",
              item: "Terno",
            ),

            const SizedBox(height: 10),

            const UpcomingRentalCard(
              name: "Carlos Souza",
              date: "12 Dez 2025",
              item: "Vestido Branco M",
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/rentals'),
                child: const Text(
                  "Ver todos",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
