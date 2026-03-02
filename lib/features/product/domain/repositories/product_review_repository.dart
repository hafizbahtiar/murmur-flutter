import '../models/product_review.dart';

abstract class ProductReviewRepository {
  Future<List<ProductReview>> getProductReviews(String productId);
}
