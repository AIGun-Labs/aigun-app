part of 'index.dart';

enum VerificationType {
  register('register'),
  resetPassword('reset_password');

  final String type;
  const VerificationType(this.type);
}
