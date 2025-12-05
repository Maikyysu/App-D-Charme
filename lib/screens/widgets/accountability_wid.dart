import 'package:flutter/material.dart';

enum IndicatorType {
  up,
  down,
  minus,
}

class AccountabilityWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final double leftValue;
  final double rightValue;
  final IndicatorType leftIconType;
  final IndicatorType rightIconType;

  const AccountabilityWidget({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftValue,
    required this.rightValue,
    this.leftIconType = IndicatorType.up,
    this.rightIconType = IndicatorType.down,
  });

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  IconData _getIcon(IndicatorType type) {
    switch (type) {
      case IndicatorType.up:
        return Icons.arrow_upward;
      case IndicatorType.down:
        return Icons.arrow_downward;
      case IndicatorType.minus:
        return Icons.remove;
    }
  }

  Color _getColor(IndicatorType type) {
    switch (type) {
      case IndicatorType.up:
        return Colors.green;
      case IndicatorType.down:
        return Colors.red;
      case IndicatorType.minus:
        return Colors.orange;
    }
  }

  Widget _buildCard({
    required String title,
    required double value,
    required IndicatorType iconType,
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

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  _getIcon(iconType),
                  color: _getColor(iconType),
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
            iconType: leftIconType,
          ),

          _buildCard(
            title: rightTitle,
            value: rightValue,
            iconType: rightIconType,
          ),
        ],
      ),
    );
  }
}
