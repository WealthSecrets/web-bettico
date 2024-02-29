import 'dart:io';

enum Environment { development, production }

bool isTesting = Platform.environment.containsKey('FLUTTER_TEST');

const String _env = String.fromEnvironment('env.mode', defaultValue: 'development');

Environment get environment {
  const Map<String, Environment> envs = <String, Environment>{
    'dev': Environment.development,
    'prod': Environment.production,
    'production': Environment.production,
    'development': Environment.development,
  };

  if (!envs.containsKey(_env)) {
    throw Exception(
      "Invalid runtime environment: '$_env'. Available environments: ${envs.keys.join(', ')}",
    );
  }

  return envs[_env]!;
}

extension EnvironmentX on Environment {
  bool get isDev => this == Environment.development;

  bool get isProduction => this == Environment.production;

  bool get isDebugging {
    bool condition = false;
    assert(() {
      return condition = true;
    }());
    return condition;
  }

  String get value {
    return <Environment, String>{
      Environment.development: 'DEV',
      Environment.production: 'PROD',
    }[this]!;
  }

// 172.20.10.4
// 192.168.0.117
  String get url {
    return <Environment, String>{
      Environment.development: 'http://192.168.0.117:8000/api/v1/',
      Environment.production: 'https://api.wealthsecrets.io/api/v1/',
    }[this]!;
  }
}
