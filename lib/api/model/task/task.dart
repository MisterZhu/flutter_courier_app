import 'dart:convert';

class Task {
  final num? sendstatus;
  final num? transitpackageid;
  final num? rwspackageid;
  final num? clientid;
  final num? selfpickflg;
  final String? lostreason;
  final num? selfpickhubid;
  final num? receivecityid;
  final num? storehouseid;
  final num? id;
  final String? expressnumber;
  final num? rtsstatus;
  final num? hubid;
  final num? courierbillcollectid;
  final String? receiver;
  final num? picktype;
  final num? holdtype;
  final num? remoteareastatus;
  final num? packages;
  final num? version;
  final num? lockuserid;
  final String? expresscompanyexpressnumber;
  final String? receivertelephone;
  final num? ordertype;
  final num? expressextendid;
  final num? bookingdeliverytime;
  final num? expressreceivetime;
  final String? sendcompany;
  final num? finishtime;
  final num? billid;
  final String? pickpin;
  final num? createuserid;
  final num? sendareaid;
  final String? receiveraddress;
  final String? receiveaddress2;
  final num? rwsreport;
  final num? deliveryareaid;
  final num? courierbillid;
  final num? createtime;
  final num? shelfid;
  final num? adminclientid;
  final num? returndate;
  final String? thirdnumber;
  final String? receivecity;
  final num? systemsignin;
  final String? receivetelephone;
  final num? smallparcel;
  final num? holdcheck;
  final String? packagenumber;
  final num? paystatus;
  final num? franchiseid;
  final num? possiblelostflag;
  final num? updatetime;
  final num? discardssign;
  final String? slottime;
  final String? booking;
  final String? orderno;
  final num? packageid;
  final num? codmoney;
  final num? expresscompanyid;
  final String? rwstrunklineno;
  final num? areaid;
  final num? expresscostid;
  final num? checkstatus;
  final num? customertype;
  final num? tasktype;
  final num? errorstatus;
  final num? prepayflg;
  final TaskDatas? datas;
  final String? receivecountry;
  final num? lostflg;
  final num? transportmode;
  final num? returntype;
  final num? weight;
  final num? sort;
  final String? receivesuburb;
  final num? returnproblemflag;
  final String? receivepostcode;
  final num? pickareaid;
  final num? rwshubid;
  final num? heavyfreightflg;
  final String? blnumber;
  final String? receiveraddress2;
  final String? receivecoordinates;
  final num? returnstatus;
  final num? delaytime;
  final String? receiveaddress;
  final String? receiveemail;
  final num? deliveryflag;
  final num? courierid;
  final String? senderaddress;
  final num? packageemergency;
  final String? receivercoordinates;
  final num? deliveryrfid;
  final num? deliverabletime;
  final num? takealotdcid;
  final num? selfpicktime;
  final num? nextsiteid;
  final String? color;
  bool? db_table_task_new; //以本地数据库为准，只有pickup任务有新件，接口数据和本地数据库相比，新增的为新件
  num? db_table_task_sort;
  num? db_table_task_id;
  Task({
    this.sendstatus,
    this.transitpackageid,
    this.rwspackageid,
    this.clientid,
    this.selfpickflg,
    this.lostreason,
    this.selfpickhubid,
    this.receivecityid,
    this.storehouseid,
    this.id,
    this.expressnumber,
    this.rtsstatus,
    this.hubid,
    this.courierbillcollectid,
    this.receiver,
    this.picktype,
    this.holdtype,
    this.remoteareastatus,
    this.packages,
    this.version,
    this.lockuserid,
    this.expresscompanyexpressnumber,
    this.receivertelephone,
    this.ordertype,
    this.expressextendid,
    this.bookingdeliverytime,
    this.expressreceivetime,
    this.sendcompany,
    this.finishtime,
    this.billid,
    this.pickpin,
    this.createuserid,
    this.sendareaid,
    this.receiveraddress,
    this.receiveaddress2,
    this.rwsreport,
    this.deliveryareaid,
    this.courierbillid,
    this.createtime,
    this.shelfid,
    this.adminclientid,
    this.returndate,
    this.thirdnumber,
    this.receivecity,
    this.systemsignin,
    this.receivetelephone,
    this.smallparcel,
    this.holdcheck,
    this.packagenumber,
    this.paystatus,
    this.franchiseid,
    this.possiblelostflag,
    this.updatetime,
    this.discardssign,
    this.slottime,
    this.booking,
    this.orderno,
    this.packageid,
    this.codmoney,
    this.expresscompanyid,
    this.rwstrunklineno,
    this.areaid,
    this.expresscostid,
    this.checkstatus,
    this.customertype,
    this.tasktype,
    this.errorstatus,
    this.prepayflg,
    this.datas,
    this.receivecountry,
    this.lostflg,
    this.transportmode,
    this.returntype,
    this.weight,
    this.sort,
    this.receivesuburb,
    this.returnproblemflag,
    this.receivepostcode,
    this.pickareaid,
    this.rwshubid,
    this.heavyfreightflg,
    this.blnumber,
    this.receiveraddress2,
    this.receivecoordinates,
    this.returnstatus,
    this.delaytime,
    this.receiveaddress,
    this.receiveemail,
    this.deliveryflag,
    this.courierid,
    this.senderaddress,
    this.packageemergency,
    this.receivercoordinates,
    this.deliveryrfid,
    this.deliverabletime,
    this.takealotdcid,
    this.selfpicktime,
    this.nextsiteid,
    this.color,
    this.db_table_task_new = false,
    this.db_table_task_sort,
    this.db_table_task_id,
  });

  Task copyWith({
    num? sendstatus,
    num? transitpackageid,
    num? rwspackageid,
    num? clientid,
    num? selfpickflg,
    String? lostreason,
    num? selfpickhubid,
    num? receivecityid,
    num? storehouseid,
    num? id,
    String? expressnumber,
    num? rtsstatus,
    num? hubid,
    num? courierbillcollectid,
    String? receiver,
    num? picktype,
    num? holdtype,
    num? remoteareastatus,
    num? packages,
    num? version,
    num? lockuserid,
    String? expresscompanyexpressnumber,
    String? receivertelephone,
    num? ordertype,
    num? expressextendid,
    num? bookingdeliverytime,
    num? expressreceivetime,
    String? sendcompany,
    num? finishtime,
    num? billid,
    String? pickpin,
    num? createuserid,
    num? sendareaid,
    String? receiveraddress,
    String? receiveaddress2,
    num? rwsreport,
    num? deliveryareaid,
    num? courierbillid,
    num? createtime,
    num? shelfid,
    num? adminclientid,
    num? returndate,
    String? thirdnumber,
    String? receivecity,
    num? systemsignin,
    String? receivetelephone,
    num? smallparcel,
    num? holdcheck,
    String? packagenumber,
    num? paystatus,
    num? franchiseid,
    num? possiblelostflag,
    num? updatetime,
    num? discardssign,
    String? slottime,
    String? booking,
    String? orderno,
    num? packageid,
    num? codmoney,
    num? expresscompanyid,
    String? rwstrunklineno,
    num? areaid,
    num? expresscostid,
    num? checkstatus,
    num? customertype,
    num? tasktype,
    num? errorstatus,
    num? prepayflg,
    TaskDatas? datas,
    String? receivecountry,
    num? lostflg,
    num? transportmode,
    num? returntype,
    num? weight,
    num? sort,
    String? receivesuburb,
    num? returnproblemflag,
    String? receivepostcode,
    num? pickareaid,
    num? rwshubid,
    num? heavyfreightflg,
    String? blnumber,
    String? receiveraddress2,
    String? receivecoordinates,
    num? returnstatus,
    num? delaytime,
    String? receiveaddress,
    String? receiveemail,
    num? deliveryflag,
    num? courierid,
    String? senderaddress,
    num? packageemergency,
    String? receivercoordinates,
    num? deliveryrfid,
    num? deliverabletime,
    num? takealotdcid,
    num? selfpicktime,
    num? nextsiteid,
    String? color,
    bool? db_table_task_new,
    num? db_table_task_sort,
    num? db_table_task_id,
  }) {
    return Task(
      sendstatus: sendstatus ?? this.sendstatus,
      transitpackageid: transitpackageid ?? this.transitpackageid,
      rwspackageid: rwspackageid ?? this.rwspackageid,
      clientid: clientid ?? this.clientid,
      selfpickflg: selfpickflg ?? this.selfpickflg,
      lostreason: lostreason ?? this.lostreason,
      selfpickhubid: selfpickhubid ?? this.selfpickhubid,
      receivecityid: receivecityid ?? this.receivecityid,
      storehouseid: storehouseid ?? this.storehouseid,
      id: id ?? this.id,
      expressnumber: expressnumber ?? this.expressnumber,
      rtsstatus: rtsstatus ?? this.rtsstatus,
      hubid: hubid ?? this.hubid,
      courierbillcollectid: courierbillcollectid ?? this.courierbillcollectid,
      receiver: receiver ?? this.receiver,
      picktype: picktype ?? this.picktype,
      holdtype: holdtype ?? this.holdtype,
      remoteareastatus: remoteareastatus ?? this.remoteareastatus,
      packages: packages ?? this.packages,
      version: version ?? this.version,
      lockuserid: lockuserid ?? this.lockuserid,
      expresscompanyexpressnumber:
          expresscompanyexpressnumber ?? this.expresscompanyexpressnumber,
      receivertelephone: receivertelephone ?? this.receivertelephone,
      ordertype: ordertype ?? this.ordertype,
      expressextendid: expressextendid ?? this.expressextendid,
      bookingdeliverytime: bookingdeliverytime ?? this.bookingdeliverytime,
      expressreceivetime: expressreceivetime ?? this.expressreceivetime,
      sendcompany: sendcompany ?? this.sendcompany,
      finishtime: finishtime ?? this.finishtime,
      billid: billid ?? this.billid,
      pickpin: pickpin ?? this.pickpin,
      createuserid: createuserid ?? this.createuserid,
      sendareaid: sendareaid ?? this.sendareaid,
      receiveraddress: receiveraddress ?? this.receiveraddress,
      receiveaddress2: receiveaddress2 ?? this.receiveaddress2,
      rwsreport: rwsreport ?? this.rwsreport,
      deliveryareaid: deliveryareaid ?? this.deliveryareaid,
      courierbillid: courierbillid ?? this.courierbillid,
      createtime: createtime ?? this.createtime,
      shelfid: shelfid ?? this.shelfid,
      adminclientid: adminclientid ?? this.adminclientid,
      returndate: returndate ?? this.returndate,
      thirdnumber: thirdnumber ?? this.thirdnumber,
      receivecity: receivecity ?? this.receivecity,
      systemsignin: systemsignin ?? this.systemsignin,
      receivetelephone: receivetelephone ?? this.receivetelephone,
      smallparcel: smallparcel ?? this.smallparcel,
      holdcheck: holdcheck ?? this.holdcheck,
      packagenumber: packagenumber ?? this.packagenumber,
      paystatus: paystatus ?? this.paystatus,
      franchiseid: franchiseid ?? this.franchiseid,
      possiblelostflag: possiblelostflag ?? this.possiblelostflag,
      updatetime: updatetime ?? this.updatetime,
      discardssign: discardssign ?? this.discardssign,
      slottime: slottime ?? this.slottime,
      booking: booking ?? this.booking,
      orderno: orderno ?? this.orderno,
      packageid: packageid ?? this.packageid,
      codmoney: codmoney ?? this.codmoney,
      expresscompanyid: expresscompanyid ?? this.expresscompanyid,
      rwstrunklineno: rwstrunklineno ?? this.rwstrunklineno,
      areaid: areaid ?? this.areaid,
      expresscostid: expresscostid ?? this.expresscostid,
      checkstatus: checkstatus ?? this.checkstatus,
      customertype: customertype ?? this.customertype,
      tasktype: tasktype ?? this.tasktype,
      errorstatus: errorstatus ?? this.errorstatus,
      prepayflg: prepayflg ?? this.prepayflg,
      datas: datas ?? this.datas,
      receivecountry: receivecountry ?? this.receivecountry,
      lostflg: lostflg ?? this.lostflg,
      transportmode: transportmode ?? this.transportmode,
      returntype: returntype ?? this.returntype,
      weight: weight ?? this.weight,
      sort: sort ?? this.sort,
      receivesuburb: receivesuburb ?? this.receivesuburb,
      returnproblemflag: returnproblemflag ?? this.returnproblemflag,
      receivepostcode: receivepostcode ?? this.receivepostcode,
      pickareaid: pickareaid ?? this.pickareaid,
      rwshubid: rwshubid ?? this.rwshubid,
      heavyfreightflg: heavyfreightflg ?? this.heavyfreightflg,
      blnumber: blnumber ?? this.blnumber,
      receiveraddress2: receiveraddress2 ?? this.receiveraddress2,
      receivecoordinates: receivecoordinates ?? this.receivecoordinates,
      returnstatus: returnstatus ?? this.returnstatus,
      delaytime: delaytime ?? this.delaytime,
      receiveaddress: receiveaddress ?? this.receiveaddress,
      receiveemail: receiveemail ?? this.receiveemail,
      deliveryflag: deliveryflag ?? this.deliveryflag,
      courierid: courierid ?? this.courierid,
      senderaddress: senderaddress ?? this.senderaddress,
      packageemergency: packageemergency ?? this.packageemergency,
      receivercoordinates: receivercoordinates ?? this.receivercoordinates,
      deliveryrfid: deliveryrfid ?? this.deliveryrfid,
      deliverabletime: deliverabletime ?? this.deliverabletime,
      takealotdcid: takealotdcid ?? this.takealotdcid,
      selfpicktime: selfpicktime ?? this.selfpicktime,
      nextsiteid: nextsiteid ?? this.nextsiteid,
      color: color ?? this.color,
      db_table_task_new: db_table_task_new ?? this.db_table_task_new,
      db_table_task_sort: db_table_task_sort ?? this.db_table_task_sort,
      db_table_task_id: db_table_task_id ?? this.db_table_task_id,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      sendstatus: json["sendstatus"],
      transitpackageid: json["transitpackageid"],
      rwspackageid: json["rwspackageid"],
      clientid: json["clientid"],
      selfpickflg: json["selfpickflg"],
      lostreason: json["lostreason"],
      selfpickhubid: json["selfpickhubid"],
      receivecityid: json["receivecityid"],
      storehouseid: json["storehouseid"],
      id: json["id"],
      expressnumber: json["expressnumber"],
      rtsstatus: json["rtsstatus"],
      hubid: json["hubid"],
      courierbillcollectid: json["courierbillcollectid"],
      receiver: json["receiver"],
      picktype: json["picktype"],
      holdtype: json["holdtype"],
      remoteareastatus: json["remoteareastatus"],
      packages: json["packages"],
      version: json["version"],
      lockuserid: json["lockuserid"],
      expresscompanyexpressnumber: json["expresscompanyexpressnumber"],
      receivertelephone: json["receivertelephone"],
      ordertype: json["ordertype"],
      expressextendid: json["expressextendid"],
      bookingdeliverytime: json["bookingdeliverytime"],
      expressreceivetime: json["expressreceivetime"],
      sendcompany: json["sendcompany"],
      finishtime: json["finishtime"],
      billid: json["billid"],
      pickpin: json["pickpin"],
      createuserid: json["createuserid"],
      sendareaid: json["sendareaid"],
      receiveraddress: json["receiveraddress"],
      receiveaddress2: json["receiveaddress2"],
      rwsreport: json["rwsreport"],
      deliveryareaid: json["deliveryareaid"],
      courierbillid: json["courierbillid"],
      createtime: json["createtime"],
      shelfid: json["shelfid"],
      adminclientid: json["adminclientid"],
      returndate: json["returndate"],
      thirdnumber: json["thirdnumber"],
      receivecity: json["receivecity"],
      systemsignin: json["systemsignin"],
      receivetelephone: json["receivetelephone"],
      smallparcel: json["smallparcel"],
      holdcheck: json["holdcheck"],
      packagenumber: json["packagenumber"],
      paystatus: json["paystatus"],
      franchiseid: json["franchiseid"],
      possiblelostflag: json["possiblelostflag"],
      updatetime: json["updatetime"],
      discardssign: json["discardssign"],
      slottime: json["slottime"],
      booking: json["booking"],
      orderno: json["orderno"],
      packageid: json["packageid"],
      codmoney: json["codmoney"],
      expresscompanyid: json["expresscompanyid"],
      rwstrunklineno: json["rwstrunklineno"],
      areaid: json["areaid"],
      expresscostid: json["expresscostid"],
      checkstatus: json["checkstatus"],
      customertype: json["customertype"],
      tasktype: json["tasktype"],
      errorstatus: json["errorstatus"],
      prepayflg: json["prepayflg"],
      datas: TaskDatas.fromJsonString(json["datas"]),
      receivecountry: json["receivecountry"],
      lostflg: json["lostflg"],
      transportmode: json["transportmode"],
      returntype: json["returntype"],
      weight: json["weight"],
      sort: json["sort"],
      receivesuburb: json["receivesuburb"],
      returnproblemflag: json["returnproblemflag"],
      receivepostcode: json["receivepostcode"],
      pickareaid: json["pickareaid"],
      rwshubid: json["rwshubid"],
      heavyfreightflg: json["heavyfreightflg"],
      blnumber: json["blnumber"],
      receiveraddress2: json["receiveraddress2"],
      receivecoordinates: json["receivecoordinates"],
      returnstatus: json["returnstatus"],
      delaytime: json["delaytime"],
      receiveaddress: json["receiveaddress"],
      receiveemail: json["receiveemail"],
      deliveryflag: json["deliveryflag"],
      courierid: json["courierid"],
      senderaddress: json["senderaddress"],
      packageemergency: json["packageemergency"],
      receivercoordinates: json["receivercoordinates"],
      deliveryrfid: json["deliveryrfid"],
      deliverabletime: json["deliverabletime"],
      takealotdcid: json["takealotdcid"],
      selfpicktime: json["selfpicktime"],
      nextsiteid: json["nextsiteid"],
      color: json["color"],
      db_table_task_new: json["db_table_task_new"],
      db_table_task_sort: json["db_table_task_sort"],
      db_table_task_id: json["db_table_task_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sendstatus": sendstatus,
        "transitpackageid": transitpackageid,
        "rwspackageid": rwspackageid,
        "clientid": clientid,
        "selfpickflg": selfpickflg,
        "lostreason": lostreason,
        "selfpickhubid": selfpickhubid,
        "receivecityid": receivecityid,
        "storehouseid": storehouseid,
        "id": id,
        "expressnumber": expressnumber,
        "rtsstatus": rtsstatus,
        "hubid": hubid,
        "courierbillcollectid": courierbillcollectid,
        "receiver": receiver,
        "picktype": picktype,
        "holdtype": holdtype,
        "remoteareastatus": remoteareastatus,
        "packages": packages,
        "version": version,
        "lockuserid": lockuserid,
        "expresscompanyexpressnumber": expresscompanyexpressnumber,
        "receivertelephone": receivertelephone,
        "ordertype": ordertype,
        "expressextendid": expressextendid,
        "bookingdeliverytime": bookingdeliverytime,
        "expressreceivetime": expressreceivetime,
        "sendcompany": sendcompany,
        "finishtime": finishtime,
        "billid": billid,
        "pickpin": pickpin,
        "createuserid": createuserid,
        "sendareaid": sendareaid,
        "receiveraddress": receiveraddress,
        "receiveaddress2": receiveaddress2,
        "rwsreport": rwsreport,
        "deliveryareaid": deliveryareaid,
        "courierbillid": courierbillid,
        "createtime": createtime,
        "shelfid": shelfid,
        "adminclientid": adminclientid,
        "returndate": returndate,
        "thirdnumber": thirdnumber,
        "receivecity": receivecity,
        "systemsignin": systemsignin,
        "receivetelephone": receivetelephone,
        "smallparcel": smallparcel,
        "holdcheck": holdcheck,
        "packagenumber": packagenumber,
        "paystatus": paystatus,
        "franchiseid": franchiseid,
        "possiblelostflag": possiblelostflag,
        "updatetime": updatetime,
        "discardssign": discardssign,
        "slottime": slottime,
        "booking": booking,
        "orderno": orderno,
        "packageid": packageid,
        "codmoney": codmoney,
        "expresscompanyid": expresscompanyid,
        "rwstrunklineno": rwstrunklineno,
        "areaid": areaid,
        "expresscostid": expresscostid,
        "checkstatus": checkstatus,
        "customertype": customertype,
        "tasktype": tasktype,
        "errorstatus": errorstatus,
        "prepayflg": prepayflg,
        "datas": datas,
        "receivecountry": receivecountry,
        "lostflg": lostflg,
        "transportmode": transportmode,
        "returntype": returntype,
        "weight": weight,
        "sort": sort,
        "receivesuburb": receivesuburb,
        "returnproblemflag": returnproblemflag,
        "receivepostcode": receivepostcode,
        "pickareaid": pickareaid,
        "rwshubid": rwshubid,
        "heavyfreightflg": heavyfreightflg,
        "blnumber": blnumber,
        "receiveraddress2": receiveraddress2,
        "receivecoordinates": receivecoordinates,
        "returnstatus": returnstatus,
        "delaytime": delaytime,
        "receiveaddress": receiveaddress,
        "receiveemail": receiveemail,
        "deliveryflag": deliveryflag,
        "courierid": courierid,
        "senderaddress": senderaddress,
        "packageemergency": packageemergency,
        "receivercoordinates": receivercoordinates,
        "deliveryrfid": deliveryrfid,
        "deliverabletime": deliverabletime,
        "takealotdcid": takealotdcid,
        "selfpicktime": selfpicktime,
        "nextsiteid": nextsiteid,
        "color": color,
        "db_table_task_new": db_table_task_new,
        "db_table_task_sort": db_table_task_sort,
        "db_table_task_id": db_table_task_id,
      };

  @override
  String toString() {
    return "$sendstatus, $transitpackageid, $rwspackageid, $clientid, $selfpickflg, $lostreason, $selfpickhubid, $receivecityid, $storehouseid, $id, $expressnumber, $rtsstatus, $hubid, $courierbillcollectid, $receiver, $picktype, $holdtype, $remoteareastatus, $packages, $version, $lockuserid, $expresscompanyexpressnumber, $receivertelephone, $ordertype, $expressextendid, $bookingdeliverytime, $expressreceivetime, $sendcompany, $finishtime, $billid, $pickpin, $createuserid, $sendareaid, $receiveraddress, $receiveaddress2, $rwsreport, $deliveryareaid, $courierbillid, $createtime, $shelfid, $adminclientid, $returndate, $thirdnumber, $receivecity, $systemsignin, $receivetelephone, $smallparcel, $holdcheck, $packagenumber, $paystatus, $franchiseid, $possiblelostflag, $updatetime, $discardssign, $slottime, $booking, $orderno, $packageid, $codmoney, $expresscompanyid, $rwstrunklineno, $areaid, $expresscostid, $checkstatus, $customertype, $tasktype, $errorstatus, $prepayflg, $datas, $receivecountry, $lostflg, $transportmode, $returntype, $weight, $sort, $receivesuburb, $returnproblemflag, $receivepostcode, $pickareaid, $rwshubid, $heavyfreightflg, $blnumber, $receiveraddress2, $receivecoordinates, $returnstatus, $delaytime, $receiveaddress, $receiveemail, $deliveryflag, $courierid, $senderaddress, $packageemergency, $receivercoordinates, $deliveryrfid, $deliverabletime, $takealotdcid, $selfpicktime, $nextsiteid, $color, $db_table_task_new,$db_table_task_sort, $db_table_task_id,";
  }
}

class TaskDatas {
  TaskDatas({
    this.typestr,
    this.geo,
    this.totaltime,
    this.lefttime,
  });

  final String? typestr;
  final String? geo;
  final String? totaltime;
  final String? lefttime;

  TaskDatas copyWith({
    String? typestr,
    String? geo,
    String? totaltime,
    String? lefttime,
  }) {
    return TaskDatas(
      typestr: typestr ?? this.typestr,
      geo: geo ?? this.geo,
      totaltime: totaltime ?? this.totaltime,
      lefttime: lefttime ?? this.lefttime,
    );
  }

  factory TaskDatas.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    return TaskDatas(
      typestr: json["typestr"],
      geo: json["geo"],
      totaltime: json["totaltime"],
      lefttime: json["lefttime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "typestr": typestr,
        "geo": geo,
        "totaltime": totaltime,
        "lefttime": lefttime,
      };

  @override
  String toString() {
    return "$typestr, $geo, $totaltime, $lefttime, ";
  }
}
