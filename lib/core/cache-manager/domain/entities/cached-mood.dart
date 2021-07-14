// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';

class CachedMood extends Equatable {
  final int? moodId;
  final String? moodName;
  final String? moodDescription;
  final ImageEntity? moodIcon;

  const CachedMood({
    required this.moodId,
    required this.moodName,
    required this.moodDescription,
    required this.moodIcon,
  });

  @override
  List<Object?> get props => [moodIcon, moodDescription, moodName];
}
