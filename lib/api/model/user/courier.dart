/*data:{
email:"",//邮箱
name:"",//快递员姓名
image:"",//快递员照片
invCode:"",//邀请码
invUrl:"",//邀请链接
billqty:0,//总数量
billdqty:0,//派件数量
billpqty:0,//取件数量
billcost:0,//总金额
billdcost:0,//派件金额
billpcost:0//取件金额
}*/

class CourierInfo {
  CourierInfo({
    required this.email,
    required this.name,
    required this.image,
    required this.invCode,
    required this.invUrl,
    required this.billqty,
    required this.billdqty,
    required this.billpqty,
    required this.billcost,
    required this.billdcost,
    required this.billpcost,
  });

  final String? email;
  final String? name;
  final String? image;
  final String? invCode;
  final String? invUrl;
  final num? billqty;
  final num? billdqty;
  final num? billpqty;
  final String? billcost;
  final String? billdcost;
  final String? billpcost;

  CourierInfo copyWith({
    String? email,
    String? name,
    String? image,
    String? invCode,
    String? invUrl,
    num? billqty,
    num? billdqty,
    num? billpqty,
    String? billcost,
    String? billdcost,
    String? billpcost,
  }) {
    return CourierInfo(
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      invCode: invCode ?? this.invCode,
      invUrl: invUrl ?? this.invUrl,
      billqty: billqty ?? this.billqty,
      billdqty: billdqty ?? this.billdqty,
      billpqty: billpqty ?? this.billpqty,
      billcost: billcost ?? this.billcost,
      billdcost: billdcost ?? this.billdcost,
      billpcost: billpcost ?? this.billpcost,
    );
  }

  factory CourierInfo.fromJson(Map<String, dynamic> json) {
    return CourierInfo(
      email: json["email"],
      name: json["name"],
      image: json["image"],
      invCode: json["invCode"],
      invUrl: json["invUrl"],
      billqty: json["billqty"],
      billdqty: json["billdqty"],
      billpqty: json["billpqty"],
      billcost: json["billcost"],
      billdcost: json["billdcost"],
      billpcost: json["billpcost"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "image": image,
        "invCode": invCode,
        "invUrl": invUrl,
        "billqty": billqty,
        "billdqty": billdqty,
        "billpqty": billpqty,
        "billcost": billcost,
        "billdcost": billdcost,
        "billpcost": billpcost,
      };

  @override
  String toString() {
    return "$email, $name, $image, $invCode, $invUrl, $billqty, $billdqty, $billpqty, $billcost, $billdcost, $billpcost, ";
  }
}
