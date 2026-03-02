# Murmur

Flutter demo app using feature-first modules and Riverpod.

## Current architecture (diagnosis)

The project already has a strong base:

- Feature-first modules in `lib/features/*`.
- Domain models and repository contracts exist in most features.
- Data repositories implement those contracts.
- Presentation uses Riverpod providers/notifiers.

Current status:

- DI wiring is moved out of presentation providers.
- `product`, `live`, `notification`, and `cart` use explicit use-cases.
- `cart` now has complete `domain` + `data` layering.

## Target: simple SOLID architecture

Keep it minimal; do not over-engineer.

### Layer rules

- `presentation` depends on `domain` only (use-cases/contracts).
- `domain` contains pure business abstractions and logic.
- `data` implements domain contracts.
- DI/wiring binds interfaces to implementations.
- Repository contract methods use `get*` naming consistently.

Dependency direction:

`presentation -> domain <- data`

### Recommended feature structure

```text
lib/features/<feature>/
	data/
		repositories/
			<feature>_repository_impl.dart
	domain/
		models/
		repositories/
			<feature>_repository.dart
		usecases/
			get_<feature>_data.dart
	presentation/
		providers/
		screens/
		widgets/
	di/
		<feature>_di.dart
```

### Riverpod wiring guideline

- Repository implementation is provided in `di/`.
- Use-case providers depend on repository providers.
- UI providers/notifiers depend on use-case providers.
- Presentation providers avoid repository passthrough wrappers and call use-cases directly.
- Do not manually edit generated files (`*.g.dart`); regenerate with build_runner.

Avoid this in presentation:

- Importing `data/repositories/fake_*` directly.

### Concrete example (already implemented)

Use this as your reference pattern:

1. DI file provides concrete repository implementations:
	- `lib/features/product/di/product_di.dart`
	- `lib/features/live/di/live_di.dart`
	- `lib/features/notification/di/notification_di.dart`
  - `lib/features/cart/di/cart_di.dart`
2. Presentation provider reads from DI provider, not fake repository class directly:
	- `lib/features/product/presentation/providers/product_provider.dart`
	- `lib/features/product/presentation/providers/product_review_provider.dart`
	- `lib/features/live/presentation/providers/live_video_provider.dart`
	- `lib/features/notification/presentation/providers/notification_provider.dart`
  - `lib/features/cart/presentation/providers/cart_provider.dart`

Flow now:

`UI -> presentation provider -> domain repository type -> DI provider -> fake repository implementation`

This is the key idea of Dependency Inversion in this project.

### Product use-cases (already implemented)

`product` now includes explicit use-cases and providers call them directly:

- `lib/features/product/domain/usecases/get_products_use_case.dart`
- `lib/features/product/domain/usecases/get_product_detail_use_case.dart`
- `lib/features/product/domain/usecases/get_product_reviews_use_case.dart`

Updated flow for `product`:

`UI -> presentation provider -> use-case -> repository contract -> DI -> repository implementation`

### Live and Notification use-cases (already implemented)

`live` use-case:

- `lib/features/live/domain/usecases/get_live_videos_use_case.dart`

`notification` use-cases:

- `lib/features/notification/domain/usecases/get_notification_categories_use_case.dart`
- `lib/features/notification/domain/usecases/get_order_updates_use_case.dart`
- `lib/features/notification/domain/usecases/get_notifications_by_type_use_case.dart`
- `lib/features/notification/domain/usecases/get_total_unread_count_use_case.dart`

These features now follow the same flow as `product`:

`UI -> presentation provider -> use-case -> repository contract -> DI -> repository implementation`

### Cart use-cases and layering (already implemented)

`cart` now includes full layering and use-cases:

- `lib/features/cart/domain/repositories/cart_repository.dart`
- `lib/features/cart/data/repositories/in_memory_cart_repository.dart`
- `lib/features/cart/domain/usecases/*`
- `lib/features/cart/di/cart_di.dart`

`cart_provider` is now orchestration-only and delegates actions to use-cases.

## SOLID mapping for this codebase

- **S (Single Responsibility):**
	- Provider/notifier = state orchestration.
	- Use-case = one business action.
	- Repository = data access implementation.
- **O (Open/Closed):**
	- Add new data source by creating a new repository implementation without changing UI/domain contracts.
- **L (Liskov):**
	- Any repository implementation (`Fake`, API, local DB) must satisfy the same contract behavior.
- **I (Interface Segregation):**
	- Keep repository contracts focused and small.
- **D (Dependency Inversion):**
	- Presentation depends on abstractions (contracts/use-cases), not concrete repositories.

## Implementation roadmap

Follow the checklist in `TODO.md` in this order:

1. Move wiring from presentation to per-feature `di/`.
2. Add minimal use-cases for `product`, `notification`, `live`, and `cart`.
3. Complete `cart` repository contract + implementation.
4. Standardize naming and keep providers focused.

## New feature checklist

When adding a new feature:

1. Add domain model(s).
2. Add repository contract in `domain/repositories/`.
3. Add repository implementation in `data/repositories/`.
4. Add use-case(s) in `domain/usecases/`.
5. Add DI provider(s) in `di/`.
6. Add presentation provider/notifier using use-case(s).
7. Add UI screens/widgets.

## Useful commands

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```
