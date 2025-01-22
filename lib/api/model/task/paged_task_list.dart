class PagedTaskList<T> {
  int dutystatus;
  int count;
  int drivertype;
  List<T> tasks;

  PagedTaskList({
    required this.dutystatus,
    required this.count,
    required this.drivertype,
    required this.tasks,
  });

  static PagedTaskList<T> fromJson<T>(
    dynamic map, {
    required T Function(dynamic) modelBuilder,
  }) {
    final List<T> list = [];

    if (map['tasks'] != null) {
      map['tasks'].forEach((e) {
        list.add(modelBuilder(e));
      });
    }

    return PagedTaskList(
      dutystatus: map['dutystatus'] ?? 0,
      drivertype: map['drivertype'] ?? 0,
      count: map['count'] ?? 0,
      tasks: list,
    );
  }
}
