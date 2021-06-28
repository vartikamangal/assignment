import 'package:dartz/dartz.dart';
import 'package:smartlook/smartlook.dart';
import '../error/failures.dart';
import '../secrets.dart';

abstract class SetupAnalytics {
  /// Holds the contract for initially setting up dependencies for the currently being used analytics service
  /// Once the dependencies are setup, Recording should start automatically
  /// Will return [Failure] incase of any exception
  Future<Either<Failure, Unit>> initializeAndStartRecording();

  /// Holds the contract for pasuing the recording on screens containing sesitive data
  /// Will return [Failure] incase of any exception
  Future<Either<Failure, Unit>> disableRendering();

  /// Holds the contract for resuming the session recording service after the sensitive data screen is gone
  /// Will return [Failure] incase of any exception
  Future<Either<Failure, Unit>> enableRendering();
}

class SetupAnalyticsImpl implements SetupAnalytics {
  @override
  Future<Either<Failure, Unit>> initializeAndStartRecording() async {
    try {
      final setupOptions = SetupOptionsBuilder(Secrets.SMARTLOOK_KEY).build();
      await Smartlook.setupAndStartRecording(setupOptions);
      return const Right(unit);
    } catch (e) {
      return Left(AnalyticsInitializationFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> disableRendering() async {
    try {
      await Smartlook.setRenderingMode(SmartlookRenderingMode.no_rendering);
      return const Right(unit);
    } catch (e) {
      return Left(AnalyticsInitializationFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> enableRendering() async {
    try {
      await Smartlook.setRenderingMode(SmartlookRenderingMode.no_rendering);
      return const Right(unit);
    } catch (e) {
      return Left(AnalyticsInitializationFailure());
    }
  }
}
