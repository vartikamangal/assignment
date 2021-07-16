// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-all-moods.dart';
import 'get-all-moods_test.mocks.dart';

@GenerateMocks([RapportBuildingRepository])
void main() {
  late MockRapportBuildingRepository repository;
  late GetAllMoods useCase;

  setUp(() {
    repository = MockRapportBuildingRepository();
    useCase = GetAllMoods(repository: repository);
  });

  const tMoods = <Mood>[
    Mood(
      moodName: "Very sad",
      moodId: 1,
      moodDescription: "Very sad",
      moodIcon: null,
    ),
    Mood(
      moodName: "Sad",
      moodId: 2,
      moodDescription: "Sad",
      moodIcon: null,
    ),
    Mood(
      moodName: "Normal",
      moodId: 3,
      moodDescription: "Normal",
      moodIcon: null,
    ),
    Mood(
      moodName: "Happy",
      moodId: 4,
      moodDescription: "Happy",
      moodIcon: null,
    ),
    Mood(
      moodName: "Very happy",
      moodId: 5,
      moodDescription: "Very happy",
      moodIcon: null,
    ),
  ];

  group("USECASE : getAllMoods()", () {
    test('should get all the possible moods from the repository', () async {
      //arrange
      when(repository.getAllMoods())
          .thenAnswer((_) async => const Right(tMoods));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getAllMoods());
      expect(result, const Right(tMoods));
    });
  });
}
