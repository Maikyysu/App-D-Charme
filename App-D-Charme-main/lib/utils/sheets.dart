import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config.dart';
import '../models/app_state_provider.dart';
import '../models/product.dart';

class AddProductSheet extends ConsumerStatefulWidget {
  final Product? productToEdit;
  const AddProductSheet({super.key, this.productToEdit});

  @override
  ConsumerState<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends ConsumerState<AddProductSheet> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final colorController = TextEditingController();
  final sizeController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.productToEdit != null) {
      final p = widget.productToEdit!;
      nameController.text = p.name;
      categoryController.text = p.category;
      colorController.text = p.color;
      sizeController.text = p.size;
      imageController.text = p.imageUrl;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    colorController.dispose();
    sizeController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.productToEdit != null;

    return _BaseSheet(
      title: isEditing ? 'Editar Peça' : 'Adicionar Peça',
      children: [
        _Input(label: 'Nome da peça', controller: nameController),
        _Input(label: 'Link da Foto (URL)', controller: imageController, icon: Icons.link),
        _Input(label: 'Categoria (Ex: Terno, Vestido)', controller: categoryController),
        _Input(label: 'Cor', controller: colorController),
        _Input(label: 'Tamanho', controller: sizeController),
        const SizedBox(height: 24),
        
        AnimatedSaveButton(
          label: isEditing ? 'SALVAR ALTERAÇÕES' : 'SALVAR PEÇA',
          onSave: () async {
            if (nameController.text.trim().isNotEmpty) {
              if (isEditing) {
                await ref.read(appStateProvider.notifier).editProduct(
                      docId: widget.productToEdit!.docId,
                      name: nameController.text.trim(),
                      category: categoryController.text.trim(),
                      color: colorController.text.trim(),
                      size: sizeController.text.trim(),
                      imageUrl: imageController.text.trim(),
                    );
              } else {
                await ref.read(appStateProvider.notifier).addProduct(
                      name: nameController.text.trim(),
                      category: categoryController.text.trim(),
                      color: colorController.text.trim(),
                      size: sizeController.text.trim(),
                      imageUrl: imageController.text.trim(),
                    );
              }
              return true;
            }
            return false; 
          },
        ),
      ],
    );
  }
}


class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({super.key});
  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final descController = TextEditingController();
  final valueController = TextEditingController();

  @override
  void dispose() {
    descController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseSheet(
      title: 'Nova Despesa',
      children: [
        _Input(label: 'O que foi pago?', controller: descController, icon: Icons.description),
        _Input(label: 'Valor (R\$)', controller: valueController, isNumber: true, icon: Icons.money_off),
        const SizedBox(height: 24),
        
        
        AnimatedSaveButton(
          label: 'CADASTRAR DESPESA',
          onSave: () async {
            final String desc = descController.text.trim();
            final double val = double.tryParse(valueController.text.replaceAll(',', '.')) ?? 0.0;

            if (desc.isNotEmpty && val > 0) {
              await ref.read(appStateProvider.notifier).addExpense(
                    description: desc,
                    value: val,
                  );
              return true; 
            }
            return false; 
          },
        ),
      ],
    );
  }
}


class ProductDetailsSheet extends ConsumerWidget {
  final Product product;
  const ProductDetailsSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BaseSheet(
      title: product.name,
      children: [
        if (product.imageUrl.isNotEmpty && product.imageUrl.startsWith('http'))
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                ),
              ),
            ),
          ),
        _InfoRow(label: 'Categoria', value: product.category),
        _InfoRow(label: 'Cor', value: product.color),
        _InfoRow(label: 'Tamanho', value: product.size),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(appStateProvider.notifier).deleteProduct(product.docId);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Excluir', style: TextStyle(color: Colors.red)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => AddProductSheet(productToEdit: product),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Editar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: AppConfig.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class AddUserSheet extends ConsumerStatefulWidget {
  const AddUserSheet({super.key});
  @override
  ConsumerState<AddUserSheet> createState() => _AddUserSheetState();
}

class _AddUserSheetState extends ConsumerState<AddUserSheet> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _BaseSheet(
      title: 'Novo Cliente',
      children: [
        _Input(label: 'Nome Completo', controller: nameController, icon: Icons.person),
        _Input(label: 'Telefone', controller: phoneController, icon: Icons.phone, isNumber: true),
        const SizedBox(height: 24),
        
        // BOTÃO COM ANIMAÇÃO
        AnimatedSaveButton(
          label: 'CADASTRAR CLIENTE',
          onSave: () async {
            if (nameController.text.trim().isNotEmpty) {
              await ref.read(appStateProvider.notifier).addStoreUser(
                    name: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                  );
              return true;
            }
            return false;
          },
        ),
      ],
    );
  }
}

// --- FORMULÁRIO DE ALUGUEL ---
class AddRentalSheet extends ConsumerStatefulWidget {
  const AddRentalSheet({super.key});
  @override
  ConsumerState<AddRentalSheet> createState() => _AddRentalSheetState();
}

class _AddRentalSheetState extends ConsumerState<AddRentalSheet> {
  String? selectedClient;
  String? selectedProduct;
  DateTime? startDate;
  DateTime? endDate;
  final valueController = TextEditingController();
  final paidController = TextEditingController(text: '0,00');

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => isStart ? startDate = picked : endDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    return _BaseSheet(
      title: 'Registrar Aluguel',
      children: [
        DropdownButtonFormField<String>(
          decoration: _inputDecoration('Quem é o cliente?'),
          initialValue: selectedClient, 
          items: appState.users.map((c) => DropdownMenuItem(value: c.name, child: Text(c.name))).toList(),
          onChanged: (v) => setState(() => selectedClient = v),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: _inputDecoration('Qual peça?'),
          initialValue: selectedProduct, 
          items: appState.products.map((p) => DropdownMenuItem(value: p.name, child: Text(p.name))).toList(),
          onChanged: (v) => setState(() => selectedProduct = v),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _pickDate(true),
                child: InputDecorator(
                  decoration: _inputDecoration('Retirada'),
                  child: Text(startDate == null ? 'dd/mm' : '${startDate!.day}/${startDate!.month}'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => _pickDate(false),
                child: InputDecorator(
                  decoration: _inputDecoration('Devolução'),
                  child: Text(endDate == null ? 'dd/mm' : '${endDate!.day}/${endDate!.month}'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _Input(label: 'Total (R\$)', controller: valueController, isNumber: true)),
            const SizedBox(width: 10),
            Expanded(child: _Input(label: 'Pago (R\$)', controller: paidController, isNumber: true)),
          ],
        ),
        const SizedBox(height: 24),
        
        AnimatedSaveButton(
          label: 'CONFIRMAR ALUGUEL',
          onSave: () async {
            if (selectedClient != null && selectedProduct != null && startDate != null && endDate != null) {
              await ref.read(appStateProvider.notifier).addRental(
                clientName: selectedClient!,
                productName: selectedProduct!,
                startDate: startDate!,
                endDate: endDate!,
                totalValue: double.tryParse(valueController.text.replaceAll(',', '.')) ?? 0.0,
                paidValue: double.tryParse(paidController.text.replaceAll(',', '.')) ?? 0.0,
              );
              return true; // Sucesso: Vira Verde e fecha
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos!')));
              return false; // Falha: Não anima
            }
          },
        ),
      ],
    );
  }
}


class _BaseSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _BaseSheet({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final bool isNumber;
  const _Input({required this.label, required this.controller, this.icon, this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: _inputDecoration(label, icon: icon),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

InputDecoration _inputDecoration(String label, {IconData? icon}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: icon != null ? Icon(icon) : null,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}


class AnimatedSaveButton extends StatefulWidget {
  final String label;
  final Future<bool> Function() onSave; 

  const AnimatedSaveButton({super.key, required this.label, required this.onSave});

  @override
  State<AnimatedSaveButton> createState() => _AnimatedSaveButtonState();
}

class _AnimatedSaveButtonState extends State<AnimatedSaveButton> {
  bool _isSuccess = false;
  bool _isLoading = false;

  void _handleTap() async {
    if (_isLoading || _isSuccess) return;

    setState(() => _isLoading = true);

   
    bool success = await widget.onSave();

    if (success) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

     
      await Future.delayed(const Duration(milliseconds: 1200));

      if (mounted) {
        Navigator.pop(context); // Fecha o BottomSheet
      }
    } else {
      // Se falhou (campos vazios), volta ao normal
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        // Se for sucesso, o botão encolhe para virar uma bolinha
        width: _isSuccess ? 50 : MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: _isSuccess ? Colors.green : AppConfig.primaryColor, // Amarelo -> Verde
          borderRadius: BorderRadius.circular(_isSuccess ? 50 : 18), // Retângulo -> Bola
        ),
        alignment: Alignment.center,
        child: _isLoading
            ? const SizedBox(
                width: 24, 
                height: 24, 
                child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
              )
            : _isSuccess
                ? const Icon(Icons.check, color: Colors.white, size: 30) 
                : Text(
                    widget.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
      ),
    );
  }
}