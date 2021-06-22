// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

class MockBox extends Mock implements Box {}

Future<void> main() async {
  await Hive.initFlutter();

  MockBox box;

  setUp(() {
    box = MockBox();
  });

  const String tString = "Hey I am feeling amazing";
  group('CORE : {Hive - Data Persistence}', () {
    test(
      'should save and retrive value',
      () async {
        /// arrange
        when(box.get(any)).thenAnswer((_) async => tString);

        /// act
        /// assert
        box.put(PersistenceConst.RAPPORT_FEELING_BOX, tString);
        expect(await box.get(PersistenceConst.RAPPORT_FEELING_BOX), tString);
      },
    );
  });
}
