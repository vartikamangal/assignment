import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:matcher/matcher.dart';
import 'retrieve-most-recent-activity-local-service_test.mocks.dart';

@GenerateMocks([Box])
Future<void> main() async {
  late MockBox? localClient;
  late RetrieveMostRecentActivityLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    localDataSourceImpl = RetrieveMostRecentActivityLocalDataSourceImpl(
      localClient: localClient!,
    );
  });

  const tCacheActivityModel = CacheAcitivityModel(
    id: null,
    title: '',
    subtitle: '',
    icon: null,
  );

  group('DATA SOURCE : retrieveMostRecentActivity', () {
    // test('should retrieve most recent activity from the service', () async {
    //   //arrange
    //   when(localClient!.get(PersistenceConst.MOST_RECENT_ACITIVITY))
    //       .thenAnswer((_) async => tCacheActivityModel);
    //   //act
    //   final result = await localDataSourceImpl.retrieveActivity();
    //   print(localClient!.get(PersistenceConst.MOST_RECENT_ACITIVITY) as String);
    //   //assert
    //   verify(localClient!.get(PersistenceConst.MOST_RECENT_ACITIVITY));
    //   expect(result, tCacheActivityModel);
    // });

    test('should throw CacheException when retrieveActivity is failed',
            () async {
          //arrange
          when(localClient!.get(PersistenceConst.MOST_RECENT_ACITIVITY))
              .thenThrow(CacheException());
          //act
          final call = localDataSourceImpl.retrieveActivity();
          //assert
          expect(() => call, throwsA(const TypeMatcher<CacheException>()));
        });
  });
}