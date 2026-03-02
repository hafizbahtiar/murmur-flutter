import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../di/product_di.dart';
import '../../domain/models/product.dart';

part 'product_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<Product>> build() async {
    final getProducts = ref.watch(getProductsUseCaseProvider);
    return getProducts();
  }
}
