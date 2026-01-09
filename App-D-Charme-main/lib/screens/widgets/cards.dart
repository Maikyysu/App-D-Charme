import 'package:flutter/material.dart';
import '../../config.dart';
import 'app_card.dart';

class HomeStatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const HomeStatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 32,
            color: AppConfig.primaryColor,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppConfig.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              // Corrigido: withOpacity → withValues
              color: AppConfig.textColor.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingRentalCard extends StatelessWidget {
  final String name;
  final String date;
  final String item;

  const UpcomingRentalCard({
    super.key,
    required this.name,
    required this.date,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConfig.primaryColor.withValues(alpha: 0.15),
            ),
            child: Icon(
              Icons.person,
              size: 30,
              color: AppConfig.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppConfig.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    
                    color: AppConfig.textColor.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    
                    color: AppConfig.textColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            
            color: AppConfig.textColor.withValues(alpha: 0.5),
            size: 26,
          ),
        ],
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final String color;
  final String size;
  final String imageUrl; 

  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.color,
    required this.size,
    this.imageUrl = '', 
  });

  Color _parseColor(String colorName) {
    switch (colorName.toLowerCase().trim()) {
      case 'azul': return Colors.blue;
      case 'vermelho': return Colors.red;
      case 'verde': return Colors.green;
      case 'preto': return Colors.black;
      case 'rosa': return Colors.pinkAccent;
      case 'roxo': return Colors.purple;
      case 'amarelo': return Colors.amber;
      default: return AppConfig.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.isNotEmpty && imageUrl.startsWith('http');
    final displayColor = _parseColor(color);

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          
          Container(
            width: 100,
            height: double.infinity,
            decoration: BoxDecoration(
              color: hasImage ? Colors.grey.shade100 : displayColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              image: hasImage
                  ? DecorationImage(
                      image: NetworkImage(imageUrl), 
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Center(
                    child: Icon(
                      Icons.checkroom,
                      size: 40,
                      color: displayColor,
                    ),
                  ),
          ),
          
          // LADO DIREITO: Informações
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      'Tam: $size',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}