// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/usecases/get-basic-profile-details.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

class MockProfileDetailsRepository extends Mock
    implements ProfileDetailsRepository {}

void main() {
  MockProfileDetailsRepository repository;
  GetBasicProfileDetails useCase;

  setUp(() {
    repository = MockProfileDetailsRepository();
    useCase = GetBasicProfileDetails(repository: repository);
  });

  const tProfileData = ProfileData(
      subjectInformationId: 0,
      travellerId: '',
      holisticScore: 0,
      activitiesThisWeek: 0,
      timeOnActivitiesThisWeek: 0,
      nickName: '',
      focusIssues: [
        IssueModel(
            issueId: 0,
            focusName: '',
            displayName: '',
            messageOnSelection: '',
            issueIcon: ImageProp())
      ],
      journeyPath: JourneyModel(
          id: 0,
          title: '',
          subtitle: '',
          description: '',
          icon: ImageProp(),
          pathName: ''));

  group("USECASE : getBasicProfileDetails()", () {
    test('should get basic profile data from the repository', () async {
      //arrange
      when(repository.getBasicProfileDetails())
          .thenAnswer((_) async => const Right(tProfileData));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getBasicProfileDetails());
      expect(result, const Right(tProfileData));
    });
  });
}
