import 'package:equatable/equatable.dart';

class SubjectId extends Equatable {
  final String id;

  const SubjectId(this.id);
  @override
  List<Object> get props => [id];
}
