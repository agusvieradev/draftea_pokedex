class AppConfig {
  static const environment = String.fromEnvironment('ENV');

  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');

  static const connectionTimeout = int.fromEnvironment('CONNECTION_TIMEOUT', defaultValue: 10);

  static const receiveTimeout = int.fromEnvironment('RECEIVE_TIMEOUT', defaultValue: 10);
}
