// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/profile-data.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/usecases/get-basic-profile-details.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';
import 'get-basic-profile-details_test.mocks.dart';

@GenerateMocks([ProfileDetailsRepository])
void main() {
  late MockProfileDetailsRepository repository;
  late GetBasicProfileDetails useCase;

  setUp(() {
    repository = MockProfileDetailsRepository();
    useCase = GetBasicProfileDetails(repository: repository);
  });

  final tProfileData = ProfileData(
      subjectInformationId: 24944,
      travellerId: 'd0ba7d82-ad7f-4a1f-902c-8da2629f2369',
      holisticScore: 1,
      activitiesThisWeek: 1,
      timeOnActivitiesThisWeek: 15,
      nickName: 'dsfsd',
      focusIssues: <IssueModel>[
        IssueModel(
            issueId: 1,
            focusName: 'SLEEP',
            displayName: 'Sleep',
            messageOnSelection:
                'I want to sleep better. More, restful, deeper sleep for my mind and my body',
            issueIcon: ImageModel.fromDomain(ImageEntity(
                type: 'png',
                url: 'https://images.tatsam.in/Logo+512+x+512.png')))
      ],
      journeyPath: JourneyModel(
          id: 1,
          title: 'Small Wins Path',
          subtitle: 'Weekly focus areas. Choose your own experiences.',
          description:
              'Only one area of focus per week, Daily small wins at your own pace',
          icon: ImageModel.fromDomain(ImageEntity(
              type: 'png', url: 'https://images.tatsam.in/Logo+512+x+512.png')),
          pathName: 'SMALL_WINS'));

  group("USECASE : getBasicProfileDetails()", () {
    test('should get basic profile data from the repository', () async {
      //arrange
      when(repository.getBasicProfileDetails())
          .thenAnswer((_) async => Right(tProfileData));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getBasicProfileDetails());
      expect(result, Right(tProfileData));
    });
  });
}
