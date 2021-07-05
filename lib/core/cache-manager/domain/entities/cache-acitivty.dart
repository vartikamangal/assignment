// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class CacheAcitivty extends Equatable {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? icon;
  const CacheAcitivty({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, title, subtitle, icon];
}
