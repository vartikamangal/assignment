// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/get-rating-scale-repository.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/usecases/get-rating-scale.dart';

class MockGetRatingScaleRepository extends Mock
    implements GetRatingScaleRepository {}

void main() {
  MockGetRatingScaleRepository repository;
  GetRatingScale useCase;

  setUp(() {
    repository = MockGetRatingScaleRepository();
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
