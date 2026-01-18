# AIGun - AI Automated Trading Platform

<p align="center">
  <img src="assets/images/logo/aigun-logo.jpg" alt="AIGun Logo" width="120"/>
</p>

<p align="center">
  <strong>Disruptive AI-Powered Automated Trading for Multi-Chain Markets</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#user-journey">User Journey</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#dependencies">Dependencies</a> •
  <a href="#deployment">Deployment</a>
</p>

---

## Overview

AIGun is an innovative AI automated trading platform that leverages advanced artificial intelligence algorithms to execute automated trading strategies across multiple blockchain markets. The platform provides users with a seamless and intelligent trading experience on both EVM-compatible chains and Solana.

## Features

- 🤖 **AI-Powered Trading** - Advanced algorithms for automated strategy execution
- ⛓️ **Multi-Chain Support** - EVM networks and Solana blockchain integration
- 📊 **Real-Time Analytics** - Live market data with interactive candlestick charts
- 🔐 **Secure Wallet Management** - Encrypted storage for private keys and credentials
- 🌍 **Multi-Language Support** - Internationalization (i18n) for global users
- 📱 **Cross-Platform** - iOS, Android, Web, and Desktop support

---

## User Journey

The following diagram illustrates the typical user flow through the AIGun platform:

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              AIGun User Journey                                  │
└─────────────────────────────────────────────────────────────────────────────────┘

    ┌──────────┐     ┌──────────────┐     ┌───────────────┐     ┌──────────────┐
    │  Start   │────▶│  Onboarding  │────▶│ Authentication│────▶│   Dashboard  │
    └──────────┘     └──────────────┘     └───────────────┘     └──────────────┘
                            │                     │                     │
                            ▼                     ▼                     ▼
                     ┌─────────────┐       ┌───────────┐        ┌─────────────┐
                     │ App Intro   │       │  Login /  │        │ Market      │
                     │ & Features  │       │  Register │        │ Overview    │
                     └─────────────┘       └───────────┘        └─────────────┘
                                                                       │
         ┌─────────────────────────────────────────────────────────────┤
         ▼                           ▼                                 ▼
   ┌───────────┐              ┌─────────────┐                  ┌──────────────┐
   │  Wallet   │              │   Trading   │                  │   Profile    │
   │ Management│              │   Center    │                  │   Settings   │
   └───────────┘              └─────────────┘                  └──────────────┘
         │                           │                                 │
         ▼                           ▼                                 ▼
   ┌───────────┐              ┌─────────────┐                  ┌──────────────┐
   │ • Import  │              │ • AI Bot    │                  │ • Language   │
   │ • Create  │              │   Config    │                  │ • Theme      │
   │ • Backup  │              │ • Strategy  │                  │ • Security   │
   │ • Multi-  │              │   Select    │                  │ • Notifs     │
   │   Chain   │              │ • Execute   │                  │ • Support    │
   └───────────┘              └─────────────┘                  └──────────────┘
         │                           │
         └─────────────┬─────────────┘
                       ▼
               ┌──────────────┐
               │  Monitoring  │
               │  & Reports   │
               └──────────────┘
                       │
                       ▼
               ┌──────────────┐
               │ • P&L Track  │
               │ • Trade Hist │
               │ • Analytics  │
               │ • Export     │
               └──────────────┘
```

### Journey Phases

| Phase | Description | Key Features |
|-------|-------------|--------------|
| **Onboarding** | First-time user introduction | App walkthrough, feature highlights |
| **Authentication** | Secure account access | Login, registration, 2FA, biometrics |
| **Dashboard** | Central hub for all activities | Market overview, portfolio summary, quick actions |
| **Wallet Management** | Multi-chain wallet operations | Create/import wallets, manage keys, multi-chain support |
| **Trading Center** | AI-powered trading interface | Bot configuration, strategy selection, execution |
| **Monitoring** | Track performance and history | P&L tracking, trade history, analytics export |

---

## Architecture

AIGun follows **Clean Architecture** combined with **Feature-Driven Development (FDD)** principles to ensure maintainability, testability, and scalability.

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PRESENTATION LAYER                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Pages     │  │   Widgets   │  │   BLoCs     │  │ Controllers │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────────────────────┤
│                             DOMAIN LAYER                                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                         │
│  │  Entities   │  │  Use Cases  │  │ Repositories│ (interfaces)            │
│  └─────────────┘  └─────────────┘  └─────────────┘                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                              DATA LAYER                                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                         │
│  │   Models    │  │ Data Sources│  │ Repositories│ (implementations)       │
│  └─────────────┘  └─────────────┘  └─────────────┘                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                         INFRASTRUCTURE LAYER                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  Networking │  │   Storage   │  │   Services  │  │   Router    │        │
│  │    (Dio)    │  │(SecureStore)│  │(Analytics)  │  │  (GoRouter) │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Project Structure

```
lib/
├── main.dart                  # 🚀 Application entry point
├── app.dart                   # 🏠 MaterialApp configuration
├── bootstrap.dart             # 🔧 App initialization
│
├── config/                    # ⚙️ Configuration
│   ├── env/                   #    Environment settings (dev/prod)
│   ├── chain.dart             #    Blockchain configurations
│   └── ...                    #    Other app configs
│
├── core/                      # 🧠 Core Layer
│   ├── di/                    #    💉 Dependency Injection (GetIt)
│   ├── router/                #    GoRouter configuration
│   ├── services/              #    Core services (storage, logger)
│   ├── enums/                 #    Enumerations
│   ├── types/                 #    Type definitions
│   └── utils/                 #    Pure logic utilities
│
├── infrastructure/            # 🔧 Infrastructure Layer
│   ├── network/               #    HTTP client (Dio)
│   ├── services/              #    Third-party integrations
│   └── serialization/         #    Data serialization
│
├── shared/                    # 🔄 Shared Layer
│   ├── domain/                #    Shared entities
│   ├── data/                  #    Shared DTOs
│   ├── presentation/          #    Design system components
│   └── utils/                 #    UI helpers
│
├── features/                  # 📦 Feature Modules
│   ├── auth/                  #    Authentication
│   ├── wallet/                #    Wallet management
│   ├── swap/                  #    Token swap/trading
│   ├── home/                  #    Home dashboard
│   └── ...                    #    Other feature modules
│
├── screens/                   # 📱 Screen pages
├── widgets/                   # 🧩 Reusable UI components
├── cubits/                    # 🔄 BLoC/Cubit state management
├── themes/                    # 🎨 App theming
│
└── l10n/                      # 🌍 Internationalization
```

### Dependency Flow

```
┌─────────────────────────────────────────────────────┐
│                   Presentation                       │
│            (UI, BLoC, Controllers)                   │
├────────────────────────┬────────────────────────────┤
                         │
                         ▼
├────────────────────────┴────────────────────────────┤
│                      Domain                          │
│           (Entities, Use Cases, Interfaces)          │
├────────────────────────┬────────────────────────────┤
                         │
                         ▼
├────────────────────────┴────────────────────────────┤
│                       Data                           │
│         (Models, Repositories, DataSources)          │
├────────────────────────┬────────────────────────────┤
                         │
                         ▼
├────────────────────────┴────────────────────────────┤
│                   Infrastructure                     │
│          (Network, Storage, Services)                │
└─────────────────────────────────────────────────────┘

Direction: Outer → Inner (Dependencies point inward)
Rule: Inner layers NEVER depend on outer layers
```

### Design Principles

- **SOLID Principles** - Single responsibility, Open/Closed, Liskov substitution, Interface segregation, Dependency inversion
- **Dependency Inversion** - Abstractions don't depend on implementations
- **Separation of Concerns** - Each module has clear responsibilities
- **Testability** - Architecture designed for comprehensive unit testing

---

## Dependencies

### Open-Source Dependencies

AIGun is built with the following open-source packages:

#### Core Framework
| Package | Version | Description |
|---------|---------|-------------|
| [Flutter](https://flutter.dev) | SDK >=3.10.0 | Cross-platform UI framework |
| [Dart](https://dart.dev) | >=3.10.0 | Programming language |

#### State Management
| Package | Version | Description |
|---------|---------|-------------|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | ^9.0.0 | BLoC pattern state management |
| [provider](https://pub.dev/packages/provider) | ^6.1.1 | Dependency injection |
| [rxdart](https://pub.dev/packages/rxdart) | ^0.28.0 | Reactive extensions for Dart |

#### Networking & API
| Package | Version | Description |
|---------|---------|-------------|
| [dio](https://pub.dev/packages/dio) | ^5.4.1 | HTTP client |
| [dio_smart_retry](https://pub.dev/packages/dio_smart_retry) | ^7.0.1 | Retry interceptor for Dio |
| [http](https://pub.dev/packages/http) | ^1.6.0 | HTTP requests |
| [web_socket_channel](https://pub.dev/packages/web_socket_channel) | ^2.4.0 | WebSocket support |

#### Blockchain & Web3
| Package | Version | Description |
|---------|---------|-------------|
| [web3dart](https://pub.dev/packages/web3dart) | ^2.7.1 | Ethereum/EVM integration |
| [solana_web3](https://pub.dev/packages/solana_web3) | ^0.1.3 | Solana blockchain support |
| [crypto](https://pub.dev/packages/crypto) | ^3.0.6 | Cryptographic functions |

#### Navigation & Routing
| Package | Version | Description |
|---------|---------|-------------|
| [go_router](https://pub.dev/packages/go_router) | ^17.0.0 | Declarative routing |
| [go_router_builder](https://pub.dev/packages/go_router_builder) | ^4.1.1 | Code generation for routes |

#### UI Components
| Package | Version | Description |
|---------|---------|-------------|
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | ^5.0.0 | Screen adaptation |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | ^3.4.1 | Image caching |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | ^2.0.16 | SVG rendering |
| [lottie](https://pub.dev/packages/lottie) | ^3.3.1 | Lottie animations |
| [shimmer](https://pub.dev/packages/shimmer) | ^3.0.0 | Shimmer loading effects |
| [qr_flutter](https://pub.dev/packages/qr_flutter) | ^4.1.0 | QR code generation |

#### Charts & Visualization
| Package | Version | Description |
|---------|---------|-------------|
| [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts) | ^31.2.5 | Advanced charting |
| [k_chart_plus](https://pub.dev/packages/k_chart_plus) | ^1.0.3 | K-line/candlestick charts |

#### Storage & Security
| Package | Version | Description |
|---------|---------|-------------|
| [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) | ^9.2.0 | Encrypted storage |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.3.4 | Key-value storage |

#### Code Generation
| Package | Version | Description |
|---------|---------|-------------|
| [freezed](https://pub.dev/packages/freezed) | ^3.2.3 | Immutable data classes |
| [json_serializable](https://pub.dev/packages/json_serializable) | ^6.11.2 | JSON serialization |
| [build_runner](https://pub.dev/packages/build_runner) | ^2.10.4 | Code generation runner |

#### Monitoring & Analytics
| Package | Version | Description |
|---------|---------|-------------|
| [sentry_flutter](https://pub.dev/packages/sentry_flutter) | ^9.7.0 | Error tracking |
| [logger](https://pub.dev/packages/logger) | ^2.5.0 | Logging utility |

#### Dependency Injection
| Package | Version | Description |
|---------|---------|-------------|
| [get_it](https://pub.dev/packages/get_it) | ^9.0.5 | Service locator |

> **Note:** For the complete list of dependencies, see [pubspec.yaml](pubspec.yaml)

---

## Deployment

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** >= 3.10.0 ([Installation Guide](https://docs.flutter.dev/get-started/install))
- **Dart SDK** >= 3.10.0 (included with Flutter)
- **Android Studio** or **Xcode** (for mobile development)
- **Git** for version control

### Environment Setup

#### macOS

```bash
# 1. Download Flutter SDK
# Visit: https://docs.flutter.dev/install/quick

# 2. Add Flutter to PATH
export PATH="$PATH:$HOME/development/flutter/bin"

# 3. Add to shell config (~/.zshrc or ~/.bash_profile)
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc

# 4. Verify installation
flutter doctor
```

#### Windows

```bash
# 1. Download Flutter SDK
# Visit: https://docs.flutter.dev/install/quick

# 2. Add to PATH via System Environment Variables
# Add: C:\src\flutter\bin

# 3. Verify installation (PowerShell)
flutter doctor
```

### Running & Debugging

```bash
# Run in staging/development mode
flutter run --flavor staging

# Run in production mode
flutter run --flavor production

# Run with specific device
flutter run -d <device_id> --flavor staging

# Run with hot reload enabled (default)
flutter run --flavor staging

# Run in release mode for performance testing
flutter run --release --flavor staging

# Run in profile mode for performance profiling
flutter run --profile --flavor staging
```

#### Debug Tools

```bash
# Open Flutter DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Environment Configuration

The app supports multiple environments. Configure by modifying `main.dart`:

| Environment | Description |
|-------------|-------------|
| `development` | Local development with debug features |
| `staging` | Testing environment |
| `production` | Production release |

### Building for Release

#### Android

```bash
# Development/Staging APK
flutter build apk --release --flavor staging --target lib/main_staging.dart

# Production APK
flutter build apk --release --flavor production --target lib/main_production.dart

# Google Play Bundle (Production)
flutter build appbundle --release --flavor play --target lib/main_play.dart --dart-define=ENABLE_INNER_UPDATE=false

# Google Play Bundle (Staging)
flutter build appbundle --release --flavor staging --target lib/main_staging.dart --dart-define=ENABLE_INNER_UPDATE=false
```

#### iOS

```bash
# Build IPA with obfuscation
flutter build ipa --release --obfuscate --split-debug-info=./symbols
```

### CI/CD Deployment

#### Staging Deployment

```bash
git switch staging
git merge dev
git push build -f
```

#### Production Deployment

```bash
git switch release
git merge dev
git push build
git tag vX.X.X
git push build vX.X.X -f
```

### Code Generation (Development)

```bash
# Watch mode (auto-regenerate on changes)
flutter pub run build_runner watch

# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### Version Management

Version is maintained in `pubspec.yaml`:
- Current version: **1.2.3+113**
- Update CHANGELOG when incrementing versions

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

This project is proprietary software. All rights reserved.

---

<p align="center">
  Built with ❤️ using Flutter
</p>
