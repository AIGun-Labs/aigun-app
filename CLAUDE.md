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

### Directory Structure

```
lib/
├── cubits/          # Global state management (Bloc/Cubit)
├── screens/         # Screen-level UI with local cubit/ and widgets/
├── widgets/         # Shared reusable widgets
├── data/
│   ├── models/      # Freezed data models (*.freezed.dart)
│   ├── services/
│   │   ├── api/     # API endpoint definitions
│   │   ├── http/    # DioClient, interceptors, error handling
│   │   └── ws/      # WebSocket services
│   └── repositories/ # Data layer abstractions
├── core/            # Service locator and core setup
├── routing/         # GoRouter configuration
├── config/          # Environment config, constants
├── utils/           # Utilities, validators, formatters, storage
├── themes/          # App theming
└── l10n/            # Internationalization (*.arb files)
```

### State Management Pattern

- **Global Cubits** (`lib/cubits/`): Cross-screen state like auth, wallet, balance, theme, language
- **Screen-local Cubits** (`lib/screens/{screen_name}/cubit/`): Screen-specific business logic
- **BlocProviders** set up in `GlobalProvide` widget for global cubits
- All cubits registered in `lib/core/cubit_locator.dart` via GetIt

### Service Locator (GetIt)

Initialized in `lib/core/service_locator.dart`:
1. **setupCoreServices()**: Called in `main()` - sets up DioClient, ErrorHandler
2. **setupServiceLocator()**: Sets up APIs, storage services, and cubits
3. **setupApi()** (`lib/core/api_locator.dart`): Registers all API services
4. **setupCubits()** (`lib/core/cubit_locator.dart`): Registers all cubits

Access services: `getIt<ServiceName>()`

### Data Models

- Use **Freezed** for all data models in `lib/data/models/`
- Models generate `*.freezed.dart` files
- JSON serialization with `@JsonSerializable`
- Run `dart run build_runner watch` during development

### API & HTTP

- **DioClient** (`lib/data/services/http/dio_client.dart`): Configured with base URL, interceptors
- **Interceptors** handle authentication, token refresh, logging
- **ErrorHandler** (`lib/data/services/http/error_handler.dart`): Centralized error handling
- API services in `lib/data/services/api/` (e.g., `auth_api.dart`, `trade_api.dart`)

### Routing

- **GoRouter** configuration in `lib/routing/app_router.dart`
- Route paths in `lib/routing/routes_path.dart`
- Custom page transitions (rightToLeft, bottomToTop, fade)

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

### Screen Structure
Each screen typically has:
```
lib/screens/{screen_name}/
├── {screen_name}.dart      # Main screen widget
├── cubit/                   # Screen-specific state management
│   ├── {name}_cubit.dart
│   └── {name}_state.dart
└── widgets/                 # Screen-specific widgets
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

// Cubit
class ExampleCubit extends Cubit<ExampleState> {
  final ApiService _api;

  ExampleCubit(this._api) : super(const ExampleState());

  Future<void> fetchData() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final data = await _api.getData();
      emit(state.copyWith(data: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
```

### API Service Pattern
```dart
class ExampleApi {
  final Dio _dio;

  ExampleApi(this._dio);

  Future<Response> fetchExample() async {
    return await _dio.get('/endpoint');
  }
}
```

## Important Notes

- **Analyzer excludes**: `**/*.g.dart` and `**/*.freezed.dart` are excluded in `analysis_options.yaml`
- **Theme**: Currently forced to light mode (`themeMode: ThemeMode.light` in `app.dart:72`)
- **Screen size**: Design reference is 393x852 (configured in ScreenUtilInit)
- **Navigation**: Use `context.go()`, `context.push()` from GoRouter
- **Blockchain**: Multi-chain support (EVM via web3dart, Solana via solana_web3)
- **Error monitoring**: Sentry integration configured (DSN in .env files)
- **Image caching**: Configured in `ImageCacheManager.configureCache()`
- **Timezone**: Initialized in `TimezoneUtils.initializeTimezone()`

## Adding New Features

1. **New API endpoint**: Add to appropriate file in `lib/data/services/api/`, register in `api_locator.dart`
2. **New model**: Create in `lib/data/models/` with Freezed, run build_runner
3. **New screen**: Create directory in `lib/screens/`, add route in `app_router.dart`
4. **New global state**: Create cubit in `lib/cubits/`, register in `cubit_locator.dart`, add to `GlobalProvide`
5. **Localization**: Add keys to `lib/l10n/intl_*.arb`, run `flutter gen-l10n`
