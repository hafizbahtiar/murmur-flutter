// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productReviewRepository)
final productReviewRepositoryProvider = ProductReviewRepositoryProvider._();

final class ProductReviewRepositoryProvider
    extends
        $FunctionalProvider<
          ProductReviewRepository,
          ProductReviewRepository,
          ProductReviewRepository
        >
    with $Provider<ProductReviewRepository> {
  ProductReviewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productReviewRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productReviewRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductReviewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductReviewRepository create(Ref ref) {
    return productReviewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductReviewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductReviewRepository>(value),
    );
  }
}

String _$productReviewRepositoryHash() =>
    r'fc7cad9816f2b0b18e4bd62c2e01ccf59570fb8e';

@ProviderFor(productReviews)
final productReviewsProvider = ProductReviewsFamily._();

final class ProductReviewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductReview>>,
          List<ProductReview>,
          FutureOr<List<ProductReview>>
        >
    with
        $FutureModifier<List<ProductReview>>,
        $FutureProvider<List<ProductReview>> {
  ProductReviewsProvider._({
    required ProductReviewsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productReviewsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productReviewsHash();

  @override
  String toString() {
    return r'productReviewsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductReview>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductReview>> create(Ref ref) {
    final argument = this.argument as String;
    return productReviews(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductReviewsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productReviewsHash() => r'3d19bce291ce4b0741dc5413caf5196bed584297';

final class ProductReviewsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProductReview>>, String> {
  ProductReviewsFamily._()
    : super(
        retry: null,
        name: r'productReviewsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductReviewsProvider call(String productId) =>
      ProductReviewsProvider._(argument: productId, from: this);

  @override
  String toString() => r'productReviewsProvider';
}
