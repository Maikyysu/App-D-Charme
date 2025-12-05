import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state.dart';
import '../models/product.dart';
import '../models/rental.dart';
import '../models/store_user.dart';

class AppStateNotifier extends Notifier<AppState> {

  int _productId = 0;
  int _rentalId = 0;
  int _userId = 0;

  @override
  AppState build() {
    return const AppState();
  }

  void setUser(String user) {
    state = state.copyWith(user: user);
  }

  void logout() {
    state = const AppState();
    _productId = 0;
    _rentalId = 0;
    _userId = 0;
  }

  void addProduct({
    required String name,
    required String category,
    required String color,
    required String size,
  }) {
    final newProduct = Product(
      id: _productId++,
      name: name,
      category: category,
      color: color,
      size: size,
    );

    state = state.copyWith(
      products: [...state.products, newProduct],
    );
  }

  void removeProduct(int id) {
    state = state.copyWith(
      products: state.products.where((p) => p.id != id).toList(),
    );
  }

  void addRental({
    required String clientName,
    required String productName,
    required DateTime startDate,
    required DateTime endDate,
    required double totalValue,
    required double paidValue,
  }) {
    final newRental = Rental(
      id: _rentalId.toString(),
      clientName: clientName,
      productName: productName,
      startDate: startDate,
      endDate: endDate,
      totalValue: totalValue,
      paidValue: paidValue,
    );

    _rentalId++;

    state = state.copyWith(
      rentals: [...state.rentals, newRental],
    );
  }

  void updateRental(Rental updated) {
    final updatedList = state.rentals.map((r) {
      return r.id == updated.id ? updated : r;
    }).toList();

    state = state.copyWith(rentals: updatedList);
  }

  void removeRental(String id) {
    state = state.copyWith(
      rentals: state.rentals.where((r) => r.id != id).toList(),
    );
  }

  void addPayment(String rentalId, double value) {
    final rental = state.rentals.firstWhere((r) => r.id == rentalId);

    final updatedRental = rental.copyWith(
      paidValue: rental.paidValue + value,
    );

    updateRental(updatedRental);
  }

  void addStoreUser({
    required String name,
    required String phone,
  }) {
    final newUser = StoreUser(
      id: _userId.toString(),
      name: name,
      phone: phone,
    );

    _userId++;

    state = state.copyWith(
      users: [...state.users, newUser],
    );
  }

  void removeStoreUser(String id) {
    state = state.copyWith(
      users: state.users.where((u) => u.id != id).toList(),
    );
  }
}

final appStateProvider =
    NotifierProvider<AppStateNotifier, AppState>(() => AppStateNotifier());
