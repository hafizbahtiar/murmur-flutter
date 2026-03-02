import '../models/product_review.dart';
import '../repositories/product_review_repository.dart';

class GetProductReviewsUseCase {
  final ProductReviewRepository _repository;

  const GetProductReviewsUseCase(this._repository);

  Future<List<ProductReview>> call(String productId) {
    return _repository.getProductReviews(productId);
  }
}
