# AIGun Mobile App

AIGun Mobile is the official Flutter-based mobile application for the AIGun platform, delivering AI-driven financial intelligence and automated trading capabilities directly to your fingertips.

## Overview

The AIGun mobile app provides a seamless interface for traders to access real-time market intelligence, analyze potential investment opportunities with AI, and execute trades across multiple blockchains. It connects to the AIGun backend to deliver low-latency alerts and data visualization.

## Tech Stack

### Architecture & Patterns
- **Clean Architecture:** Layered architecture separating business logic from framework.
- **BLoC/Cubit (flutter_bloc):** State management.
- **Repository Pattern:** Data access abstraction.
- **UseCase Pattern:** Encapsulating business logic.

### UI Framework
- **Flutter:** SDK >=3.0.0 <4.0.0.
- **flutter_screenutil:** Screen adaptation.
- **Material Design 3 & Cupertino:** Design systems.

### State Management
- **flutter_bloc:** BLoC/Cubit state management.
- **Provider:** Dependency injection.
- **Equatable:** Object comparison optimization.

### Networking & Data
- **Dio:** HTTP client.
- **web3dart:** Blockchain integration (EVM/Solana).
- **Freezed:** Immutable data classes.
- **flutter_secure_storage:** Secure storage.

### Routing & Tools
- **GoRouter:** Declarative routing.
- **GetIt:** Dependency injection.
- **intl:** Internationalization support.
- **Lottie:** Animation components.

### UI Components
- **cached_network_image:** Image caching.
- **easy_refresh:** List refreshing.
- **qr_flutter:** QR code generation.
- **toastification:** Toast notifications.

## Project Architecture

The project follows industry-standard **Clean Architecture** + **Feature-Driven Development** patterns:

```
lib/
├── main.dart                         # App Entry Point
├── app.dart                          # MaterialApp Configuration
├── di/                               # Dependency Injection (Service Locator)
├── config/                           # Static Config (Env, Theme, Routes Path)
│   ├── theme/                        #    Global Theme Data
│   └── routes/
│       ├── app_router.dart           # GoRouter Configuration
│       └── route_names.dart          # Route Path Constants
│
├── core/                             # Core Layer (Pure Dart, No Flutter/3rd Party Deps)
│   ├── error/                        #   Failures, Exceptions Definitions
│   ├── usecases/                     #   UseCase Abstract Base Class
│   ├── types/                        #   Generic Types (e.g. Either, Result)
│   ├── utils/                        #   Pure Logic Utils (Date, Validators)
│   └── constants/                    #   Logic Constants (Limits, Regex)
│
├── infrastructure/                   # Infrastructure Layer (Concrete Implementations)
│   ├── networking/                   #   Network Client Wrapper (Dio)
│   │   ├── api_client.dart           #     Client Instance with Interceptors/BaseURL
│   │   └── interceptors/
│   ├── storage/                      #   Local Storage Wrapper (Hive/SP)
│   │   ├── database_service.dart     #     KV Storage or DB Abstraction
│   │   └── secure_storage.dart       #     Encrypted Storage Implementation
│   ├── services/                     #   3rd Party Service Implementations
│   │   ├── logger_service.dart       #     Logger Wrapper
│   │   ├── analytics_service.dart    #     Analytics Wrapper
│   │   └── permission_service.dart   #     Permission Wrapper
│   ├── device/                       #   Device Features
│   │   └── connection_checker.dart   #     Network Status Check
│   └── router/
│       ├── navigation_service.dart      # Navigation Implementation
│       └── app_navigator_observer.dart  # Route Observer (Analytics)
│
├── l10n/                             # Internationalization
│   ├── arb/
│   └── generated/
│
├── shared/                           # Shared Layer (Common Business & UI)
│   ├── constants/                    #    Resource Constants (Assets, StorageKeys)
│   ├── domain/                       #   Shared Domain Objects
│   │   ├── entities/                 #     (e.g. User Entity)
│   │   └── value_objects/            #     (e.g. Email, PhoneNumber)
│   ├── data/                         #   Shared Data Models (DTOs)
│   │   └── models/                   #     (e.g. User Model)
│   ├── presentation/                 #   Shared UI (Design System)
│   │   ├── widgets/                  #     Atomic Widgets (Buttons, Inputs)
│   │   ├── dialogs/                  #     Common Dialogs (Toast, Loading)
│   │   └── layouts/                  #     Common Layouts (ErrorView, EmptyView)
│   └── utils/                        #   Flutter Related Utils (Screen Adapt, Colors)
│
├── features/                         # Feature Modules (Business Verticals)
│   ├── authentication/               # Auth Module
│   │   ├── domain/                   # Domain Layer
│   │   │   ├── entities/             # Business Entities
│   │   │   ├── repositories/         # Abstract Interfaces
│   │   │   └── usecases/             # Business Use Cases
│   │   ├── data/                     # Data Layer
│   │   │   ├── models/               # Data Models
│   │   │   ├── repositories/         # Interface Implementations
│   │   │   └── datasources/          # Data Sources (Calls Infrastructure)
│   │   └── presentation/             # Presentation Layer
│   │       ├── pages/                # Screens
│   │       ├── widgets/              # Feature-specific Widgets
│   │       ├── blocs/                # State Management
│   │       └── controllers/          # Controllers
│   ├── settings/                     # Settings Module
│   └── ...
└── test/                             # Tests
    ├── unit/
    ├── widget/
    └── integration/
```

### Layer Description

1.  **Core Layer:**
    - Business-agnostic infrastructure.
    - Can be depended on by any layer.
    - Contains core logic for errors, use cases, and types.

2.  **Features Layer:**
    - Independent modules divided by business domain.
    - Each feature is a vertical slice following Clean Architecture.

3.  **Shared Layer:**
    - Code shared across modules.
    - Should not contain specific business logic.
    - Provides common capabilities and UI components.

4.  **Config Layer:**
    - App configuration and constants.
    - Environment-specific settings.
    - Route definitions.

### Dependency Rules

```
┌─────────────────┐
│   Presentation  │ ← Features Layer
├─────────────────┤
│     Domain      │ ← Business Logic
├─────────────────┤
│      Data       │ ← Data Access
├─────────────────┤
│      Core       │ ← Infrastructure
└─────────────────┘

Dependency Direction: Outer → Inner
Forbidden: Inner Layer depending on Outer Layer
```

## Installation & Setup

### Install Flutter SDK

Before starting, ensure Flutter is installed on your machine.

**Official Guide:** [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)

#### macOS
1. **Download SDK:**
   ```bash
   # Create a development directory
   mkdir -p ~/development
   cd ~/development
   # Clone the repo
   git clone https://github.com/flutter/flutter.git -b stable
   ```
2. **Update Path:**
   Add the following to your shell configuration file (`.zshrc` or `.bash_profile`):
   ```bash
   export PATH="$PATH:$HOME/development/flutter/bin"
   ```
3. **Apply Changes:**
   ```bash
   source ~/.zshrc
   ```

#### Windows
1. Download the installation bundle from the official website.
2. Extract the zip file to `C:\src\flutter`.
3. Add `C:\src\flutter\bin` to your **Environment Variables** > **Path**.

**Verify Installation:**
```bash
flutter doctor
```

### Prerequisites
- Flutter SDK (>=3.0.0 <4.0.0)
- Dart SDK
- Android Studio / Xcode (for mobile simulation)
- VS Code (recommended)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/biteying/flutter-aigun
   cd flutter-aigun
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Code Generation**
   ```bash
   # Generate Freezed models and other code
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Watch mode for auto-generation
   flutter pub run build_runner watch
   ```

4. **Generate Internationalization**
   ```bash
   flutter gen-l10n
   ```

5. **Run the application**
   ```bash
   flutter run --dart-define=ENV=development 
   ```


## Build & Deployment
```bash
flutter build apk
```

**Built by the AIGun Team**
