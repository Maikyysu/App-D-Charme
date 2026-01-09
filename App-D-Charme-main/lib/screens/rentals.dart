import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/buttons.dart';
import './widgets/filter_tabs.dart';
import '../config.dart';
import '../models/app_state_provider.dart';
import '../utils/sheets.dart';
import '../models/rental.dart';

class RentalsScreen extends ConsumerStatefulWidget {
  const RentalsScreen({super.key});

  @override
  ConsumerState<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends ConsumerState<RentalsScreen> {
  int selectedFilter = 0;
  final List<String> logisticFilters = [
    'Todos', 
    'Para Entregar', 
    'Em Uso', 
    'Lavanderia'
  ];

  void _openAddRental(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => const AddRentalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final DateTime hoje = DateTime.now(); // Tipagem para evitar avisos

   
    List<Rental> filteredRentals = appState.rentals;

    if (selectedFilter == 1) {
      filteredRentals = filteredRentals.where((Rental r) => 
        r.startDate.day == hoje.day && 
        r.startDate.month == hoje.month &&
        r.status == 'Pendente'
      ).toList();
    } else if (selectedFilter == 2) {
      filteredRentals = filteredRentals.where((Rental r) => r.status == 'Em Uso').toList();
    } else if (selectedFilter == 3) {
      filteredRentals = filteredRentals.where((Rental r) => r.status == 'Lavanderia').toList();
    }

    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.rentalsTitle),
      body: Column(
        children: [
          const SizedBox(height: 12),
          GenericFilterTabs(
            items: logisticFilters,
            onChanged: (int index) => setState(() => selectedFilter = index),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  if (filteredRentals.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('Nenhum item encontrado', style: TextStyle(color: Colors.grey)),
                      ),
                    )
                  else
                    ...filteredRentals.map((Rental rental) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(rental.clientName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('📦 Peça: ${rental.productName}'),
                                Text('📅 Volta: ${rental.endDate.day}/${rental.endDate.month}/${rental.endDate.year}'),
                                const SizedBox(height: 4),
                                _statusBadge(rental.status),
                              ],
                            ),
                            trailing: _buildActionButton(rental),
                          ),
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AddFloatingButton(onPressed: () => _openAddRental(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.grey;
    if (status == 'Em Uso') color = Colors.blue;
    if (status == 'Lavanderia') color = Colors.purple;
    if (status == 'Pendente') color = Colors.orange;
    if (status == 'Finalizado') color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActionButton(Rental rental) {
    String label = "OK";
    Color color = Colors.green;

    if (rental.status == 'Pendente') {
      label = "ENTREGAR";
      color = Colors.blue;
    } else if (rental.status == 'Em Uso') {
      label = "RECEBER";
      color = Colors.orange;
    } else if (rental.status == 'Lavanderia') {
      label = "LIMPO";
      color = Colors.purple;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _handleStatusChange(rental),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  void _handleStatusChange(Rental rental) {
    String nextStatus = 'Finalizado';
    if (rental.status == 'Pendente') {
      nextStatus = 'Em Uso';
    } else if (rental.status == 'Em Uso') {
      nextStatus = 'Lavanderia';
    } else if (rental.status == 'Lavanderia') {
      nextStatus = 'Finalizado';
    }

    ref.read(appStateProvider.notifier).updateRentalStatus(rental.id, nextStatus);
  }
}