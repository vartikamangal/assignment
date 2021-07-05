// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

import '../features/what-path-to-choose/data/sources/get_journey_path_list_remote_data_source_test.dart';

Future<void> main() async {
  await Hive.initFlutter();

  late MockBox box;

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
