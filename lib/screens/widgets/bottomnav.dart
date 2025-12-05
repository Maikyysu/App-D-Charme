import 'package:flutter/material.dart';
import '/config.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int? flashingIndex;

  final routes = [
    '/home',
    '/products',
    '/finance',
    '/rentals',
    '/users',
  ];

  void navigate(int index) async {
    if (index == widget.currentIndex) return;

    setState(() => flashingIndex = index);

    await Future.delayed(const Duration(milliseconds: 180));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, routes[index]);
  }

  Color _getColor(int index) {
    if (index == flashingIndex) {
      return AppConfig.primaryColor;
    }

    if (index == widget.currentIndex) {
      return AppConfig.secondaryColor;
    }

    return Colors.grey;
  }

  BottomNavigationBarItem buildItem(
    IconData icon,
    String label,
    int index,
  ) {
    final color = _getColor(index);

    return BottomNavigationBarItem(
      icon: Icon(icon, color: color),
      label: label,
      tooltip: label,

      backgroundColor: Colors.transparent,
    );
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: navigate,
      showUnselectedLabels: true,

      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: TextStyle(
        color: AppConfig.secondaryColor,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
      ),

      items: [
        buildItem(AppConfig.iconHome, AppConfig.menuHome, 0),
        buildItem(AppConfig.iconProducts, AppConfig.menuProducts, 1),
        buildItem(AppConfig.iconFinance, AppConfig.menuFinance, 2),
        buildItem(AppConfig.iconRentals, AppConfig.menuRentals, 3),
        buildItem(AppConfig.iconUsers, AppConfig.menuUsers, 4),
      ],
    );
  }
}
