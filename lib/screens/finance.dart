import 'package:flutter/material.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/filter_tabs.dart';
import './widgets/filter_time.dart';
import './widgets/accountability_wid.dart';
import '../config.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {

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
    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.financeTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            
            const SizedBox(height: 12),

            AccountabilityWidget(
              leftTitle: 'Lucro',
              rightTitle: 'Despesas',
              leftValue: 0,
              rightValue: 0,
              leftIconType: IndicatorType.up,
              rightIconType: IndicatorType.down,
            ),

            const SizedBox(height: 12),

            MonthYearPicker(
              selectedDate: selectedDate,
              onChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 12),

            GenericFilterTabs(
              items: categories,
              onChanged: (index) {
                setState(() {
                  selectedCategory = index;
                });
              },
            ),

            const SizedBox(height: 60),

            Center(
              child: Text(
                'Período: ${selectedDate.month}/${selectedDate.year}\nCategoria: ${categories[selectedCategory]}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
