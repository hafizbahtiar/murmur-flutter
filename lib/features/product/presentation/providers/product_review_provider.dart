import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/fake_product_review_repository.dart';
import '../../domain/models/product_review.dart';
import '../../domain/repositories/product_review_repository.dart';

part 'product_review_provider.g.dart';

@riverpod
ProductReviewRepository productReviewRepository(Ref ref) {
  return FakeProductReviewRepository();
}

@riverpod
Future<List<ProductReview>> productReviews(Ref ref, String productId) async {
  final repository = ref.watch(productReviewRepositoryProvider);
  return repository.getReviewsByProductId(productId);
}
