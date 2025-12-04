class AppState {
  final String? user;

  const AppState({this.user});

  AppState copyWith({String? user}) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
