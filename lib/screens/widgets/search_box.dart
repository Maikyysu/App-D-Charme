import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchBox({
    super.key,
    this.hintText = 'Buscar...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: 0.10),
          ),
        ],
      ),
      child: Row(
        children: [

          const Icon(Icons.search, color: Colors.grey),

          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Buscar...',
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
