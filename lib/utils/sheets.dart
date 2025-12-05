import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../models/app_state_provider.dart';


class AddProductSheet extends ConsumerStatefulWidget {
  const AddProductSheet({super.key});

  @override
  ConsumerState<AddProductSheet> createState() => _AddProductSheetState();
}


class _AddProductSheetState extends ConsumerState<AddProductSheet> {


  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final colorController = TextEditingController();
  final sizeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    colorController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 24, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            const Text(
              'Adicionar peça',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 20),

            _input('Nome da peça', nameController),
            _input('Categoria', categoryController),
            _input('Cor', colorController),
            _input('Tamanho', sizeController),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {
                  final name = nameController.text.trim();
                  final category = categoryController.text.trim();
                  final color = colorController.text.trim();
                  final size = sizeController.text.trim();

                  if (name.isEmpty || category.isEmpty || color.isEmpty || size.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos')),
                    );
                    return;
                  }

                  ref.read(appStateProvider.notifier).addProduct(
                        name: name,
                        category: category,
                        color: color,
                        size: size,
                      );

                  Navigator.pop(context);
                },
                child: const Text('Salvar', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
