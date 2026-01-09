import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/buttons.dart';
import './widgets/search_box.dart';
import '../models/app_state_provider.dart';
import '../config.dart';
import '../utils/sheets.dart'; // Importante para achar o AddUserSheet

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  void _openAddUser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddUserSheet(), 
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final users = appState.users;

    return Scaffold(
      appBar: const DefaultAppBar(title: AppConfig.usersTitle),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchBox(hintText: 'Buscar cliente...'),
            const SizedBox(height: 20),

            if (users.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Nenhum cliente cadastrado',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ...users.map(
                (user) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConfig.primaryColor.withValues(alpha: 0.2),
                      child: const Icon(Icons.person, color: Colors.black87),
                    ),
                    title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(user.phone),
                    trailing: const Icon(Icons.phone, color: Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: AddFloatingButton(
        onPressed: () => _openAddUser(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: const BottomNav(currentIndex: 4),
    );
  }
}