import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movies/utils/exceptions.dart';

extension DotEnvExt on DotEnv {
  String getString(String keyName, {String? fallback}) {
    return tryGet<String>(
      keyName,
      (value) => value,
      fallback: fallback,
    );
  }

  /// Base function for getting a value given a key [keyName].
  ///
  /// [parser] is a function for parsing the value [String] into [T].
  ///
  /// [fallback] will be returned if key [keyName] is not found. Otherwise,
  /// throws a [MissingEnvError].
  T tryGet<T>(String keyName, T Function(String) parser, {T? fallback}) {
    final String? value = dotenv.maybeGet(keyName);

    if (value == null && fallback != null) {
      return fallback;
    }

    if (value != null) {
      return parser(value);
    }

    throw MissingEnvError(keyName);
  }
}
