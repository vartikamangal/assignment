import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cached-mood.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-mood.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/get-cached-mood.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';

class MoodDataCacheController extends GetxController {
  final CacheMood cacheMood;
  final GetCachedMood getCachedMood;

  MoodDataCacheController({
    required this.cacheMood,
    required this.getCachedMood,
  });

  Rxn<CachedMood> mood = Rxn<CachedMoodModel>();

  Future<void> fetchCachedMood() async {
    final failureOrResult = await getCachedMood(NoParams());
    failureOrResult!.fold(
      (f) => ErrorInfo.show(f),
      (r) {
        mood.value = r;
      },
    );
  }

  Future<void> cacheGivenMood({required MoodModel moodModel}) async {
    final failureOrResult = await cacheMood(
      CacheMoodParams(mood: CachedMoodModel.fromMood(moodModel)),
    );
    failureOrResult!.fold(
      (f) => ErrorInfo.show(f),
      (r) => log(unit.toString()),
    );
  }
}
