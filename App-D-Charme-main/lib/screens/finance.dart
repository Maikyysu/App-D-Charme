import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/filter_tabs.dart';
import './widgets/filter_time.dart';
import './widgets/accountability_wid.dart';
import '../models/app_state_provider.dart';
import '../models/rental.dart';
import '../models/expense.dart'; 
import '../utils/sheets.dart'; 
import '../config.dart'; 
import '../models/theme_provider.dart'; 

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  ConsumerState<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen> {
  int selectedCategory = 0;
  DateTime selectedDate = DateTime.now();

  final List<String> categories = const [
    'Todos',
    'Aluguéis',
    'Vendas',
    'Despesas',
  ];

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    
   
    ref.watch(themeProvider); 

    
    final double totalRecebido = appState.rentals.fold(0.0, (double sum, Rental item) => sum + item.paidValue);
    final double totalAReceber = appState.rentals.fold(0.0, (double sum, Rental item) => sum + item.pendingValue);
    final double totalDespesas = appState.expenses.fold(0.0, (double sum, Expense item) => sum + item.value);

    return Scaffold(
      backgroundColor: AppConfig.backgroundColor, 
      
      appBar: const DefaultAppBar(title: AppConfig.financeTitle),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const SizedBox(height: 12),

           
           
            AccountabilityWidget(
              leftTitle: 'Total Recebido',
              rightTitle: 'Despesas Totais',
              leftValue: totalRecebido,
              rightValue: totalDespesas,
              leftIconType: IndicatorType.up,
              rightIconType: IndicatorType.down,
            ),

            const SizedBox(height: 20),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: AppConfig.primaryColor.withValues(alpha: 0.15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Progresso de Recebimento", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConfig.textColor 
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (totalRecebido + totalAReceber) > 0 
                              ? totalRecebido / (totalRecebido + totalAReceber) 
                              : 0,
                          backgroundColor: Colors.red.shade100,
                          color: Colors.green,
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Você já recebeu ${((totalRecebido / (totalRecebido + totalAReceber + 0.001)) * 100).toStringAsFixed(0)}% do valor total alugado.",
                        style: TextStyle(
                          fontSize: 12, 
                          color: AppConfig.textColor.withValues(alpha: 0.7)
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            
            
            MonthYearPicker(
              selectedDate: selectedDate,
              onChanged: (DateTime date) => setState(() => selectedDate = date),
            ),
            const SizedBox(height: 12),
            GenericFilterTabs(
              items: categories,
              onChanged: (int index) => setState(() => selectedCategory = index),
            ),

            const SizedBox(height: 24),
            
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Movimentações", 
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: AppConfig.textColor 
                  ),
                ),
              ),
            ),

           
            if (appState.rentals.isEmpty && appState.expenses.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "Nenhuma movimentação para este período.", 
                 
                  style: TextStyle(color: AppConfig.textColor.withValues(alpha: 0.5))
                ),
              )
            else ...[
              
              ...appState.rentals.map((Rental rental) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: rental.isPaid ? Colors.green.shade50 : Colors.orange.shade50,
                  child: Icon(rental.isPaid ? Icons.attach_money : Icons.priority_high, color: rental.isPaid ? Colors.green : Colors.orange),
                ),
                title: Text(
                  rental.clientName, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppConfig.textColor) 
                ),
                subtitle: Text(
                  "Aluguel: ${rental.productName}",
                  style: TextStyle(color: AppConfig.textColor.withValues(alpha: 0.7)) 
                ),
                trailing: Text("+ R\$ ${rental.paidValue.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              )),
              
              ...appState.expenses.map((Expense expense) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade50,
                  child: const Icon(Icons.remove, color: Colors.red),
                ),
                title: Text(
                  expense.description, 
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppConfig.textColor)
                ),
                subtitle: Text(
                  "Gasto em ${expense.date.day}/${expense.date.month}",
                  
                  style: TextStyle(color: AppConfig.textColor.withValues(alpha: 0.7))
                ),
                trailing: Text("- R\$ ${expense.value.toStringAsFixed(2)}", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              )),
            ],

            const SizedBox(height: 60),
          ],
        ),
      ),
      
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => const AddExpenseSheet(),
          );
        },
        label: Text("DESPESA", style: TextStyle(color: AppConfig.secondaryColor, fontWeight: FontWeight.bold)),
        icon: Icon(Icons.remove_circle_outline, color: AppConfig.secondaryColor),
        backgroundColor: AppConfig.primaryColor, 
      ),
      
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}