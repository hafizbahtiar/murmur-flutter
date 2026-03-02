import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/fake_product_repository.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_provider.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return FakeProductRepository();
}

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<Product>> build() async {
    final repo = ref.watch(productRepositoryProvider);
    return repo.fetchProducts();
  }
}
