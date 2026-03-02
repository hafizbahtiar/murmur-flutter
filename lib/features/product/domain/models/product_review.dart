class ProductReview {
  final String id;
  final String productId;
  final String userName;
  final String userAvatarUrl;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> imageUrls;
  final String? variant;

  const ProductReview({
    required this.id,
    required this.productId,
    required this.userName,
    required this.userAvatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
    this.imageUrls = const [],
    this.variant,
  });
}
