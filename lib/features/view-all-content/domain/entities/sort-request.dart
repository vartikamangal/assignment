import 'entity.dart';

class SortRequest extends Entity {
  final bool unsorted;
  final bool sorted;
  final bool empty;

  SortRequest({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  SortRequest.empty()
      : unsorted = true,
        sorted = false,
        empty = true;
}
