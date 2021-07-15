// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-name.dart';
import 'set-subject-name_test.mocks.dart';

@GenerateMocks([RapportBuildingRepository])
void main() {
  late MockRapportBuildingRepository? setSubjectNameService;
  late SetSubjectName useCase;

  const SubjectInformation tInfo = SubjectInformation(
    subjectId: SubjectId('xyz'),
    userID: 'jbssww',
    name: 'Test User',
    deviceIndentifier: 'abcd',
    nickName: 'Test User',
    gender: Gender.Male,
  );
  const String tName = 'Test Subject';

  group('USECASE : setSubjectName', () {
    setUp(() {
      setSubjectNameService = MockRapportBuildingRepository();
      useCase = SetSubjectName(service: setSubjectNameService!);
    });
    test('should set the name of user on [API/Local] and return SetNameSuccess',
        () async {
      //arrange
      when(setSubjectNameService!.setSubjectName(subjectName: tName))
          .thenAnswer((_) async => const Right(tInfo));
      //act
      final result = await useCase(const SetSubjectNameParams(name: tName));
      //assert
      expect(result, const Right(tInfo));
    });
  });
}
