// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/repository/set-subject-name-service-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/sources/set-subject-name-remote-service.dart';

class MockSetSubjectNameRemoteService extends Mock
    implements SetSubjectNameRemoteService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo networkInfo;
  MockSetSubjectNameRemoteService service;
  SetSubjectNameServiceImpl impl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    service = MockSetSubjectNameRemoteService();
    impl = SetSubjectNameServiceImpl(
      service: service,
      networkInfo: networkInfo,
    );
  });

  const tSubjectInfo = SubjectInformationModel(
    subjectId: SubjectIdModel(id: "5a58e827-7c69-4bcc-b40d-5e5c12c5e956"),
    userID: "f43d2341-e0c9-4219-bb6d-252ddd3be26b",
    name: null,
    nickName: "Test User",
    deviceIndentifier: "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER",
    // ignore: avoid_redundant_argument_values
    gender: null,
  );

  const tSubjectName = "Test User";
  const tDeviceID = "THIS_IS_A_RANDOM_DEVICE_IDENTIFIER";

  ///! Actual tests begin here ///

  //? Device Online Tests
  group('DEVICE ONLINE : SetSubjectName', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should check if the device is online', () async {
      //act
      await impl.setSubjectName(
        subjectName: tSubjectName,
      );
      //assert
      verify(networkInfo.isConnected);
    });
    test('should return SubjectInfoModel from data-source', () async {
      //arrange
      when(
        service.setSubjectName(
          name: tSubjectName,
        ),
      ).thenAnswer((_) async => tSubjectInfo);
      //act
      final result = await impl.setSubjectName(
        subjectName: tSubjectName,
      );
      //assert
      verify(
        service.setSubjectName(
          name: tSubjectName,
        ),
      );
      expect(result, const Right(tSubjectInfo));
    });
    test(
        'should return a ServerFailure when call to remoteService is Unsuccessfull',
        () async {
      //arrange
      when(
        service.setSubjectName(
          name: tSubjectName,
        ),
      ).thenThrow(ServerException());
      //act
      final result = await impl.setSubjectName(
        subjectName: tSubjectName,
      );
      //assert
      expect(result, Left(ServerFailure()));
    });
  });

  //? Device Offline Tests
  group('DEVICE OFFLINE : SetSubjectName', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('should return a DeviceOfflineFailure', () async {
      //arrange
      when(service.setSubjectName(name: tSubjectName))
          .thenAnswer((_) async => tSubjectInfo);
      //act
      final result = await impl.setSubjectName(
          subjectName: tSubjectName, deviceId: tDeviceID);
      //assert
      verifyZeroInteractions(service);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
