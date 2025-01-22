class PagedList<T> {
  int pageCount;
  int pageSize;
  int recordTotal;
  List<T> list;

  PagedList({
    required this.pageCount,
    required this.pageSize,
    required this.recordTotal,
    required this.list,
  });

  static PagedList<T> fromJson<T>(
    dynamic map, {
    required T Function(dynamic) modelBuilder,
  }) {
    final List<T> list = [];

    if (map['list'] != null) {
      map['list'].forEach((e) {
        list.add(modelBuilder(e));
      });
    }

    return PagedList(
      pageCount: map['pageCount'] ?? 0,
      recordTotal: map['recordTotal'] ?? 0,
      pageSize: map['pagesize'] ?? 0,
      list: list,
    );
  }
}
