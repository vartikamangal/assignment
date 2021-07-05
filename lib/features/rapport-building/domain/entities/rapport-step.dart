// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class RapportStep extends Equatable {
  final int? id;
  final String? stepTitle;
  final String? stepContent;
  final String? stepHelp;
  final String? stepDescription;
  final int? stepSequence;
  final ImageProp? icon;
  final String? templateName;

  const RapportStep({
    required this.id,
    required this.stepTitle,
    required this.stepContent,
    required this.stepHelp,
    required this.stepDescription,
    required this.stepSequence,
    required this.icon,
    required this.templateName,
  });
  @override
  List<Object?> get props {
    return [
      id,
      stepTitle,
      stepContent,
      stepHelp,
      stepDescription,
      stepSequence,
      icon,
      templateName,
    ];
  }
}
