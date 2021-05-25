import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/image/image.dart';

class QuickAction extends Equatable {
  final int quickActionID;
  final ImageProp icon;
  final String title;
  final String description;

  const QuickAction({
    @required this.quickActionID,
    @required this.icon,
    @required this.title,
    @required this.description,
  });
  @override
  List<Object> get props => [quickActionID, icon, title, description];
}
