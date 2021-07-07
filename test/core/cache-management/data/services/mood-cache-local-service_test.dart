import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/mood-cache-local-service.dart';
import 'mood-cache-local-service_test.mocks.dart';

@GenerateMocks([Box])

void main(){
  MockBox localClient;
  late MoodCacheLocalServiceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = MoodCacheLocalServiceImpl(
      localClient: localClient,
    );
  });

  const tCachedMoodModel=CachedMoodModel(moodId: 1,
      moodName: "Neutral",
      moodDescription: "moodDescription",
      moodIcon: null);

  group('DATA services for most recent cached mood', () {
    test(
        'If should return unit when cachemood is called',
            () async {
          //act
          final result = await remoteDataSourceImpl.cacheMood(cachedMoodModel: tCachedMoodModel
          );
          //assert
          expect(result, unit);
        });
  });

}