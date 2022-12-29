class ServerException implements Exception {}

class UnauthenticatedException implements Exception {
  final String message;

  const UnauthenticatedException({this.message = 'User Unauthenticated'});
}

class MissingEnvError extends Error {
  final String envKeyName;

  MissingEnvError(this.envKeyName);

  @override
  String toString() {
    return 'Failed to load env variable with name: $envKeyName';
  }
}
