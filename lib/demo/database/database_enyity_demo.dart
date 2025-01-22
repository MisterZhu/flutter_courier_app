class DatabaseEntityDemo {
  int id;
  int sort;
  String name;
  String description;

  DatabaseEntityDemo({
    required this.id,
    required this.sort,
    required this.name,
    required this.description,
  });

  factory DatabaseEntityDemo.fromMapToModel(Map<String, dynamic> mapa) =>
      DatabaseEntityDemo(
        id: mapa["id"],
        sort: mapa["sort"],
        name: mapa["name"],
        description: mapa["description"],
      );

  factory DatabaseEntityDemo.fromJson(Map<String, dynamic> mapa) =>
      DatabaseEntityDemo(
        id: mapa["id"],
        sort: mapa["sort"],
        name: mapa["name"],
        description: mapa["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sort": sort,
        "name": name,
        "description": description,
      };
}
