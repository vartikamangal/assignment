import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/repository/voicenotes-player-repository.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/usecases/get-player-stats.dart';
import 'get-player-stats_test.mocks.dart';

@GenerateMocks([VoiceNotesPlayerRepository])

void main() {
  MockVoiceNotesPlayerRepository? repository;
  late GetPlayerStats useCase;

  setUp(() {
    repository = MockVoiceNotesPlayerRepository();
    useCase = GetPlayerStats(voiceNotesPlayerRepository: repository!);
  });
  const Stream<PlayerStats>? tPlayerStats = null;

  group('USECASE: getPlayerStats()', () {
    // test('Should get player stats from the repository', () async {
    //   when(repository!.getPlayerStats()).thenAnswer(((_) async =>
    //           Right(tPlayerStats!))
    //       as Future<Either<Failure, Stream<PlayerStats>>> Function(Invocation));
    //
    //   final Either<Failure, Stream<PlayerStats>>? result =
    //       await useCase(NoParams());
    //   verify(repository!.getPlayerStats());
    //   expect(result, const Right(tPlayerStats));
    // });
  });
}
