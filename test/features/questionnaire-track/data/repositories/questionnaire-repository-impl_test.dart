import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/models/questionnaire-model.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/repositories/questionnaire-repository-impl.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/data/sources/questionnaire-remote-data-source.dart';
import 'questionnaire-repository-impl_test.mocks.dart';

@GenerateMocks([QuestionnaireRemoteDataSource,NetworkInfo])

void main(){
  late MockQuestionnaireRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late  QuestionnaireRepositoryImpl repositoryImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    remoteDataSource = MockQuestionnaireRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryImpl = QuestionnaireRepositoryImpl(
        remoteDataSource: remoteDataSource, baseRepository: baseRepository);

  });


  const tQuestionnaire=QuestionnaireModel(id: "id", name: "name", title: "title", description: "description", creationDate: "creationDate", questionVO:[]);
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getQuestionniare', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getQuestionniare', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await remoteDataSource.getQuestionnaireById();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test(
        'should get basic question naire  when coonection to remote data source is successfull',
            () async {
          //arrange
          when(remoteDataSource!.getQuestionnaireById(id: "id"))
              .thenAnswer((_) async => tQuestionnaire);
          //act
          final result = await remoteDataSource!.getQuestionnaireById(id: "id");
          //assert
          verify(remoteDataSource!.getQuestionnaireById(id: "id"));
          expect(result, tQuestionnaire);
        });
      test('should return ServerFailure when the call to remoteDataSource fails',
              () async {
            //arrange
            when(remoteDataSource!.getQuestionnaireById(id: "id"))
                .thenThrow(ServerException());
            //act
            final result = await repositoryImpl.getQuestionniare(id: "id");
            //assert
            expect(result, Left(ServerFailure()));
          });
    });
    // test(
    //     'DEVICE OFFLINE : getBasicProfileDetails should return DeviceOfflineFailure',
    //         () async {
    //       when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //       //act
    //       final result = await remoteDataSource!.getQuestionnaireById(id: "id");
    //       //assert
    //       expect(result, null);
    //     });

}