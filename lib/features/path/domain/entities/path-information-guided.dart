import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PathInformation extends Equatable {
  final int id;
  final String description;
  final String title;
  final String subtitle;
  final String helpContent;
  final int lengthOfPlan;

  const PathInformation({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.subtitle,
    @required this.helpContent,
    @required this.lengthOfPlan,
  });
  @override
  List<Object> get props {
    return [
      id,
      description,
      title,
      subtitle,
      helpContent,
      lengthOfPlan,
    ];
  }

  @override
  bool get stringify => true;
}
