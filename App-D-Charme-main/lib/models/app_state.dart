import 'product.dart';
import 'rental.dart';
import 'store_user.dart';
import 'expense.dart'; 

class AppState {
  final String? user;
  final List<Product> products;
  final List<Rental> rentals;
  final List<StoreUser> users;
  final List<Expense> expenses; 

  const AppState({
    this.user,
    this.products = const [],
    this.rentals = const [],
    this.users = const [],
    this.expenses = const [], 
  });

  AppState copyWith({
    String? user,
    List<Product>? products,
    List<Rental>? rentals,
    List<StoreUser>? users,
    List<Expense>? expenses, 
  }) {
    return AppState(
      user: user ?? this.user,
      products: products ?? this.products,
      rentals: rentals ?? this.rentals,
      users: users ?? this.users,
      expenses: expenses ?? this.expenses, 
    );
  }
}