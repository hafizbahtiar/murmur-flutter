import '../models/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUseCase {
  final ProductRepository _repository;

  const GetProductDetailUseCase(this._repository);

  Future<Product> call(String productId) {
    return _repository.getProductDetail(productId);
  }
}
