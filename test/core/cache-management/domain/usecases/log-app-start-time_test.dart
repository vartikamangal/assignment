import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/log-last-opened-app-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/log-app-start-time.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'log-app-start-time_test.mocks.dart';

@GenerateMocks([LogLastOpenedAppService])
void main() {
  late MockLogLastOpenedAppService service;
  late LogAppStartTime useCase;

  setUp(() {
    service = MockLogLastOpenedAppService();
    useCase = LogAppStartTime(service: service);
  });

  const tUnit = unit;
  group('USECASE: service.logStartDatetime()', () {
    test('Should log app start time', () async {
      when(service.logStartDatetime())
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(NoParams());
      verify(service.logStartDatetime());
      expect(result, const Right(tUnit));
    });
  });
}
