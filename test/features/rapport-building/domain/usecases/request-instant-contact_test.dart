// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/contact-info.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/request-instant-contact-success.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/request-instant-contact-service.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/request-instant-contact.dart';

class MockRequestInstantContactService extends Mock
    implements RequestInstantContactService {}

void main() {
  MockRequestInstantContactService service;
  RequestInstantContact useCase;

  setUp(() {
    service = MockRequestInstantContactService();
    useCase = RequestInstantContact(service: service);
  });

  const tContactInfo = ContactInfo(
    personName: 'Naariyappa Tauwwle',
    contactInfo: "+91-9182773319",
    email: "N/A",
  );

  const tRequestSuccess = RequestInstantContactSuccess();

  group('USECASE : requestInstantContact', () {
    test('''
    should give a list of government 
            assigned helpline numbers to the user''', () async {
      //arrange
      when(service.requestInstantContactService(contactInfo: tContactInfo))
          .thenAnswer((_) async => const Right(tRequestSuccess));
      //act
      final result = await useCase(
          const RequestInstantContactParams(contactInfo: tContactInfo));
      //assert
      verify(service.requestInstantContactService(contactInfo: tContactInfo));
      expect(result, const Right(tRequestSuccess));
    });
  });
}
