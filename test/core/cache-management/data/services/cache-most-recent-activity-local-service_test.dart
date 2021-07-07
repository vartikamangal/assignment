import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'cache-most-recent-activity-local-service_test.mocks.dart';

@GenerateMocks([Box])
void main(){
  MockBox localClient;
  late CacheMostRecentAcitivityLocalServiceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = CacheMostRecentAcitivityLocalServiceImpl(
      localClient: localClient,
    );
  });

  const tActivityModel=CacheAcitivityModel(id: "id", title: "title", subtitle: "subtitle", icon: null);

  group('DATA services for most recent activity', () {
    test(
        'If should return unit when cacheactivity is called',
            () async {
          //act
          final result = await remoteDataSourceImpl.cacheActivity(acitivity: tActivityModel
          );
          //assert
          expect(result, unit);
        });
  });
}