import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/product_di.dart';
import '../../domain/models/product.dart';

part 'product_detail_provider.g.dart';

@riverpod
class ProductDetail extends _$ProductDetail {
  @override
  Future<Product> build(String productId) async {
    final getProductDetail = ref.watch(getProductDetailUseCaseProvider);
    return getProductDetail(productId);
  }
}
