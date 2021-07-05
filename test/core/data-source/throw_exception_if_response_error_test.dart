import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/data-source/throw-exception-if-response-error.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';

void main() {
  ThrowExceptionIfResponseError? throwExceptionIfResponseError;

  setUp(() {
    throwExceptionIfResponseError = ThrowExceptionIfResponseError();
  });

  group('Core{Utility class} :[ThrowExceptionIfResponseError]', () {
    test('when errorCode 200 is passed in nothing happens', () async {
      //act
      final callResult = throwExceptionIfResponseError!(statusCode: 200);
      //assert
      expect(callResult, null);
    });
    test('when errorCode 401 is passed in AuthException should be thrown',
        () async {
      //act
      final call = throwExceptionIfResponseError;
      //assert
      expect(
        () => call!(statusCode: 401),
        throwsA(const TypeMatcher<AuthException>()),
      );
    });
    test(
        'when errorCode other than 401/200 is passed in ServerException should be thrown',
        () async {
      //act
      final call = throwExceptionIfResponseError;
      //assert
      expect(
        () => call!(statusCode: 500),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
