import '../models/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<List<Product>> call() {
    return _repository.getProducts();
  }
}
