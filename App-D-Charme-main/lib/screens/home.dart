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
    // 1. Obtém o estado atual que vem do Firebase através do Notifier
    final appState = ref.watch(appStateProvider);

    // 2. Calcula os valores reais baseados nas listas do banco de dados
    final totalAlugueis = appState.rentals.length.toString();
    final totalClientes = appState.users.length.toString();

    // Filtra os aluguéis que começam hoje
    final hoje = DateTime.now();
    final totalHoje = appState.rentals.where((r) => 
      r.startDate.day == hoje.day && 
      r.startDate.month == hoje.month &&
      r.startDate.year == hoje.year
    ).length.toString();

    // Filtra os aluguéis pedentes 
    final totalPendentes = appState.rentals.where((r) => r.pendingValue > 0).length.toString();

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
              children: [
                Expanded(
                  child: HomeStatsCard(
                    label: "Aluguéis ativos",
                    value: totalAlugueis, 
                    icon: Icons.play_circle_fill,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: HomeStatsCard(
                    label: "Clientes",
                    value: totalClientes, 
                    icon: Icons.people,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeStatsCard(
                    label: "Hoje",
                    value: totalHoje, 
                    icon: Icons.today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: HomeStatsCard(
                    label: "Pendentes",
                    value: totalPendentes, 
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

            // listinha dinamica de alugueis
            if (appState.rentals.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Nenhum aluguel registado.", style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              ...appState.rentals.take(3).map((rental) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: UpcomingRentalCard(
                  name: rental.clientName,
                  date: "${rental.endDate.day}/${rental.endDate.month}/${rental.endDate.year}",
                  item: rental.productName,
                ),
              )),

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