import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_state.dart';
import '../models/product.dart';
import '../models/rental.dart';
import '../models/store_user.dart';
import '../models/expense.dart'; //  o import que serve pra depesas funcionar

class AppStateNotifier extends Notifier<AppState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  AppState build() {
    _listenToDatabase();
    return const AppState();
  }

  void _listenToDatabase() {
    
    _db.collection('products').snapshots().listen((snapshot) {
      final products = snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          docId: doc.id,
          id: data['id'] is int ? data['id'] : 0,
          name: data['name'] ?? '',
          category: data['category'] ?? '',
          color: data['color'] ?? '',
          size: data['size'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();
      state = state.copyWith(products: products);
    });

    //  aqui ouvi os usuarios, em cima ouver os produtos e o de baixo os alugués;
    _db.collection('users').snapshots().listen((snapshot) {
      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        return StoreUser(
          id: doc.id,
          name: data['name'] ?? '',
          phone: data['phone'] ?? '',
        );
      }).toList();
      state = state.copyWith(users: users);
    });

    
    _db.collection('rentals').snapshots().listen((snapshot) {
      final rentals = snapshot.docs.map((doc) {
        final data = doc.data();
        final start = data['startDate'] as Timestamp?;
        final end = data['endDate'] as Timestamp?;
        return Rental(
          id: doc.id,
          clientName: data['clientName'] ?? '',
          productName: data['productName'] ?? '',
          startDate: start?.toDate() ?? DateTime.now(),
          endDate: end?.toDate() ?? DateTime.now(),
          totalValue: (data['totalValue'] as num?)?.toDouble() ?? 0.0,
          paidValue: (data['paidValue'] as num?)?.toDouble() ?? 0.0,
          status: data['status'] ?? 'Pendente',
        );
      }).toList();
      state = state.copyWith(rentals: rentals);
    });

    //  e aqui pra ouvir depesas dos mestres
    _db.collection('expenses').snapshots().listen((snapshot) {
      final expensesList = snapshot.docs.map((doc) {
        final data = doc.data();
        return Expense(
          id: doc.id,
          description: data['description'] ?? '',
          value: (data['value'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
      // att do appstate pro copy aceita o expense
      state = state.copyWith(expenses: expensesList);
    });
  }

  
  Future<void> updateRentalStatus(String docId, String newStatus) async {
    try {
      await _db.collection('rentals').doc(docId).update({
        'status': newStatus,
      });
    } catch (e) {
      debugPrint("Erro ao atualizar status: $e");
    }
  }

  

  // depesas no Firebase
  Future<void> addExpense({
    required String description,
    required double value,
  }) async {
    try {
      await _db.collection('expenses').add({
        'description': description,
        'value': value,
        'date': Timestamp.now(),
      });
    } catch (e) {
      debugPrint("Erro ao adicionar despesa: $e");
    }
  }

  Future<void> addProduct({
    required String name,
    required String category,
    required String color,
    required String size,
    required String imageUrl,
  }) async {
    final int numericId = DateTime.now().millisecondsSinceEpoch;
    await _db.collection('products').add({
      'name': name,
      'category': category,
      'color': color,
      'size': size,
      'imageUrl': imageUrl,
      'id': numericId,
    });
  }

  Future<void> addStoreUser({required String name, required String phone}) async {
    await _db.collection('users').add({'name': name, 'phone': phone});
  }

  Future<void> addRental({
    required String clientName,
    required String productName,
    required DateTime startDate,
    required DateTime endDate,
    required double totalValue,
    required double paidValue,
  }) async {
    await _db.collection('rentals').add({
      'clientName': clientName,
      'productName': productName,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'totalValue': totalValue,
      'paidValue': paidValue,
      'status': 'Pendente',
    });
  }


  Future<void> editProduct({
    required String docId,
    required String name,
    required String category,
    required String color,
    required String size,
    required String imageUrl,
  }) async {
    await _db.collection('products').doc(docId).update({
      'name': name,
      'category': category,
      'color': color,
      'size': size,
      'imageUrl': imageUrl,
    });
  }

  Future<void> deleteProduct(String docId) async {
    await _db.collection('products').doc(docId).delete();
  }

  void setUser(String user) => state = state.copyWith(user: user);
  void logout() => state = state.copyWith(user: null);
}

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() => AppStateNotifier());