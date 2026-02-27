class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isPreferred;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isPreferred = false,
  });
}
