part of 'index.dart';

enum ValidationError {
  emailEmpty,
  emailInvalid,
  codeEmpty,
  codeInvalid,
  codeInvalidFormat,
  nicknameEmpty,
  passwordEmpty,
  passwordTooShort,
  passwordTooSimple,
  confirmPasswordEmpty,
  passwordsDoNotMatch,
  networkError,
}

enum AuthFormError {
  emailInvalid,
  codeInvalid,
  nicknameInvalid,
  inviteCodeInvalid,
}
