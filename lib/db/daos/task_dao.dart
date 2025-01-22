import 'package:courier_app/db/database_dao_base.dart';
import 'package:flutter/material.dart';

class TaskDao extends DatabaseDaoBase {
  static final TaskDao _instance = TaskDao._();
  static TaskDao get instance => _instance;
  TaskDao._();

  @override
  String tableName = "table_task";

  @override
  onCreate(db, version) async {
    debugPrint("创建 $tableName 数据表");
    await db.execute("""
      CREATE TABLE $tableName (
        db_table_task_id INTEGER PRIMARY KEY AUTOINCREMENT,
        db_table_task_sort INTEGER,
        db_table_task_new INTEGER,
        sendstatus INTEGER,
        transitpackageid INTEGER,
        rwspackageid INTEGER,
        clientid INTEGER,
        selfpickflg INTEGER,
        lostreason TEXT,
        selfpickhubid INTEGER,
        receivecityid INTEGER,
        storehouseid INTEGER,
        id INTEGER,
        expressnumber TEXT,
        rtsstatus INTEGER,
        hubid INTEGER,
        courierbillcollectid INTEGER,
        receiver TEXT,
        picktype INTEGER,
        holdtype INTEGER,
        remoteareastatus INTEGER,
        packages INTEGER,
        version INTEGER,
        lockuserid INTEGER,
        expresscompanyexpressnumber TEXT,
        receivertelephone TEXT,
        ordertype INTEGER,
        expressextendid INTEGER,
        bookingdeliverytime INTEGER,
        expressreceivetime INTEGER,
        sendcompany TEXT,
        finishtime INTEGER,
        billid INTEGER,
        pickpin TEXT,
        createuserid INTEGER,
        sendareaid INTEGER,
        receiveraddress TEXT,
        receiveaddress2 TEXT,
        rwsreport INTEGER,
        deliveryareaid INTEGER,
        courierbillid INTEGER,
        createtime INTEGER,
        shelfid INTEGER,
        adminclientid INTEGER,
        returndate INTEGER,
        thirdnumber TEXT,
        receivecity TEXT,
        systemsignin INTEGER,
        receivetelephone TEXT,
        smallparcel INTEGER,
        holdcheck INTEGER,
        packagenumber TEXT,
        paystatus INTEGER,
        franchiseid INTEGER,
        possiblelostflag INTEGER,
        updatetime INTEGER,
        discardssign INTEGER,
        slottime TEXT,
        booking TEXT,
        orderno TEXT,
        packageid INTEGER,
        codmoney INTEGER,
        expresscompanyid INTEGER,
        rwstrunklineno TEXT,
        areaid INTEGER,
        expresscostid INTEGER,
        checkstatus INTEGER,
        customertype INTEGER,
        tasktype INTEGER,
        errorstatus INTEGER,
        prepayflg INTEGER,
        datas TEXT,
        receivecountry TEXT,
        lostflg INTEGER,
        transportmode INTEGER,
        returntype INTEGER,
        weight INTEGER,
        sort INTEGER,
        receivesuburb TEXT,
        returnproblemflag INTEGER,
        receivepostcode TEXT,
        pickareaid INTEGER,
        rwshubid INTEGER,
        heavyfreightflg INTEGER,
        blnumber TEXT,
        receiveraddress2 TEXT,
        receivecoordinates TEXT,
        returnstatus INTEGER,
        delaytime INTEGER,
        receiveaddress TEXT,
        receiveemail TEXT,
        deliveryflag INTEGER,
        courierid INTEGER,
        senderaddress TEXT,
        packageemergency INTEGER,
        receivercoordinates TEXT,
        deliveryrfid INTEGER,
        deliverabletime INTEGER,
        takealotdcid INTEGER,
        selfpicktime INTEGER,
        nextsiteid INTEGER,
        color TEXT,
      )
    """);
  }

  @override
  onUpgrade(db, oldVersion, newVersion) {
    debugPrint('onUpgrade -> oldVersion: $oldVersion, newVersion: $newVersion');
  }

  @override
  onDowngrade(db, oldVersion, newVersion) {
    debugPrint(
        'onDowngrade -> oldVersion: $oldVersion, newVersion: $newVersion');
  }
}
