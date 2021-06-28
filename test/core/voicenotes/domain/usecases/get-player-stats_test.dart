import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-player-stats.dart';

class MockVoicenotesPlayerRepository extends Mock
    implements VoiceNotesPlayerRepository {}

void main() {
  MockVoicenotesPlayerRepository repository;
  GetPlayerStats useCase;

  setUp(() {
    repository = MockVoicenotesPlayerRepository();
    useCase = GetPlayerStats(voiceNotesPlayerRepository: repository);
  });
  const Stream<PlayerStats> tPlayerStats = null;

  group('USECASE: getPlayerStats()', () {
    test('Should get player stats from the repository', () async {
      when(repository.getPlayerStats())
          .thenAnswer((_) async => Right(tPlayerStats));

      final result = await useCase(NoParams());
      verify(repository.getPlayerStats());
      expect(result, Right(tPlayerStats));
    });
  });
}
