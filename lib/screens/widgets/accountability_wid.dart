import 'package:flutter/material.dart';
import '/config.dart';

class AccountabilityWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final double leftValue;
  final double rightValue;

  const AccountabilityWidget({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftValue,
    required this.rightValue,
  });

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Widget _buildCard({
    required String title,
    required double value,
    required bool isProfit,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 3),
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // TÍTULO
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // VALOR + ÍCONE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  isProfit ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isProfit ? Colors.green : Colors.red,
                  size: 20,
                ),

                const SizedBox(width: 6),

                Text(
                  _formatCurrency(value),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [

          _buildCard(
            title: leftTitle,
            value: leftValue,
            isProfit: true,
          ),

          _buildCard(
            title: rightTitle,
            value: rightValue,
            isProfit: false,
          ),

        ],
      ),
    );
  }
}
