import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/image/image.dart';

class Mood extends Equatable {
  final int moodId;
  final String moodName;
  final String moodDescription;
  final ImageProp moodIcon;

  const Mood({
    @required this.moodId,
    @required this.moodName,
    @required this.moodDescription,
    @required this.moodIcon,
  });
  @override
  List<Object> get props => [moodIcon, moodDescription, moodName];
}
