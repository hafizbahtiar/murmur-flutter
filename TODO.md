# Murmur — Simple SOLID Architecture TODO

Goal: keep the app feature-first and Riverpod-based, while introducing only the minimum structure needed to follow SOLID consistently.

## Progress snapshot

- [x] Product feature DI file added: `lib/features/product/di/product_di.dart`
- [x] Product presentation providers no longer import fake repositories directly
- [x] Live feature DI file added: `lib/features/live/di/live_di.dart`
- [x] Notification feature DI file added: `lib/features/notification/di/notification_di.dart`
- [x] Live + Notification presentation providers no longer import fake repositories directly
- [x] Product use-cases added and wired into providers (`GetProducts`, `GetProductDetail`, `GetProductReviews`)
- [x] Live use-case added and wired into provider (`GetLiveVideos`)
- [x] Notification use-cases added and wired into providers (`GetNotificationCategories`, `GetOrderUpdates`, `GetNotificationsByType`, `GetTotalUnreadCount`)
- [x] Cart repository, DI, and use-cases added and wired into provider

## 0) Current diagnosis (from codebase)

- [x] Feature-first folders exist (`product`, `live`, `notification`, `cart`, `profile`, `home`).
- [x] `domain` repository abstractions exist for `product`, `live`, and `notification`.
- [x] Data implementations (`Fake*Repository`) already implement domain contracts.
- [x] Riverpod providers expose async/state to UI.
- [x] `presentation/providers` directly imports fake data repositories (dependency direction issue).
- [x] `cart` has no `domain/repositories` contract and no `data` repository implementation.
- [x] Business actions are mostly called directly from providers/screens, no use-case layer.

---

## 1) Dependency Rule (highest priority)

- [x] Create a small per-feature DI file (for example: `lib/features/product/di/product_di.dart`).
- [x] Move concrete repository wiring from `presentation/providers/*` into DI files. (Product/Live/Notification/Cart done)
- [x] Make `presentation/providers/*` depend only on domain contracts and use-cases (not fake repos directly). (Product/Live/Notification/Cart done)

Definition of done:
- `presentation` no longer imports `data/repositories/fake_*`.

---

## 2) Add minimal Use Cases (Application layer)

For each feature, add simple use-case classes in `domain/usecases/`:

- [x] `product`: `GetProducts`, `GetProductDetail`, `GetProductReviews`.
- [x] `live`: `GetLiveVideos`.
- [x] `notification`: `GetNotificationCategories`, `GetOrderUpdates`, `GetNotificationsByType`, `GetTotalUnreadCount`.
- [x] `cart`: `AddToCart`, `RemoveFromCart`, `UpdateCartQuantity`, `ToggleCartSelection`, `GetCartTotal`.


Definition of done:
- Riverpod notifiers/providers call use-cases, not repositories directly.
## 3) Finish Cart layering

- [x] Add `lib/features/cart/domain/repositories/cart_repository.dart`.
- [x] Add `lib/features/cart/data/repositories/in_memory_cart_repository.dart`.
- [x] Move cart state operations from notifier internals into repository + use-cases.
- [x] Keep provider focused on state orchestration only.

Definition of done:
- `cart` has the same layer shape as other features (`data` → `domain` → `presentation`).

---

## 4) Interface Segregation and naming cleanup

- [x] Keep repository interfaces small and task-focused (split only when methods become unrelated).
- [x] Standardize names (`get*` vs `fetch*`) consistently across contracts/use-cases.
- [x] Ensure one responsibility per provider/notifier (avoid mixed concerns in one class).

Definition of done:
- Contracts and providers are easy to read and each has one clear purpose.

---

## 5) Shared architecture guardrails

- [x] Add a short architecture rule section in `README.md` (layer dependencies + naming).
- [x] Add a “new feature checklist” template in `README.md`.
- [x] Keep generated files (`*.g.dart`) out of manual edits.

Definition of done:
- Team has one documented way to add features.

---

## 6) Validation and incremental migration

- [x] Migrate one feature first (`product`) and verify behavior.
- [x] Migrate `notification` and `live` using the same DI pattern.
- [x] Migrate `cart` last after repository contract is added.
- [x] Run:
	- [x] `flutter pub run build_runner build --delete-conflicting-outputs`
	- [x] `flutter analyze`
	- [x] `flutter test`

Definition of done:
- No analyzer issues introduced and app behavior is unchanged.
