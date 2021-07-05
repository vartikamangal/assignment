// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-all-moods.dart';

class MockGetAllMoodsRepository extends Mock
    implements RapportBuildingRepository {}

void main() {
  MockGetAllMoodsRepository repository;
  late GetAllMoods useCase;

  setUp(() {
    repository = MockGetAllMoodsRepository();
    useCase = GetAllMoods(repository: repository);
  });

  const tMoods = <Mood>[
    Mood(
      moodName: "Very sad",
      moodId: 1,
      moodDescription: "Very sad",
      moodIcon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/moods/small/1',
        urlMedium: 'http://cdn.tatsam.in/assets/moods/medium/1',
        urlShort: 'http://cdn.tatsam.in/assets/moods/large/1',
      ),
    ),
    Mood(
      moodName: "Sad",
      moodId: 2,
      moodDescription: "Sad",
      moodIcon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/moods/small/1',
        urlMedium: 'http://cdn.tatsam.in/assets/moods/medium/1',
        urlShort: 'http://cdn.tatsam.in/assets/moods/large/1',
      ),
    ),
    Mood(
      moodName: "Normal",
      moodId: 3,
      moodDescription: "Normal",
      moodIcon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/moods/small/1',
        urlMedium: 'http://cdn.tatsam.in/assets/moods/medium/1',
        urlShort: 'http://cdn.tatsam.in/assets/moods/large/1',
      ),
    ),
    Mood(
      moodName: "Happy",
      moodId: 4,
      moodDescription: "Happy",
      moodIcon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/moods/small/1',
        urlMedium: 'http://cdn.tatsam.in/assets/moods/medium/1',
        urlShort: 'http://cdn.tatsam.in/assets/moods/large/1',
      ),
    ),
    Mood(
      moodName: "Very happy",
      moodId: 5,
      moodDescription: "Very happy",
      moodIcon: ImageProp(
        urlLarge: 'http://cdn.tatsam.in/assets/moods/small/1',
        urlMedium: 'http://cdn.tatsam.in/assets/moods/medium/1',
        urlShort: 'http://cdn.tatsam.in/assets/moods/large/1',
      ),
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
