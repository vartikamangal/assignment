// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-areas-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/success-prioritize.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/usecases/prioritize.dart';
import 'prioritize_test.mocks.dart';

@GenerateMocks([WheelOfLifeRepository])
void main() {
  late MockWheelOfLifeRepository? service;
  late Prioritize useCase;

  setUp(() {
    service = MockWheelOfLifeRepository();
    useCase = Prioritize(service: service!);
  });

  const tAreas = [
    LifeAreaModel(
      areaCode: "CAREER",
      description: 'Your job, business and aspirations',
      name: 'Career',
    ),
    LifeAreaModel(
      areaCode: "FINANCES",
      description: 'Your relationship with money',
      name: 'Finances',
    ),
    LifeAreaModel(
      areaCode: "HEALTH",
      description: 'Your body, sickness and wellness',
      name: 'Health',
    ),
    LifeAreaModel(
      areaCode: "FAMILY_AND_FRIENDS",
      description: 'Relationships in your life',
      name: 'Family and Friends',
    ),
    LifeAreaModel(
      areaCode: "ROMANCE",
      description: 'Romantic love and partnership',
      name: 'Romance',
    ),
    LifeAreaModel(
      areaCode: "PERSONAL_GROWTH",
      description: 'Aims, goals and aspirations',
      name: 'Personal Growth',
    ),
    LifeAreaModel(
      areaCode: "FUN_AND_RECREATION",
      description: 'Entertainment and leisure',
      name: 'Fun and Recreation',
    ),
    LifeAreaModel(
      areaCode: "PHYSICAL_ENVIRONMENT",
      description: 'Your surroundings',
      name: 'Physical Environment',
    ),
  ];

  const tPrioritizedAreas = LifeAreaForPrioritization(lifeaAreas: tAreas);
  final tSuccess = SuccessPrioritize();

  group('USECASE : prioritize', () {
    test('should set the lifeArea priorities of user through service',
        () async {
      //arrange
      when(service!.prioritize(lifeAreas: tPrioritizedAreas))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result =
          await useCase(const PrioritizeParams(priorities: tPrioritizedAreas));
      //assert
      verify(service!.prioritize(lifeAreas: tPrioritizedAreas));
      expect(result, Right(tSuccess));
    });
  });
}
