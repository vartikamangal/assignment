import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-most-recent-activity-local-data-source.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'retrieve-most-recent-activity-local-service_test.mocks.dart';

@GenerateMocks([Box])
Future<void> main() async{
  late MockBox? localClient;
  late RetrieveMostRecentActivityLocalDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = RetrieveMostRecentActivityLocalDataSourceImpl(
      localClient: localClient!,
    );
  });

  const tCacheActivityModel=CacheAcitivityModel( id: null,
    title: '',
    subtitle: '',
    icon: null,);

  group('DATA services for most recent activity', () {
    test(
        'If should return unit when retrieveActivity is called',
            () async {
          //act
              when(localClient!.get(PersistenceConst.MOST_RECENT_ACITIVITY)).thenAnswer((_) async{
                null;
                final result = await remoteDataSourceImpl.retrieveActivity();
                //assert
                expect(result, tCacheActivityModel);
              });
        });
  });
}