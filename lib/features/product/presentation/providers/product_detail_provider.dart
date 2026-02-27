import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/product.dart';
import 'product_provider.dart';

part 'product_detail_provider.g.dart';

@riverpod
class ProductDetail extends _$ProductDetail {
  @override
  Future<Product> build(String productId) async {
    final repo = ref.watch(productRepositoryProvider);
    return repo.fetchProductDetail(productId);
  }
}
