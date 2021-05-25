import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

Future<void> main() async {
  await Hive.initFlutter();

  const String tString = "Hey I am feeling amazing";
  group('CORE : {Hive - Data Persistence}', () {
    test(
      'should save and retrive value',
      () async {
        final box = await Hive.openBox(PersistenceConst.CORE_BOX);
        box.put(PersistenceConst.RAPPORT_FEELING_BOX, tString);
        expect(await box.get(PersistenceConst.RAPPORT_FEELING_BOX), tString);
      },
    );
  });
}
