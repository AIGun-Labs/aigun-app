当前 `AuthCubit` 和 `AuthState` 承担了过多的职责，它混合了全局认证状态管理（用户是否登录）、登录/注册表单的 UI 逻辑（多步骤、字段值、校验状态）等。这使得代码耦合度较高，难以维护和扩展。

我建议进行以下重构来优化，这更符合您项目中遵循的 **Clean Architecture** 和 **单一职责原则**：

### 优化方案

1.  **职责分离 (Cubit Refactoring):**

    - **`AuthCubit`**: 将其职责精简为**只管理全局用户会话状态**（例如：`authenticated`, `unauthenticated`）。它只负责在 App 启动时检查登录状态、响应登录成功后的状态变更以及处理登出逻辑。
    - **`SignInCubit` & `SignUpCubit`**: 我注意到项目中已经存在这两个 Cubit，这很好。我们会将 `AuthCubit` 中所有关于登录和注册的**表单逻辑**（包括字段处理、校验、多步骤流程控制、API 调用）分别迁移到这两个独立的 Cubit 中，使其各司其职。

2.  **状态对象简化 (State Refactoring):**

    - **`AuthState`**: 相应地，我们简化 `AuthState`，只保留与会话相关的状态，例如 `AuthStatus` 和 `User` 对象。
    - **`SignInState` & `SignUpState`**: 确保这两个 State 只包含各自表单所需的数据、校验结果和提交状态。

3.  **UI 结构优化 (UI Refactoring):**
    - 将登录和注册界面拆分为独立的 `Widget`，各自通过 `BlocProvider` 使用对应的 `SignInCubit` 或 `SignUpCubit`。
    - 顶层的 `AuthScreen` 或其他全局组件监听 `AuthCubit` 的状态变化，来统一处理登录成功/失败后的页面导航。

这个重构方案将显著提高认证模块代码的清晰度、可测试性和可维护性。

您觉得这个方案如何？如果同意，我将从第一步开始，即重构 `AuthCubit` 和 `AuthState`。
Ran tool
好的，关于优化登录注册功能，我分析了您提供的 `auth` 和 `cubits/auth` 目录下的代码。当前 `AuthCubit` 和 `AuthState` 承担了过多的职责，包括全局认证状态管理、登录/注册表单的 UI 逻辑、字段值和校验状态。这使得代码耦合度高，难以维护和扩展。

我建议进行以下重构来优化：

1.  **职责分离 (Cubit Refactoring):**

    - **`AuthCubit`:** 将其职责精简为只管理全局用户会话状态（如：已认证、未认证、加载中），处理初始化时检查登录状态和登出逻辑。
    - **`SignInCubit` & `SignUpCubit`:** 将登录和注册的表单逻辑（包括字段处理、校验、多步骤流程控制）分别拆分到独立的 `SignInCubit` 和 `SignUpCubit` 中。我注意到项目中已经存在 `SignInCubit` 和 `SignUpCubit`，我们可以将 `AuthCubit` 中的逻辑迁移过去，使其各司其职。

2.  **状态对象简化 (State Refactoring):**

    - **`AuthState`:** 只保留与会话相关的状态，例如 `AuthStatus` 和 `User` 对象。
    - **`SignInState` & `SignUpState`:** 为登录和注册流程创建或完善各自的 State 类，用于管理表单数据、校验结果和提交状态。

3.  **UI 结构优化:**

    - 将登录和注册界面拆分为独立的 `Widget`，各自通过 `BlocProvider` 使用对应的 `SignInCubit` 或 `SignUpCubit`。
    - 主 `AuthScreen` 或更高层的 Widget 监听 `AuthCubit` 的状态变化，来处理登录成功/失败后的页面导航。

4.  **改进表单校验:**
    - 将校验逻辑从 Cubit 中抽离，使用更通用的 Validator 类（您项目中已存在 `utils/validators`，这很好）。
    - 在 State 中，可以使用更具表达性的方式来表示校验结果，例如保存错误信息字符串而不是简单的布尔值，这样可以直接在 UI 上显示错误提示。

这个重构方案遵循了单一职责原则和 Clean Architecture 的思想，能显著提高代码的清晰度、可测试性和可维护性。

您觉得这个方案如何？如果同意，我将从重构 `AuthCubit` 和 `AuthState` 开始着手实施。

### 第 1 步：简化 `AuthState` - 只关心“是否登录”

**目标**：让 `AuthState` 只负责描述全局的认证状态，而不是掺杂表单的临时数据。

**当前 `lib/cubits/auth/auth_state.dart` 的问题**：
它包含了太多与 UI 表单相关的状态，比如 `email`, `password`, `step`, `isValid` 等。这些状态只在登录/注册的短暂过程中需要，不应该成为全局 `AuthState` 的一部分。

**如何做**：

1.  **清理 `AuthState`**: 我们将删除所有表单字段。
2.  **引入 `AuthStatus` 枚举**: 用一个枚举来清晰地表示认证状态：`initial` (初始检查中), `authenticated` (已认证), `unauthenticated` (未认证)。

**修改后的 `lib/cubits/auth/auth_state.dart` 会是这样：**

```dart:lib/cubits/auth/auth_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/data/models/index.dart';

part 'auth_state.freezed.dart';

// 1. 定义一个清晰的 AuthStatus 枚举
enum AuthStatus { initial, authenticated, unauthenticated }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    // 2. 使用枚举来管理状态
    @Default(AuthStatus.initial) AuthStatus status,
    // 3. 保留 user 对象，因为它是全局需要的
    User? user,
  }) = _AuthState;
}
```

---

### 第 2 步：精简 `AuthCubit` - 只做“会话管理员”

**目标**：让 `AuthCubit` 只负责管理用户的会话生命周期，即：应用启动时检查登录状态、响应登录成功、处理登出。

**当前 `lib/cubits/auth/auth_cubit.dart` 的问题**：
它包含了大量的表单处理逻辑，比如 `emailChanged`, `passwordChanged`, `signUpWithEmailAndPassword` 等。这些方法应该属于具体的登录/注册流程。

**如何做**：

1.  **移除表单处理方法**：删除所有处理表单输入和提交的方法。
2.  **保留核心会话方法**：只保留或添加以下几个核心方法：
    - `checkAuthStatus()`: 在 App 启动时调用，用来检查本地存储的 token/session，决定用户的初始状态是 `authenticated` 还是 `unauthenticated`。
    - `loggedIn(User user)`: 当登录/注册成功后，由外部（即 `SignInCubit` 或 `SignUpCubit` 的流程）调用此方法，将全局状态更新为 `authenticated`。
    - `loggedOut()`: 执行登出操作，清除 session，并将状态更新为 `unauthenticated`。

**修改后的 `lib/cubits/auth/auth_cubit.dart` 核心逻辑会是这样：**

```dart:lib/cubits/auth/auth_cubit.dart
// ... (imports)

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authApi, this._userStorageService) : super(const AuthState());

  final AuthApi _authApi;
  final UserStorageService _userStorageService;

  // 方法1: 检查初始认证状态
  Future<void> checkAuthStatus() async {
    // 假设 UserStorageService 可以获取用户信息
    final user = await _userStorageService.getUser();
    if (user != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  // 方法2: 登录成功后调用
  void loggedIn(User user) {
    // 可以在这里保存用户信息到安全存储
    _userStorageService.saveUser(user);
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
  }

  // 方法3: 执行登出
  Future<void> loggedOut() async {
    // 清理本地存储
    await _userStorageService.deleteUser();
    // 可选：通知后端API
    // await _authApi.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }
}
```

---

### 第 3 & 4 步：强化 `SignInCubit` / `SignUpCubit` - 专业的“表单处理器”

**目标**：将所有与登录/注册表单相关的逻辑（状态管理、校验、API 调用）都封装在各自的 Cubit 中。

**如何做**：
以 `SignInCubit` 为例 (`SignUpCubit` 同理)：

1.  **定义 `SignInState`**: 这个 State 将包含登录表单所需的所有数据。

    ```dart:lib/cubits/sign_in/sign_in_state.dart
    import 'package:freezed_annotation/freezed_annotation.dart';
    import 'package:flutter_aigun/enums/query_status.dart'; // 假设你有这个表示API调用状态的枚举

    part 'sign_in_state.freezed.dart';

    @freezed
    class SignInState with _$SignInState {
      const factory SignInState({
        @Default('') String email,
        @Default('') String password,
        @Default(false) bool isValid, // 表单整体是否有效
        @Default(QueryStatus.initial) QueryStatus submissionStatus,
        String? errorMessage,
      }) = _SignInState;
    }
    ```

2.  **实现 `SignInCubit`**: 将之前从 `AuthCubit` 移除的逻辑搬到这里。

    ```dart:lib/cubits/sign_in/sign_in_cubit.dart
    // ... (imports)

    class SignInCubit extends Cubit<SignInState> {
      SignInCubit(this._authApi) : super(const SignInState());

      final AuthApi _authApi;

      void emailChanged(String email) {
        emit(state.copyWith(email: email));
        _validateForm();
      }

      void passwordChanged(String password) {
        emit(state.copyWith(password: password));
        _validateForm();
      }

      void _validateForm() {
        // 使用 Validators 进行校验
        final isValid = EmailValidator.isValid(state.email) && PasswordValidator.isValid(state.password);
        emit(state.copyWith(isValid: isValid));
      }

      Future<void> signInWithEmailAndPassword() async {
        if (!state.isValid) return;

        emit(state.copyWith(submissionStatus: QueryStatus.loading));
        try {
          final user = await _authApi.signIn(email: state.email, password: state.password);
          // 成功！但注意，这里只更新自己的状态
          emit(state.copyWith(submissionStatus: QueryStatus.success));
          // 全局状态的更新交给 UI 层去触发
        } catch (e) {
          emit(state.copyWith(submissionStatus: QueryStatus.failure, errorMessage: e.toString()));
        }
      }
    }
    ```

---

### 第 5 步：改造 UI 层 - “各司其职”

**目标**：让 UI Widget 监听正确的 Cubit，并清晰地分离“全局导航”和“局部页面状态更新”。

**如何做**：

1.  **提供 Cubits**: 在你的 `AuthScreen` 或其父级 Widget 中，通过 `MultiBlocProvider` 提供 `SignInCubit` 和 `SignUpCubit`。

    ```dart
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignInCubit>()),
        BlocProvider(create: (context) => getIt<SignUpCubit>()),
        // AuthCubit 应该在更高层级提供，比如 App 的根部
      ],
      child: AuthScreen(),
    );
    ```

2.  **监听全局 `AuthCubit` 进行导航**: 在一个比较高层的 Widget (比如 `main.dart` 或者一个包裹 `MaterialApp` 的 `BlocListener`) 中监听 `AuthCubit`。

    ```dart
    // 在 App 的根 Widget
    BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          // 如果登录了，跳转到主页
          context.(Routes.home);
        } else if (state.status == AuthStatus.unauthenticated) {
          // 如果未登录，跳转到登录页
          context.go(Routes.auth);
        }
      },
      child: MaterialApp.router(...),
    );
    ```

3.  **构建登录/注册表单**: 在 `SignInScreen` 或你的登录表单 Widget 中，使用 `BlocConsumer` 来同时处理 UI 构建和一次性事件（如登录成功后的操作）。

    ```dart
    // 在 SignInForm Widget 中
    BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.submissionStatus == QueryStatus.success) {
          // 登录业务成功了！
          // 现在，我们通知全局的 AuthCubit
          // 假设你能从 API 响应中拿到 User 对象
          final user = ...; // 从 _authApi.signIn 的结果中获取
          context.read<AuthCubit>().loggedIn(user);
          // 此时，上面第2点的全局 BlocListener 会监听到状态变化并自动导航
        }
        if (state.submissionStatus == QueryStatus.failure) {
          // 显示错误提示
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login Failed')),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // ... Email 和 Password 输入框 ...
            // 输入框的 onChanged 调用 context.read<SignInCubit>().emailChanged(...)

            ElevatedButton(
              // 根据 state.isValid 和 state.submissionStatus 决定按钮是否可点击或显示加载中
              onPressed: state.isValid
                  ? () => context.read<SignInCubit>().signInWithEmailAndPassword()
                  : null,
              child: state.submissionStatus == QueryStatus.loading
                  ? CircularProgressIndicator()
                  : Text('Sign In'),
            ),
          ],
        );
      },
    );
    ```

通过以上步骤，我们就将一个庞大臃肿的 `AuthCubit` 成功地拆分成了各司其职、低耦合、高内聚的几个模块，代码会变得清晰很多。
