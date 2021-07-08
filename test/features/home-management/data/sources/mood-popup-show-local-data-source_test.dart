import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/mood-popup-shown-local-data-source.dart';
import 'mood-popup-show-local-data-source_test.mocks.dart';

@GenerateMocks([Box])

Future<void> main() async{
  MockBox ? localClient;
  late MoodPopupShownLocalDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = MoodPopupShownLocalDataSourceImpl(
      localClient: localClient,
    );
  });

  group('DATA services for log start date and time', () {
    test(
        'If should return unit when get moodpopupshownstatus called is called',
            () async {
          //act
          when(localClient!.get(PersistenceConst.MOOD_POPUP_SHOWN)).thenAnswer((_) async
          {
            true;

            final result = await remoteDataSourceImpl.getMoodPopupShownStatus();
            //assert
            expect(result, CacheException);
          });

        });
  });

}