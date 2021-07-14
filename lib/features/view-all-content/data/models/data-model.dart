// current interface begs the question:
// why don't we rename it to SerializableModel?
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

abstract class DataModel<T extends Entity> {
  Map<String, dynamic> toJson();
  T toDomain();
}