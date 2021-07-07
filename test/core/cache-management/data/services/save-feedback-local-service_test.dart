import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/save-feedback-local-service.dart';
import 'save-feedback-local-service_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  MockBox localClient;
  late SaveFeedbackLocalServiceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = SaveFeedbackLocalServiceImpl(
      localClient: localClient,
    );
  });

  group('DATA services for save feedback on local service', () {
    test(
        'If should return unit when setfeeling is called',
            () async {
          //act
          final result = await remoteDataSourceImpl.setFeeling(
              subjetcId: "subjetcId",
              activityType: "activityType",
              textFeedback: "textFeedback",
              voiceNote: "voiceNote",
              timeOfCreation: "timeOfCreation",
              boxKey: "boxKey");
          //assert
          expect(result, unit);
        });
  });

}