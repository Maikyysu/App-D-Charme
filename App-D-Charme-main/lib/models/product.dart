class Product {
  final String docId; // <--- O ID SECRETO DO FIREBASE
  final int id;
  final String name;
  final String category;
  final String color;
  final String size;
  final String imageUrl;

  Product({
    this.docId = '', // Padrão vazio
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.size,
    this.imageUrl = '',
  });
}