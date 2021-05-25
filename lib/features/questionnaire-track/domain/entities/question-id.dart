import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class QuestionId extends Equatable {
  final String id;
  const QuestionId({
    @required this.id,
  });
  @override
  List<Object> get props => [id];

  @override
  bool get stringify => true;
}
