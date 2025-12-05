import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/buttons.dart';
import './widgets/accountability_wid.dart';
import '../config.dart';
import '../models/app_state_provider.dart';

class RentalsScreen extends ConsumerWidget {
  const RentalsScreen({super.key});

  void _openAddRental(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const SizedBox(
        height: 400,
        child: Center(child: Text('Formulário de novo aluguel aqui')),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appState = ref.watch(appStateProvider);
    final rentals = appState.rentals;

    double totalPaid = 0;
    double totalPending = 0;

    for (var rental in rentals) {
      totalPaid += rental.paidValue;
      totalPending += rental.pendingValue;
    }

    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.rentalsTitle),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                AccountabilityWidget(
                  leftTitle: 'Pago',
                  rightTitle: 'Pendente',
                  leftValue: totalPaid,
                  rightValue: totalPending,
                  leftIconType: IndicatorType.up,
                  rightIconType: IndicatorType.minus,
                ),

                const SizedBox(height: 24),

                if (rentals.isEmpty)
                  const Center(
                    child: Text(
                      'Nenhum aluguel cadastrado',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  ...rentals.map(
                    (rental) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(rental.clientName),
                        subtitle: Text(
                          'Peça: ${rental.productName} • Devolução: ${rental.endDate}',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'R\$ ${rental.totalValue.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              rental.pendingValue > 0
                                  ? 'Pendente'
                                  : 'Pago',
                              style: TextStyle(
                                fontSize: 12,
                                color: rental.pendingValue > 0
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: AddFloatingButton(
                onPressed: () => _openAddRental(context),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }
}
