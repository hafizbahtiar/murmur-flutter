class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isPreferred;
  final List<String> images;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isPreferred = false,
    this.images = const [],
  });
}
