import 'product.dart';
import 'rental.dart';
import 'store_user.dart';

class AppState {
  final String? user;
  final List<Product> products;
  final List<Rental> rentals;
  final List<StoreUser> users;

  const AppState({
    this.user,
    this.products = const [],
    this.rentals = const [],
    this.users = const [],
  });

  AppState copyWith({
    String? user,
    List<Product>? products,
    List<Rental>? rentals,
    List<StoreUser>? users,
  }) {
    return AppState(
      user: user ?? this.user,
      products: products ?? this.products,
      rentals: rentals ?? this.rentals,
      users: users ?? this.users,
    );
  }
}
