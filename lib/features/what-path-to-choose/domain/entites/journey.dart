// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class Journey extends Equatable {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final ImageEntity? icon;
  final String? pathName;
  const Journey({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.pathName,
  });
  @override
  List<Object?> get props {
    return [
      id,
      title,
      subtitle,
      description,
      icon,
      pathName,
    ];
  }
}
