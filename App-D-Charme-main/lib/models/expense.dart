class Expense {
  final String id;
  final String description;
  final double value;
  final DateTime date;

  const Expense({
    required this.id,
    required this.description,
    required this.value,
    required this.date,
  });
}