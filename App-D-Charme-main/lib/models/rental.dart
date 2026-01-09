class Rental {
  final String id;
  final String clientName;
  final String productName;
  final DateTime startDate;
  final DateTime endDate;
  final double totalValue;
  final double paidValue;
  final String status; 

  const Rental({
    required this.id,
    required this.clientName,
    required this.productName,
    required this.startDate,
    required this.endDate,
    required this.totalValue,
    required this.paidValue,
    this.status = 'Pendente', 
  });

  double get pendingValue => totalValue - paidValue;
  bool get isPaid => pendingValue <= 0;

  Rental copyWith({
    String? id,
    String? clientName,
    String? productName,
    DateTime? startDate,
    DateTime? endDate,
    double? totalValue,
    double? paidValue,
    String? status, 
  }) {
    return Rental(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      productName: productName ?? this.productName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalValue: totalValue ?? this.totalValue,
      paidValue: paidValue ?? this.paidValue,
      status: status ?? this.status, 
    );
  }
}