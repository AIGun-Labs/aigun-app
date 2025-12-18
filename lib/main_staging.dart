import 'app.dart';
import 'bootstrap.dart';
import 'core/enums/environment.dart';

Future<void> main() => bootstrap(
  () => const AIGunApp(),
  environment: Environment.development,
  enableNetworkLog: false,
);
