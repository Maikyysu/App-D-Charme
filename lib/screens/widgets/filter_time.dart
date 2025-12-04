import 'package:flutter/material.dart';
import '/config.dart';

class MonthYearPicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const MonthYearPicker({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  String _format(DateTime date) {
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _openPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _BottomPicker(
        selectedDate: selectedDate,
        onConfirm: (date) {
          onChanged(date);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black.withValues(alpha: 0.10),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              _format(selectedDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => _openPicker(context),
              child: Icon(
                Icons.calendar_month,
                color: AppConfig.primaryColor,
                size: 26,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* ===================== BOTTOM PICKER ===================== */

class _BottomPicker extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onConfirm;

  const _BottomPicker({
    required this.selectedDate,
    required this.onConfirm,
  });

  @override
  State<_BottomPicker> createState() => _BottomPickerState();
}

class _BottomPickerState extends State<_BottomPicker> {

  late int selectedMonth;
  late int selectedYear;

  final List<String> months = const [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedDate.month;
    selectedYear = widget.selectedDate.year;
  }

  @override
  Widget build(BuildContext context) {

    final List<int> years = List.generate(21, (i) {
      return DateTime.now().year - 10 + i;
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            'Selecione o período',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: selectedMonth,
                  decoration: const InputDecoration(
                    labelText: 'Mês',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(12, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text(months[index]),
                    );
                  }),
                  onChanged: (value) {
                    setState(() => selectedMonth = value!);
                  },
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: selectedYear,
                  decoration: const InputDecoration(
                    labelText: 'Ano',
                    border: OutlineInputBorder(),
                  ),
                  items: years.map((year) {
                    return DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedYear = value!);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.primaryColor,
                foregroundColor: AppConfig.backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () {
                widget.onConfirm(DateTime(selectedYear, selectedMonth));
                Navigator.pop(context);
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  fontSize: 16,
                  color: AppConfig.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
