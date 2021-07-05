// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/cache-manager/data/services/save-feedback-local-service.dart';
import '../../../../core/cache-manager/domain/repositories/save-feedback-service.dart';
import '../../../error/failures.dart';

class SaveFeedbackServiceImpl implements SaveFeedbackService {
  final SaveFeedbackLocalService? localService;
  final BaseRepository baseRepository;

  const SaveFeedbackServiceImpl({
    required this.localService,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, Unit>?> saveFeedback({
    String? subjetcId,
    String? activityType,
    String? textFeedback,
    String? voiceNote,
    String? timeOfCreation,
    String? boxKey,
  }) async {
    return baseRepository(
      () => localService!.setFeeling(
        timeOfCreation: timeOfCreation,
        activityType: activityType,
        voiceNote: voiceNote,
        subjetcId: subjetcId,
        textFeedback: textFeedback,
        boxKey: boxKey,
      ),
    );
  }
}
