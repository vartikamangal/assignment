// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-feeling-local-service.dart';

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

Future<void> main() async {
  final interface = MockHiveInterface();
  await interface.initFlutter();

  MockBox localClient;
  SetSubjectFeelingLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = SetSubjectFeelingLocalServiceImpl(localClient: localClient);
  });

  const tFeeling =
      "Hey I am feeling good. But sometimes just concious of my health.";

  group('DATA SOURCE : SetSubjectFeeling{Local}', () {
    test('should persist the passed data locally with the help of localClient',
        () async {
      //arrange
      when(localClient.put(PersistenceConst.RAPPORT_FEELING_BOX, tFeeling))
          .thenAnswer((_) async => 1);
      //act
      await serviceImpl.setFeeling(feeling: tFeeling);
      //assert
      verify(localClient.put(PersistenceConst.RAPPORT_FEELING_BOX, tFeeling));
    });
    test(
        'should return CacheFailure when some problem occurs in persisting the feeling',
        () async {
      //arrange
      when(localClient.put(PersistenceConst.RAPPORT_FEELING_BOX, tFeeling))
          .thenThrow(CacheException());
      //act
      final call = serviceImpl.setFeeling;
      //assert
      expect(() => call(feeling: tFeeling),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });
}
