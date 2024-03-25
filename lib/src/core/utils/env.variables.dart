import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvType { dev, prod }

class EnvVariable {
  EnvVariable._();

  static final EnvVariable instance = EnvVariable._();

  /// Initializes environment variables based on the provided environment type.
  Future<void> init({required EnvType envType}) async {
    switch (envType) {
      case EnvType.dev:
        await dotenv.load(fileName: '.env.dev');

      case EnvType.prod:
        await dotenv.load(fileName: '.env.prod');
    }

    // Consider adding error handling if ENV_TYPE is not found
    // _envType = dotenv.get('ENV_TYPE');
    //  dotenv.env['ENV_TYPE'] == 'dev' ? _envType = 'dev' : _envType = 'prod';
    // _firebaseKey = dotenv.get('FIREBASE_KEY');
    // _buildDeveloper = dotenv.get('BUILD_DEVELOPER');
  }

  /// Indicates if the current environment is for development.
// bool get debugMode => _envType == 'dev';
// String get notifcationBaseUrl => _notifcationBaseUrl;
// String get firebaseKey => _firebaseKey;
// String get buildDeveloper => _buildDeveloper;
}
