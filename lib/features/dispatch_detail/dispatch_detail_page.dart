import 'dart:io';
import 'dart:typed_data';

import 'package:courier_app/api/model/task/task.dart';
import 'package:courier_app/features/dispatch_detail/widgets/order_card.dart';
import 'package:courier_app/features/dispatch_detail/widgets/receiver_card.dart';
import 'package:courier_app/features/dispatch_detail/widgets/return_bottom_sheet.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/location_utils.dart';
import 'package:courier_app/utils/permission_utils.dart';
import 'package:courier_app/utils/utils.dart';
import 'package:courier_app/widgets/add_picture/add_picture_widget.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/bottombutton/two_button_bottom.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

class DispatchDetailPage extends StatefulWidget {
  final Task taskData;
  const DispatchDetailPage({
    super.key,
    required this.taskData,
  });

  @override
  State<DispatchDetailPage> createState() => _DispatchDetailPageState();
}

class _DispatchDetailPageState extends State<DispatchDetailPage> {
  final TextEditingController _orderNoController = TextEditingController();
  final AddPicturesController _picturesController = AddPicturesController();

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBarTitle: 'Dispatch Detail',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReceiverCard(taskData: widget.taskData),
                  OrderCard(
                    taskData: widget.taskData,
                    orderNoController: _orderNoController,
                    picturesController: _picturesController,
                  ),
                ],
              ),
            ),
          ),
          TwoButtonBottom(
            leftWidget: Texts.larger('Return',
                color: Colors.white, fontWeight: FontWeight.w600),
            rightWidget: Texts.larger('Sign',
                color: Colors.white, fontWeight: FontWeight.w600),
            height: 50,
            isBorder: false,
            leftBackgroundColor: Colours.taskRedColor,
            rightBackgroundColor: Colours.taskBussiness1,
            onLeftTap: () {
              _showReturnForReasonDialog();
            },
            onRightTap: () {
              _showSignDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showReturnForReasonDialog() {
    ReturnBottomSheet.show();
  }

  void _showSignDialog() async {
    // 获取当前位置
    final canUseLocation = await PermissionUtils.checkLocationPermission();
    if (!canUseLocation) {
      return;
    }

    // 获取当前定位信息
    Position? position = await LocationUtils().getCurrentLocation();
    if (position != null) {
      debugPrint('Position: ${position.toJson()}');
    }

    // 读取图片路径
    final imagePathArr = _picturesController.getPath();
    debugPrint("imagePathArr: $imagePathArr");

    // 获取应用程序的沙盒目录
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    // 构建要复制到的目标目录
    Directory destinationDirectory = Directory(
        '${appDocumentsDirectory.path}/dispatch_detail/id_${widget.taskData.id}');
    // 创建目标目录（如果不存在）
    if (!destinationDirectory.existsSync()) {
      destinationDirectory.createSync(recursive: true);
    }

    final newImagePathArr = [];
    // 遍历文件地址列表，复制文件到目标目录
    for (String imagePath in imagePathArr) {
      File imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        // 新文件路径
        String fileName =
            '${Utils.getUuid()}.${imageFile.path.split('.').last}';
        File destinationFile =
            File('${destinationDirectory.path}/sign/$fileName');
        newImagePathArr.add(destinationFile);
        // 压缩
        Uint8List imageBytes = await imageFile.readAsBytes();
        int quality = 90; // 质量
        double maxLength = 1024 * 1024 * 0.5; // 0.5m
        while (imageBytes.length > maxLength && quality > 0) {
          imageBytes = await FlutterImageCompress.compressWithList(
            imageBytes,
            quality: quality,
          );
          debugPrint('压缩后大小: ${imageBytes.length / 1024 / 1024}MB');
          quality -= 2;
        }
        // 将压缩后的数据写入新文件
        destinationFile.writeAsBytesSync(imageBytes);
        debugPrint(
            'Compressed and copied $imagePath to ${destinationFile.path}');
      } else {
        debugPrint('Image $imagePath does not exist');
      }
    }

    debugPrint('newImagePathArr: $newImagePathArr');

    // DialogUtils.showPrimaryGradientDialog(
    //   content:
    //       "Your Location is far away from parcel's Coordinate，do you think the Parcel's Coordinate need change to now your location？",
    //   negativeText: "Sign & Save\ncoordinates",
    //   positiveText: "Just Sign",
    // );
  }
}
