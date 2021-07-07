// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/usecases/get-rating-scale.dart';
import 'get-rating-scale_test.mocks.dart';

@GenerateMocks([WheelOfLifeRepository])

void main() {
  late MockWheelOfLifeRepository repository;
  late GetRatingScale useCase;

  setUp(() {
    repository = MockWheelOfLifeRepository();
    useCase = GetRatingScale(repository: repository);
  });

  final tScale =
      RatingScale(min: 0, max: 10, ratingScaleName: null, ratingValue: 0);

  group('USECASE : getRatingScale', () {
    test('should get the RatingScale from the repository', () async {
      //arrange
      when(repository.getRatingScale()).thenAnswer(
        (_) async => Right(tScale),
      );
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getRatingScale());
      expect(result, Right(tScale));
    });
  });
}
