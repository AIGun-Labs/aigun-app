# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AIGun is an AI automated trading platform built with Flutter that supports EVM, Solana (SVM), and blockchain interactions. The app provides token tracking, trading, monitoring, and wallet management features.

**Tech Stack:**
- Flutter 3.0+
- Bloc/Cubit for state management
- GoRouter for navigation
- Dio for HTTP requests
- Web3dart (EVM), Solana_web3 (SVM) for blockchain
- Freezed for immutable models
- GetIt for dependency injection

## Development Commands

### Running the App
```bash
# Default development environment
flutter run

# Specific development environment
flutter run --dart-define=ENV=development1  # 192.168.4.55
flutter run --dart-define=ENV=development2  # 192.168.4.67
```

### Code Generation
```bash
# Generate freezed models (watch mode)
dart run build_runner watch

# Generate freezed models (one-time)
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

### Linting and Analysis
```bash
flutter analyze
```

### Building
```bash
# Build production APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## Architecture

**IMPORTANT**: The codebase is migrating from a traditional screen-based architecture to **Clean Architecture with feature modules**. New features should be implemented in `lib/features/` following the Clean Architecture pattern. Legacy code in `lib/screens/` will be gradually migrated.

### Directory Structure

```
lib/
├── features/                      # 📦 Feature modules (Clean Architecture) - NEW ARCHITECTURE
│   ├── trending/                  # Example: Hot tokens feature
│   │   ├── domain/               # Business logic layer (framework-independent)
│   │   │   ├── entities/         # Business entities
│   │   │   ├── repositories/     # Repository interfaces (abstractions)
│   │   │   └── usecases/         # Business use cases
│   │   ├── data/                 # Data layer (implements domain contracts)
│   │   │   ├── models/           # Data models (DTOs) with Freezed
│   │   │   ├── repositories/     # Repository implementations
│   │   │   └── sources/          # Data sources (remote/local)
│   │   └── presentation/         # Presentation layer (UI)
│   │       ├── pages/            # Screen widgets
│   │       ├── widgets/          # Feature-specific widgets
│   │       └── cubits/           # Feature cubits
│   ├── bonus/                     # Invite & claim tokens feature
│   ├── update/                    # App update feature
│   ├── ai_agent/                  # AI agent feature
│   └── home/                      # Home screen feature
│
├── core/                          # Core framework & cross-cutting concerns
│   ├── di/                       # Dependency injection
│   │   ├── injection_container.dart  # DI initialization
│   │   ├── module_repo.dart      # InjectionModule interface
│   │   └── modules/              # Feature DI modules (e.g., trending_module.dart)
│   ├── router/                   # GoRouter configuration
│   ├── service_locator.dart      # GetIt setup (legacy, transitioning to DI modules)
│   ├── api_locator.dart          # Legacy API registration
│   └── cubit_locator.dart        # Legacy cubit registration
│
├── screens/                       # 📱 Legacy screens (being migrated to features/)
├── cubits/                        # 🔄 Global state (auth, wallet, theme, language)
├── widgets/                       # 🧩 Shared UI components
├── shared/                        # Shared utilities & widgets
│   ├── custom_refresh/           # Custom refresh components
│   ├── utils/                    # Shared utility functions
│   └── widgets/                  # Shared widget components
├── data/                          # Legacy global data layer
│   ├── models/                   # Global data models
│   └── services/                 # API, HTTP, WebSocket services
├── services/                      # Platform services (analytics, network)
├── utils/                         # Utilities, validators, formatters, storage
├── themes/                        # App theming
├── config/                        # Environment & configuration
├── l10n/                          # Internationalization (*.arb files)
└── presentation/                  # Shared presentation utilities
```

### Clean Architecture Pattern (Features)

**Dependency Flow**: `Presentation → Domain ← Data`

```
Presentation Layer (UI)
    ↓ (depends on)
Domain Layer (Business Logic - Pure Dart, no Flutter)
    ↑ (implemented by)
Data Layer (Data Sources & Repositories)
```

**Layer Responsibilities**:

1. **Domain Layer** (`domain/`):
   - **Entities**: Core business models (immutable with Freezed)
   - **Repositories**: Abstract interfaces defining data operations
   - **UseCases**: Single-responsibility business logic units
   - Must be framework-independent (no Flutter dependencies)

2. **Data Layer** (`data/`):
   - **Models**: DTOs with JSON serialization (`*.freezed.dart`, `*.g.dart`)
   - **Repositories**: Concrete implementations of domain repositories
   - **Sources**: Remote (API) and local (storage) data sources
   - **Mappers**: Convert between models and entities (optional)

3. **Presentation Layer** (`presentation/`):
   - **Pages**: Screen-level widgets
   - **Widgets**: Feature-specific UI components
   - **Cubits**: State management (depends on UseCases)

### Dependency Injection (Clean Architecture)

New features use modular DI in `lib/core/di/modules/`:

```dart
// Example: lib/core/di/modules/trending_module.dart
class TrendingModule implements InjectionModule {
  final GetIt _sl;

  @override
  Future<void> init() async {
    // Register data sources
    _sl.registerLazySingleton<HotTokenRemoteSource>(
      () => HotTokenRemoteSource(_sl<DioClient>()),
    );

    // Register repositories
    _sl.registerLazySingleton<HotTokenRepository>(
      () => HotTokenRepositoryImpl(_sl<HotTokenRemoteSource>()),
    );

    // Register use cases
    _sl.registerLazySingleton(() => FetchHotTokens(_sl<HotTokenRepository>()));

    // Register cubits
    _sl.registerLazySingleton(() => HotTokenCubit(_sl<FetchHotTokens>()));
  }
}
```

Modules are initialized in `lib/core/di/injection_container.dart`.

### State Management Pattern

- **Feature Cubits** (`lib/features/{feature}/presentation/cubits/`): Feature-specific state with Clean Architecture
- **Global Cubits** (`lib/cubits/`): Cross-feature state (auth, wallet, balance, theme, language)
- **Legacy Screen Cubits** (`lib/screens/{screen}/cubit/`): Old architecture, being migrated
- Access via GetIt: `getIt<CubitName>()`
- BlocProviders set up in `GlobalProvide` widget for global cubits

### Service Locator (GetIt)

**Hybrid approach** during migration:

1. **Modern (Feature Modules)**: Use modular DI in `lib/core/di/modules/` (see Dependency Injection section)
2. **Legacy**: Traditional setup in `lib/core/service_locator.dart`
   - `setupCoreServices()`: Core services (DioClient, ErrorHandler, OfflineQueueManager)
   - `setupServiceLocator()`: APIs, storage services, legacy cubits
   - `setupApi()` (`lib/core/api_locator.dart`): Legacy API registration
   - `setupCubits()` (`lib/core/cubit_locator.dart`): Legacy cubit registration

Access services: `getIt<ServiceName>()`

Both systems use the same `GetIt` instance, allowing gradual migration.

### Data Models

**Feature modules**: Models in `lib/features/{feature}/data/models/` and entities in `domain/entities/`
**Legacy**: Models in `lib/data/models/`

All models use:
- **Freezed** for immutability and code generation
- Models generate `*.freezed.dart` files
- JSON serialization with `@JsonSerializable` (generates `*.g.dart`)
- Run `dart run build_runner watch` during development

### API & HTTP

- **DioClient** (`lib/data/services/http/dio_client.dart`): Configured with base URL, interceptors
- **Interceptors** handle authentication, token refresh, logging
- **ErrorHandler** (`lib/data/services/http/error_handler.dart`): Centralized error handling
- API services in `lib/data/services/api/` (e.g., `auth_api.dart`, `trade_api.dart`)

### Routing

- **GoRouter** configuration in `lib/core/router/app_router.dart`
- Route paths and constants in router configuration
- Custom page transitions (rightToLeft, bottomToTop, fade)
- Navigation: Use `context.go()`, `context.push()` from GoRouter

### Environment Configuration

- Uses **Envied** for environment variables
- Config in `lib/config/env/env.dart`
- Environment files:
  - `.env.production` - production
  - `.env.development` - default dev
  - `.env.development1.local`, `.env.development2.local` - local dev
- Switch via `--dart-define=ENV=<env_name>`
- Run `flutter pub run build_runner build` after changing .env files to regenerate `env.g.dart`

### Storage

**Secure Storage** (`lib/utils/storage/secure/`):
- `SecureStorageService` - flutter_secure_storage wrapper
- `TokenStorageService` - auth tokens
- `UserStorageService` - user data

**Local Storage** (`lib/utils/storage/local/`):
- `SettingsStorage` - app settings (SharedPreferences)
- `WalletStorage` - wallet data
- `TradeSettingStorage` - trading preferences
- `TokenSwapStorage` - swap configuration

### Localization

- ARB files in `lib/l10n/` (e.g., `intl_en.arb`, `intl_zh.arb`)
- Generated class: `S` (defined in `l10n.yaml`)
- Access: `S.of(context).keyName`
- Supported locales: English (en_US), Chinese (zh_CN)
- Use Flutter Intl plugin for easier management

## Code Patterns

### Feature Module Structure (NEW)

```
lib/features/{feature_name}/
├── domain/
│   ├── entities/
│   │   └── {entity}_entity.dart        # Business entity with Freezed
│   ├── repositories/
│   │   └── {name}_repository.dart      # Abstract repository interface
│   └── usecases/
│       └── {action}_{entity}.dart      # Use case (e.g., fetch_hot_tokens.dart)
├── data/
│   ├── models/
│   │   └── {model}_model.dart          # DTO with Freezed & JSON serialization
│   ├── repositories/
│   │   └── {name}_repository_impl.dart # Repository implementation
│   └── sources/
│       └── {name}_remote_source.dart   # API data source
└── presentation/
    ├── pages/
    │   └── {screen_name}.dart          # Screen widget
    ├── widgets/
    │   └── {widget_name}.dart          # Feature-specific widgets
    └── cubits/
        ├── {name}_cubit.dart
        └── {name}_state.dart           # State with Freezed
```

### Use Case Pattern (Clean Architecture)

```dart
// Domain layer - pure business logic
class FetchHotTokens {
  final HotTokenRepository repository;

  FetchHotTokens(this.repository);

  Future<List<HotTokenEntity>> call({required String network}) async {
    return await repository.getHotTokens(network: network);
  }
}
```

### Repository Pattern

```dart
// Domain layer - abstract interface
abstract class HotTokenRepository {
  Future<List<HotTokenEntity>> getHotTokens({required String network});
}

// Data layer - concrete implementation
class HotTokenRepositoryImpl implements HotTokenRepository {
  final HotTokenRemoteSource remoteSource;

  HotTokenRepositoryImpl(this.remoteSource);

  @override
  Future<List<HotTokenEntity>> getHotTokens({required String network}) async {
    final models = await remoteSource.fetchHotTokens(network);
    return models.map((m) => m.toEntity()).toList();
  }
}
```

### Cubit Pattern

```dart
// State with Freezed
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState({
    @Default(false) bool isLoading,
    String? error,
    Data? data,
  }) = _ExampleState;
}

// Cubit (depends on UseCases in Clean Architecture)
class ExampleCubit extends Cubit<ExampleState> {
  final FetchDataUseCase _fetchData;

  ExampleCubit(this._fetchData) : super(const ExampleState());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final data = await _fetchData();
      emit(state.copyWith(data: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
```

### Legacy Screen Structure

```
lib/screens/{screen_name}/
├── {screen_name}.dart      # Main screen widget
├── cubit/                   # Screen-specific state management
│   ├── {name}_cubit.dart
│   └── {name}_state.dart
└── widgets/                 # Screen-specific widgets
```

## Important Notes

- **Architecture migration**: New features MUST use Clean Architecture in `lib/features/`, not legacy `lib/screens/`
- **Analyzer excludes**: `**/*.g.dart` and `**/*.freezed.dart` are excluded in `analysis_options.yaml`
- **Theme**: Currently forced to light mode (`themeMode: ThemeMode.light` in `app.dart`)
- **Screen size**: Design reference is 393x852 (configured in ScreenUtilInit)
- **Blockchain**: Multi-chain support (EVM via web3dart, Solana via solana_web3)
- **Error monitoring**: Sentry integration configured (DSN in .env files)
- **Offline support**: OfflineQueueManager handles offline requests with Hive

## Adding New Features (Clean Architecture)

Follow this process for **all new features** in `lib/features/`:

### 1. Create Feature Structure

```bash
lib/features/{feature_name}/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
└── presentation/
    ├── pages/
    ├── widgets/
    └── cubits/
```

### 2. Implement Layers (Bottom-Up)

**Domain Layer** (no dependencies):
1. Create entity in `domain/entities/{entity}_entity.dart` (use Freezed)
2. Create repository interface in `domain/repositories/{name}_repository.dart`
3. Create use case in `domain/usecases/{action}_{entity}.dart`

**Data Layer**:
1. Create model in `data/models/{model}_model.dart` (Freezed + JSON serialization)
2. Create remote source in `data/sources/{name}_remote_source.dart`
3. Implement repository in `data/repositories/{name}_repository_impl.dart`

**Presentation Layer**:
1. Create state in `presentation/cubits/{name}_state.dart` (Freezed)
2. Create cubit in `presentation/cubits/{name}_cubit.dart` (inject UseCases)
3. Create page in `presentation/pages/{screen_name}.dart`
4. Create widgets in `presentation/widgets/`

### 3. Register Dependencies

Create DI module in `lib/core/di/modules/{feature_name}_module.dart`:

```dart
class FeatureModule implements InjectionModule {
  final GetIt _sl;

  FeatureModule(this._sl);

  @override
  Future<void> init() async {
    // Data sources
    _sl.registerLazySingleton(() => FeatureRemoteSource(_sl<DioClient>()));

    // Repositories
    _sl.registerLazySingleton<FeatureRepository>(
      () => FeatureRepositoryImpl(_sl<FeatureRemoteSource>()),
    );

    // Use cases
    _sl.registerLazySingleton(() => FetchFeatureData(_sl<FeatureRepository>()));

    // Cubits
    _sl.registerLazySingleton(() => FeatureCubit(_sl<FetchFeatureData>()));
  }
}
```

Register module in `lib/core/di/injection_container.dart`:

```dart
Future<void> init() async {
  // ... existing modules
  FeatureModule(getIt).init();
}
```

### 4. Add Route

Add route in `lib/core/router/app_router.dart`

### 5. Generate Code

```bash
# Generate Freezed models and JSON serialization
dart run build_runner build --delete-conflicting-outputs

# Generate localization if needed
flutter gen-l10n
```

### 6. Test

Access cubit via `getIt<FeatureCubit>()` and test the feature

## Migrating Legacy Code

When refactoring existing screens to features:

1. Create feature structure following Clean Architecture
2. Move business logic to domain/usecases
3. Extract API calls to data/sources
4. Move models to data/models, create entities in domain/entities
5. Implement repositories
6. Update cubit to use UseCases
7. Move UI to presentation/
8. Create DI module
9. Update routes
10. Test thoroughly before removing old code

**Reference**: See `lib/features/trending/` for a complete example
