// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/anonymous-user.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/create-anonymous-user-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/create-anonymous-user.dart';

class MockCreateAnonymousUserService extends Mock
    implements CreateAnonymousUserService {}

void main() {
  MockCreateAnonymousUserService service;
  CreateAnonymousUser useCase;

  setUp(() {
    service = MockCreateAnonymousUserService();
    useCase = CreateAnonymousUser(service: service);
  });

  const String tUserName = "Test User";
  const String tUserID = "a2190Xn2ggW";
  final AnonymousUser tAnonUser =
      AnonymousUser(userId: tUserID, userName: tUserName);
  group("USECASE : createAnonymousUser", () {
    test(
        'should create and return a user with the help of its respective service',
        () async {
      //arrange
      when(service.createAnonymousUser(userName: tUserName))
          .thenAnswer((_) async => Right(tAnonUser));
      //act
      final result =
          await useCase(const CreateAnonymousUserParams(userName: tUserName));
      //assert
      verify(service.createAnonymousUser(userName: tUserName));
      expect(result, Right(tAnonUser));
    });
  });
}
