import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retireve-last-logged-app-init.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

class MockLogLastOpenedAppService extends Mock
    implements LogLastOpenedAppService {}

void main() {
  late MockLogLastOpenedAppService service;
  late RetirieveLastLoggedAppInit useCase;

  setUp(() {
    service = MockLogLastOpenedAppService();
    useCase = RetirieveLastLoggedAppInit(service: service);
  });

  final tLastLog = DateTime.now();
  group('USECASE: service.retrieveLastLog()', () {
    test('should retireve last logged app init ...', () async {
      when(service.retrieveLastLog()).thenAnswer((_) async => Right(tLastLog));

      final result = await useCase(NoParams());

      verify(service.retrieveLastLog());
      expect(result, Right(tLastLog));
    });
  });
}
