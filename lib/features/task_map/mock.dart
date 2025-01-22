
import 'package:courier_app/api/model/task_map/buttons.dart';

abstract class MockTask {
  static List<MockTaskItem> listArr = [
    MockTaskItem(
      id: 2314889183706184, 
      receivercoordinates: "-26.204751424488716, 28.055914849343008", 
      latitude: -26.204751424488716,
      longitude: 28.055914849343008,
      orderno: "BUFZA4050060128YQ",
      sort: 0,
      tasktype: 1,
      thirdnumber: "BG2205271258844",
    ),
    MockTaskItem(
      id: 2314889183706185, 
      receivercoordinates: "-26.153126169670657, 27.9545162973367", 
      orderno: "BUFZA4050060128YQ",
      sort: 1,
      tasktype: 2,
      thirdnumber: "BG2205271258844",
      latitude: -26.153126169670657,
      longitude: 27.9545162973367,
    ),
    MockTaskItem(
      id: 2314889183706186, 
      receivercoordinates: "-26.267176272947466, 27.94566616022127", 
      latitude: -26.267176272947466,
      longitude: 27.94566616022127,
      orderno: "BUFZA4050060128YQ",
      sort: 0,
      tasktype: 2,
      thirdnumber: "BG2205271258844",
    ),
    MockTaskItem(
      id: 2314889183706187, 
      receivercoordinates: "-26.23586694268239, 28.203356362654326", 
      orderno: "BUFZA4050060128YQ",
      sort: 1,
      tasktype: 1,
      thirdnumber: "BG2205271258844",
      latitude: -26.23586694268239,
      longitude: 28.203356362654326,
    ),
  ];
}