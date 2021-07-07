import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/app-last-opened-log-service.dart';
import 'app-last-opened-log-service_test.mocks.dart';

@GenerateMocks([Box])

Future<void> main() async{
MockBox localClient;
late AppLastOpenedLogLocalServiceImpl remoteDataSourceImpl;

setUp(() {
  localClient = MockBox();
  remoteDataSourceImpl = AppLastOpenedLogLocalServiceImpl(
    localClient: localClient,
  );
});

const tunit=unit;
final DateTime tDate=DateTime.parse(
  DateTime.march as String,
);

group('DATA services for log start date and time', () {
  test(
      'If should return unit when logStartDatetime is called',
          () async {
        //act
        final result = await remoteDataSourceImpl.logStartDatetime(
        );
        //assert
        expect(result, tunit);
      });
});

// group('DATA services for retrieve last opened date and time', () {
//   test(
//       'If should return dateand time when retrieveLastLog is called',
//           () async {
//         //act
//         final result = await remoteDataSourceImpl.retrieveLastLog(
//         );
//         //assert
//         expect(result, DateTime.parse("1995-07-20 20:18:04" as String));
//       });
// });

}