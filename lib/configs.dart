// lib/configs.dart

// ===============================
// CONFIGURATION & ENVIRONMENT LOADER
// ===============================

import 'package:flutter_dotenv/flutter_dotenv.dart';

// ===============================
// LOAD .env FILE BY ENV VAR
// ===============================

/// Load environment file (.env.dev, .env.mock, .env.prod)
/// Use --dart-define=ENV=... during build
Future<void> loadEnvironment() async {
  const envFile = String.fromEnvironment('ENV', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);
}

// ===============================
// APP CONFIGURATION CLASS
// ===============================

/// Global configuration helper
/// - Provides baseUrl, appMode, mockDelay from .env
class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get appMode => dotenv.env['APP_MODE'] ?? 'prod'; // dev, mock, prod

  // Enable artificial delay for mock services (true/false)
  static bool get useMockDelay => dotenv.env['USE_MOCK_DELAY'] == 'true';

  // Mock delay duration (for simulating network delay)
  static Duration get mockDelay {
    final ms = int.tryParse(dotenv.env['MOCK_DELAY_MS'] ?? '0') ?? 0;
    return Duration(milliseconds: ms);
  }

  // Helpers for checking mode
  static bool get isMock => appMode == 'mock';
  static bool get isDev => appMode == 'dev';
  static bool get isProd => appMode == 'prod';
}
