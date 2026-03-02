// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'd79fcb835935243dc78e7017460dfea133d98271';

@ProviderFor(orderUpdates)
final orderUpdatesProvider = OrderUpdatesProvider._();

final class OrderUpdatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationItem>>,
          List<NotificationItem>,
          FutureOr<List<NotificationItem>>
        >
    with
        $FutureModifier<List<NotificationItem>>,
        $FutureProvider<List<NotificationItem>> {
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
  $FutureProviderElement<List<NotificationItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationItem>> create(Ref ref) {
    return orderUpdates(ref);
  }
}

String _$orderUpdatesHash() => r'2d537bbd525403c8e361a3fd5fc0816b04ff1965';

@ProviderFor(notificationList)
final notificationListProvider = NotificationListFamily._();

final class NotificationListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationItem>>,
          List<NotificationItem>,
          FutureOr<List<NotificationItem>>
        >
    with
        $FutureModifier<List<NotificationItem>>,
        $FutureProvider<List<NotificationItem>> {
  NotificationListProvider._({
    required NotificationListFamily super.from,
    required NotificationType super.argument,
  }) : super(
         retry: null,
         name: r'notificationListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$notificationListHash();

  @override
  String toString() {
    return r'notificationListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<NotificationItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationItem>> create(Ref ref) {
    final argument = this.argument as NotificationType;
    return notificationList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$notificationListHash() => r'47f7f7933190e5fc7c81794351256674b74f2c50';

final class NotificationListFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<NotificationItem>>,
          NotificationType
        > {
  NotificationListFamily._()
    : super(
        retry: null,
        name: r'notificationListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NotificationListProvider call(NotificationType type) =>
      NotificationListProvider._(argument: type, from: this);

  @override
  String toString() => r'notificationListProvider';
}

@ProviderFor(totalUnreadCount)
final totalUnreadCountProvider = TotalUnreadCountProvider._();

final class TotalUnreadCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  TotalUnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalUnreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalUnreadCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalUnreadCount(ref);
  }
}

String _$totalUnreadCountHash() => r'd5b2084cfd4960a86160aa6e74074da34f65a3fb';
