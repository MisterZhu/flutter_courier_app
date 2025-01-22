class ReasonSection {
  final String? reason;
  final pid;
  final id;
  final List<ReasonOption> children;

  ReasonSection({
    required this.reason,
    required this.pid,
    required this.id,
    required this.children,
  });

  ReasonSection copyWith({
    String? reason,
    pid,
    id,
    List<ReasonOption>? children,
  }) {
    return ReasonSection(
      reason: reason ?? this.reason,
      pid: pid ?? this.pid,
      id: id ?? this.id,
      children: children ?? this.children,
    );
  }

  factory ReasonSection.fromJson(Map<String, dynamic> json) {
    return ReasonSection(
      reason: json["reason"],
      pid: json["pid"],
      id: json["id"],
      children: json["children"] == null
          ? []
          : List<ReasonOption>.from(
              json["children"]!.map((x) => ReasonOption.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "pid": pid,
        "id": id,
        "children": children.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$reason, $pid, $id, $children, ";
  }
}

class ReasonOption {
  final num? id;
  final num? pid;
  final String? reason;
  final num? image;
  final String? tip;
  final num? date;
  final num? location;
  final num? createtime;
  final num? auto;
  final String? showreason;
  final num? del;
  final num? type;
  final num? version;

  ReasonOption({
    required this.id,
    required this.pid,
    required this.reason,
    required this.image,
    required this.tip,
    required this.date,
    required this.location,
    required this.createtime,
    required this.auto,
    required this.showreason,
    required this.del,
    required this.type,
    required this.version,
  });

  ReasonOption copyWith({
    num? id,
    num? pid,
    String? reason,
    num? image,
    String? tip,
    num? date,
    num? location,
    num? createtime,
    num? auto,
    String? showreason,
    num? del,
    num? type,
    num? version,
  }) {
    return ReasonOption(
      id: id ?? this.id,
      pid: pid ?? this.pid,
      reason: reason ?? this.reason,
      image: image ?? this.image,
      tip: tip ?? this.tip,
      date: date ?? this.date,
      location: location ?? this.location,
      createtime: createtime ?? this.createtime,
      auto: auto ?? this.auto,
      showreason: showreason ?? this.showreason,
      del: del ?? this.del,
      type: type ?? this.type,
      version: version ?? this.version,
    );
  }

  factory ReasonOption.fromJson(Map<String, dynamic> json) {
    return ReasonOption(
      id: json["id"],
      pid: json["pid"],
      reason: json["reason"],
      image: json["image"],
      tip: json["tip"],
      date: json["date"],
      location: json["location"],
      createtime: json["createtime"],
      auto: json["auto"],
      showreason: json["showreason"],
      del: json["del"],
      type: json["type"],
      version: json["version"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pid": pid,
        "reason": reason,
        "image": image,
        "tip": tip,
        "date": date,
        "location": location,
        "createtime": createtime,
        "auto": auto,
        "showreason": showreason,
        "del": del,
        "type": type,
        "version": version,
      };

  @override
  String toString() {
    return "$id, $pid, $reason, $image, $tip, $date, $location, $createtime, $auto, $showreason, $del, $type, $version, ";
  }
}
