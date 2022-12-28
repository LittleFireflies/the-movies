class ServerException implements Exception {}

class UnauthenticatedException implements Exception {
  final String message;

  const UnauthenticatedException({this.message = 'User Unauthenticated'});
}
