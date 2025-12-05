import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './widgets/bottomnav.dart';
import './widgets/appbardefault.dart';
import './widgets/buttons.dart';
import './widgets/search_box.dart';
import '../models/app_state_provider.dart';
import '../config.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  void _openAddUser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const SizedBox(
        height: 300,
        child: Center(child: Text('Formulário de novo usuário aqui')),
      ),
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
            const SearchBox(
              hintText: 'Buscar usuário...',
            ),

            const SizedBox(height: 20),

            if (users.isEmpty)
              const Center(
                child: Text(
                  'Nenhum usuário cadastrado',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...users.map(
                (user) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.phone),
                    trailing: const Icon(Icons.more_vert),
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
