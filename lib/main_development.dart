import 'app.dart';
import 'bootstrap.dart';
import 'core/constant/enviroment.dart';

Future<void> main() =>
    bootstrap(() => const AIGunApp(), environment: Enviroment.development);
