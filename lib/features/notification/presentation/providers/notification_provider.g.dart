// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'711848763ab964b9b6d2713e387efcfdbe74bc73';

@ProviderFor(notificationCategories)
final notificationCategoriesProvider = NotificationCategoriesProvider._();

final class NotificationCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationCategory>>,
          List<NotificationCategory>,
          FutureOr<List<NotificationCategory>>
        >
    with
        $FutureModifier<List<NotificationCategory>>,
        $FutureProvider<List<NotificationCategory>> {
  NotificationCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<NotificationCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationCategory>> create(Ref ref) {
    return notificationCategories(ref);
  }
}

String _$notificationCategoriesHash() =>
    r'4f912585b671f00e3c841226cafd259cfbd4ee50';

@ProviderFor(orderUpdates)
final orderUpdatesProvider = OrderUpdatesProvider._();

final class OrderUpdatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderUpdate>>,
          List<OrderUpdate>,
          FutureOr<List<OrderUpdate>>
        >
    with
        $FutureModifier<List<OrderUpdate>>,
        $FutureProvider<List<OrderUpdate>> {
  OrderUpdatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderUpdatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderUpdatesHash();

  @$internal
  @override
  $FutureProviderElement<List<OrderUpdate>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrderUpdate>> create(Ref ref) {
    return orderUpdates(ref);
  }
}

String _$orderUpdatesHash() => r'704df873c7ac1ac576e15d3e532cb2432bf1b287';
