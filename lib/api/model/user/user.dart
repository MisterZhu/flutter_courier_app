class User {
  User({
    required this.hubid,
    required this.app,
    required this.expiretime,
    required this.firebasetoken,
    required this.name,
    required this.isfranchise,
    required this.id,
    required this.status,
    required this.serialno,
  });

  final num? hubid;
  final String? app;
  final num? expiretime;
  final String? firebasetoken;
  final String? name;
  final num? isfranchise;
  final num? id;
  final num? status;
  final String? serialno;

  User copyWith({
    num? hubid,
    String? app,
    num? expiretime,
    String? firebasetoken,
    String? name,
    num? isfranchise,
    num? id,
    num? status,
    String? serialno,
  }) {
    return User(
      hubid: hubid ?? this.hubid,
      app: app ?? this.app,
      expiretime: expiretime ?? this.expiretime,
      firebasetoken: firebasetoken ?? this.firebasetoken,
      name: name ?? this.name,
      isfranchise: isfranchise ?? this.isfranchise,
      id: id ?? this.id,
      status: status ?? this.status,
      serialno: serialno ?? this.serialno,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      hubid: json["hubid"],
      app: json["app"],
      expiretime: json["expiretime"],
      firebasetoken: json["firebasetoken"],
      name: json["name"],
      isfranchise: json["isfranchise"],
      id: json["id"],
      status: json["status"],
      serialno: json["serialno"],
    );
  }

  Map<String, dynamic> toJson() => {
        "hubid": hubid,
        "app": app,
        "expiretime": expiretime,
        "firebasetoken": firebasetoken,
        "name": name,
        "isfranchise": isfranchise,
        "id": id,
        "status": status,
        "serialno": serialno,
      };

  @override
  String toString() {
    return "$hubid, $app, $expiretime, $firebasetoken, $name, $isfranchise, $id, $status, $serialno, ";
  }
}
