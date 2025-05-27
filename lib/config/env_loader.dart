import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Load the environment file specified by --dart-define=ENV=... (default: .env.dev)
Future<void> loadEnvironment() async {
  const envFile = String.fromEnvironment('ENV', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);
}
