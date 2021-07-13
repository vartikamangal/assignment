// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class InstantReliefArea extends Equatable {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? instantReliefName;
  final String? description;
  final String? icon;

  const InstantReliefArea({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.instantReliefName,
    required this.description,
    required this.icon,
  });
  @override
  List<Object?> get props {
    return [
      id,
      title,
      subtitle,
      instantReliefName,
      description,
      icon,
    ];
  }
}
