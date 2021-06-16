// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class CachedMood extends Equatable {
  final int moodId;
  final String moodName;
  final String moodDescription;
  final ImageProp moodIcon;

  const CachedMood({
    @required this.moodId,
    @required this.moodName,
    @required this.moodDescription,
    @required this.moodIcon,
  });
  @override
  List<Object> get props => [moodIcon, moodDescription, moodName];
}
