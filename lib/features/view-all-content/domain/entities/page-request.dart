import 'entity.dart';
import 'sort-request.dart';

class PageRequest extends Entity {
  final SortRequest sort;
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool unpaged;

  PageRequest({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });

  PageRequest.page(this.pageNumber, this.pageSize)
      : sort = SortRequest.empty(),
        paged = true,
        unpaged = false,
        offset = pageNumber * pageSize - 1;

  PageRequest.first(int pageSize) : this.page(0, pageSize);

  PageRequest.fromOffset(int pageSize, int offset)
      : this.page((offset + 1) ~/ pageSize, pageSize);
}
