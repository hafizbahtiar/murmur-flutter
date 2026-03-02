import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/fake_product_repository.dart';
import '../data/repositories/fake_product_review_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/repositories/product_review_repository.dart';
import '../domain/usecases/get_product_detail_use_case.dart';
import '../domain/usecases/get_product_reviews_use_case.dart';
import '../domain/usecases/get_products_use_case.dart';

final productRepositoryDiProvider = Provider<ProductRepository>((ref) {
  return FakeProductRepository();
});

final productReviewRepositoryDiProvider = Provider<ProductReviewRepository>((ref) {
  return FakeProductReviewRepository();
});

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryDiProvider);
  return GetProductsUseCase(repository);
});

final getProductDetailUseCaseProvider = Provider<GetProductDetailUseCase>((ref) {
  final repository = ref.watch(productRepositoryDiProvider);
  return GetProductDetailUseCase(repository);
});

final getProductReviewsUseCaseProvider = Provider<GetProductReviewsUseCase>((ref) {
  final repository = ref.watch(productReviewRepositoryDiProvider);
  return GetProductReviewsUseCase(repository);
});
