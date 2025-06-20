// lib/configs.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnvironment() async {
  const envFile = String.fromEnvironment('ENV', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);
}

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get appMode => dotenv.env['APP_MODE'] ?? 'prod'; // dev, mock, prod

  static bool get useMockDelay => dotenv.env['USE_MOCK_DELAY'] == 'true';

  static Duration get mockDelay {
    final ms = int.tryParse(dotenv.env['MOCK_DELAY_MS'] ?? '0') ?? 0;
    return Duration(milliseconds: ms);
  }

  static bool get isMock => appMode == 'mock';
  static bool get isDev => appMode == 'dev';
  static bool get isProd => appMode == 'prod';
}
