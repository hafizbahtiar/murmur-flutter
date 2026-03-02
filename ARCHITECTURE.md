# Murmur Architecture (Beginner Friendly)

This document explains the app architecture in simple words.

## 1) Big picture (easy version)

Think of the app like a restaurant:

- Presentation = waiter (UI, buttons, screens)
- Use case = order ticket (what action to do)
- Repository contract = promise/rule book (what data operations must exist)
- Data repository = kitchen (real implementation that returns data)
- DI = manager assigning the right kitchen

The waiter never cooks food.
In this app, UI never talks directly to fake/API data classes.

---

## 2) Data flow map

When user taps something:

UI Screen/Widget
-> Riverpod Provider/Notifier (presentation)
-> Use Case (domain)
-> Repository Contract (domain)
-> Repository Implementation (data)
-> Result back to UI

This keeps code clean and easy to replace later (for example Fake data to API).

---

## 3) Folder structure map

Main structure per feature:

lib/features/<feature>/
	presentation/
		screens/
		widgets/
		providers/
	domain/
		models/
		repositories/
		usecases/
	data/
		repositories/
	di/

Real features already using this pattern:

- product
- live
- notification
- cart

---

## 4) What each layer means

### presentation

What user sees and interacts with.

- screens: page UI
- widgets: reusable UI parts
- providers: state + call use cases

Rule: presentation should call use cases, not data repository classes directly.

### domain

Pure business logic.

- models: app entities (Product, CartItem, etc.)
- repositories: interfaces/contracts (what must be available)
- usecases: one class = one action (GetProducts, AddToCart, etc.)

Rule: domain should not depend on Flutter UI.

### data

Real implementation of repository contracts.

Example now: Fake repositories + in-memory cart repository.

Later you can swap to API/database without changing UI logic.

### di

Dependency Injection wiring.

This is where you connect:

- contract -> implementation
- use case -> contract

Rule: keep wiring here so other layers stay clean.

---

## 5) Why this architecture helps beginners

- Easier debugging: each class has one job
- Safer changes: you can change data source without breaking screens
- Easier teamwork: everyone knows where code should go
- Easier testing: use cases and repositories can be tested separately

---

## 6) Practical cheat sheet (where to put new code)

If you add a new feature:

1. Add model in domain/models
2. Add repository contract in domain/repositories
3. Add use case(s) in domain/usecases
4. Add repository implementation in data/repositories
5. Wire providers in di
6. Call use cases from presentation/providers
7. Build screen/widgets in presentation

---

## 7) Important rules

- Use get* naming for repository methods consistently
- Do not manually edit generated files (*.g.dart)
- Keep providers thin (orchestration only)
- Put business action flow in use case, not in UI widget
- Current status: cart rules are now in use-cases, and repository is storage-focused (get/save/clear)

---

## 8) Example mini map (cart)

Cart screen button click
-> CartNotifier (presentation provider)
-> AddToCartUseCase (domain)
-> CartRepository (domain contract)
-> InMemoryCartRepository (data implementation)
-> Updated cart items returned
-> UI redraw

That is the same pattern used in other features too.
