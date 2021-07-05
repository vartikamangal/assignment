// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/life-areas-for-prioritization.dart';
import 'life-area-model.dart';

class LifeAreaModelForPrioritization extends LifeAreaForPrioritization {
  const LifeAreaModelForPrioritization({
    required List<LifeAreaModel> lifeaAreas,
  }) : super(
          lifeaAreas: lifeaAreas,
        );

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> areasJson = [];
    // ignore: avoid_function_literals_in_foreach_calls
    lifeaAreas.forEach((lifeArea) {
      areasJson.add({
        "areaName": lifeArea.areaCode,
        "displayName": lifeArea.name,
        "areaDescription": lifeArea.description,
      });
    });
    return areasJson;
  }
}
