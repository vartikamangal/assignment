// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final String name;
  final String tagCategory;
  final String displayName;
  final String parentName;
  const Tag({
    @required this.name,
    @required this.tagCategory,
    @required this.displayName,
    @required this.parentName,
  });

  @override
  List<Object> get props => [name, tagCategory, displayName, parentName];

  @override
  bool get stringify => true;

  Tag copyWith({
    String name,
    String tagCategory,
    String displayName,
    String parentName,
  }) {
    return Tag(
      name: name ?? this.name,
      tagCategory: tagCategory ?? this.tagCategory,
      displayName: displayName ?? this.displayName,
      parentName: parentName ?? this.parentName,
    );
  }
}
