import 'app.dart';
import 'bootstrap.dart';
import 'core/constant/environment.dart';

Future<void> main() => bootstrap(
  () => const AIGunApp(),
  environment: Envirnoment.development,
  enableNetworkLog: false,
);
