import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/sources/start-journey-remote-service.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/repositories/start-journey-service-impl.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey_started_success.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';


class MockStartJourneyRemoteService extends Mock
    implements StartJourneyRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  MockNetworkInfo networkInfo;
  MockStartJourneyRemoteService remoteService;
  StartJourneyServiceImpl serviceImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockStartJourneyRemoteService();
    serviceImpl = StartJourneyServiceImpl(
      remoteService: remoteService,
      networkInfo: networkInfo,
    );
  });

  const tJourney=JourneyModel(
      id: 1,
      title: "Small Wins Path",
      subtitle: "Weekly focus areas. Choose your own experiences.",
      description: "Only one area of focus per week, Daily small wins at your own pace",
      icon: ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
      pathName: "SMALL_WINS");

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : RemoveIssue', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : RemoveIssue', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }


  //? Actual tests go here
  runTestsOnline(() {
    test('should check if the device is online', () async {
      //act
      await serviceImpl.startJourney(
          journey: tJourney
      );
      //assert
      verify(networkInfo.isConnected);
    });
    test(
        'should return startJourneySuccess if call to remote data source is successfull',
            () async {
          //arrange
          when(remoteService.startJourney(
              journey: tJourney
          )).thenAnswer((_) async => SuccessJourneyStart());
          //act
          final result = await serviceImpl.startJourney(
              journey: tJourney
          );
          //assert
          verify(remoteService.startJourney(
              journey: tJourney
          ));
          expect(result, Right(SuccessJourneyStart()));
        });

    test('should return ServerFailure when the call to remoteService fails',
            () async {
          //arrange
          when(remoteService.startJourney(
              journey: tJourney
          )).thenThrow(ServerException());
          //act
          final result = await serviceImpl.startJourney(
              journey: tJourney
          );
          //assert
          expect(result, Left(ServerFailure()));
        });
  });

  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.startJourney(
          journey: tJourney
      );
      //assert
      expect(result, Left(DeviceOfflineFailure()));
    });
  });

}