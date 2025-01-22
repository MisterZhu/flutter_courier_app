class TaskMapButton {
    TaskMapButton({
        required this.type,
        required this.disable,
        required this.iconName,
        required this.paddingable,
    });

    final String type;
    static const String typeKey = "type";
    
    final bool disable;
    static const String disableKey = "disable";
    
    final String iconName;
    static const String iconNameKey = "iconName";
    
    final bool paddingable;
    static const String paddingableKey = "paddingable";
    

    factory TaskMapButton.fromJson(Map<String, dynamic> json){ 
        return TaskMapButton(
            type: json["type"],
            disable: json["disable"],
            iconName: json["iconName"],
            paddingable: json["paddingable"],
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "disable": disable,
        "iconName": iconName,
        "paddingable": paddingable,
    };

    @override
    String toString(){
        return "$type, $disable, $iconName, $paddingable, ";
    }
}


// 模拟任务
class MockTaskItem {
    MockTaskItem({
        required this.id,
        required this.receivercoordinates,
        required this.orderno,
        required this.sort,
        required this.tasktype,
        required this.thirdnumber,
        required this.latitude,
        required this.longitude,
    });

    final int id;
    static const String idKey = "id";
    
    final String? receivercoordinates;
    static const String receivercoordinatesKey = "receivercoordinates";
    
    final String orderno;
    static const String ordernoKey = "orderno";
    
    final int sort;
    static const String sortKey = "sort";
    
    final int tasktype;
    static const String tasktypeKey = "tasktype";
    
    final String? thirdnumber;
    static const String thirdnumberKey = "thirdnumber";
    
    final double latitude;
    static const String latitudeKey = "latitude";
    
    final double longitude;
    static const String longitudeKey = "longitude";
    

    factory MockTaskItem.fromJson(Map<String, dynamic> json){ 
        return MockTaskItem(
            id: json["id"],
            receivercoordinates: json["receivercoordinates"],
            orderno: json["orderno"],
            sort: json["sort"],
            tasktype: json["tasktype"],
            thirdnumber: json["thirdnumber"],
            latitude: json["latitude"],
            longitude: json["longitude"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "receivercoordinates": receivercoordinates,
        "orderno": orderno,
        "sort": sort,
        "tasktype": tasktype,
        "thirdnumber": thirdnumber,
        "latitude": latitude,
        "longitude": longitude,
    };

    @override
    String toString(){
        return "$id, $receivercoordinates, $orderno, $sort, $tasktype, $thirdnumber, $latitude, $longitude, ";
    }
}
