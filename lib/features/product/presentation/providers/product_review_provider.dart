import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/product_di.dart';
import '../../domain/models/product_review.dart';

part 'product_review_provider.g.dart';

@riverpod
Future<List<ProductReview>> productReviews(Ref ref, String productId) async {
  final getProductReviews = ref.watch(getProductReviewsUseCaseProvider);
  return getProductReviews(productId);
}
