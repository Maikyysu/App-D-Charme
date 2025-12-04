import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    return const AppState();
  }

  void setUser(String user) {
    state = state.copyWith(user: user);
  }

  void logout() {
    state = const AppState();
  }
}

final appStateProvider =
    NotifierProvider<AppStateNotifier, AppState>(() => AppStateNotifier());
