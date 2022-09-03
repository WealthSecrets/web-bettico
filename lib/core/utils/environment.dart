import 'dart:io';

enum Environment { development, production }

bool isTesting = Platform.environment.containsKey('FLUTTER_TEST');

const String _env =
    String.fromEnvironment('env.mode', defaultValue: 'development');

Environment get environment {
  const Map<String, Environment> _envs = <String, Environment>{
    'dev': Environment.development,
    'prod': Environment.production,
    'production': Environment.production,
    'development': Environment.development,
  };

  if (!_envs.containsKey(_env)) {
    throw Exception(
        "Invalid runtime environment: '$_env'. Available environments: ${_envs.keys.join(', ')}");
  }

  return _envs[_env]!;
}

extension EnvironmentX on Environment {
  bool get isDev => this == Environment.development;

  bool get isProduction => this == Environment.production;

  bool get isDebugging {
    bool condition = false;
    assert(() {
      condition = true;
      return condition;
    }());
    return condition;
  }

  String get value {
    return <Environment, String>{
      Environment.development: 'DEV',
      Environment.production: 'PROD',
    }[this]!;
  }

  String get url {
    return <Environment, String>{
      Environment.development: 'http://192.168.0.117:8000/api/v1/',
      Environment.production:
          'https://cors-everywhere-me.herokuapp.com/http://api.wealthsecrets.io:8000/api/v1/',
    }[this]!;
  }
}
