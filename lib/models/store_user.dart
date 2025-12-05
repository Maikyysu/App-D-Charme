class StoreUser {
  final String id;
  final String name;
  final String phone;

  const StoreUser({
    required this.id,
    required this.name,
    required this.phone,
  });

  StoreUser copyWith({
    String? id,
    String? name,
    String? phone,
  }) {
    return StoreUser(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
