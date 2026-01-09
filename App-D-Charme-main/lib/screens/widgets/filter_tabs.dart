import 'package:flutter/material.dart';
import '/config.dart';

class GenericFilterTabs extends StatefulWidget {
  final List<String> items;
  final ValueChanged<int> onChanged;

  const GenericFilterTabs({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  State<GenericFilterTabs> createState() => _GenericFilterTabsState();
}

class _GenericFilterTabsState extends State<GenericFilterTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(
        widget.items.length,
        (index) => _buildButton(index),
      ),
    );
  }

  Widget _buildButton(int index) {
    final bool selected = index == selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: selected ? AppConfig.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: selected ? 8 : 5,
            offset: Offset(0, selected ? 4 : 2),
            color: Colors.black.withValues(alpha: selected ? 80 : 40),
          )
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: AppConfig.primaryColor.withValues(alpha: 80),
        highlightColor: Colors.grey.withValues(alpha: 50),
        onTap: () {
          setState(() => selectedIndex = index);
          widget.onChanged(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            widget.items[index],
            style: TextStyle(
              color: AppConfig.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
