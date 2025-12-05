import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/buttons.dart';
import '../utils/sheets.dart';
import '../config.dart';
import '../models/app_state_provider.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  void _openAddProduct(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddProductSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appState = ref.watch(appStateProvider);
    final products = appState.products;

    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.productsTitle),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 20),

                if (products.isEmpty)
                  const Center(
                    child: Text(
                      'Nenhuma peça cadastrada ainda',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  ...products.map((product) => ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          '${product.category} • ${product.color} • ${product.size}',
                        ),
                      )),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: AddFloatingButton(
                onPressed: () => _openAddProduct(context),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
