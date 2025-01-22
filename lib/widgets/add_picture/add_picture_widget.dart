import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../res.dart';
import '../../res/colours.dart';
import '../../utils/dialog_utils.dart';
import '../base/texts.dart';

class AddPicturesController {
  Function? _reset;
  List<String> Function()? _getPath;

  void reset() {
    _reset?.call();
  }

  List<String> getPath() {
    return _getPath?.call() ?? [];
  }
}

class AddPictureWidget extends StatefulWidget {
  final int crossAxisCount;
  final int picturesCount;
  final AddPicturesController? controller;

  const AddPictureWidget(
      {super.key,
      required this.crossAxisCount,
      required this.picturesCount,
      this.controller})
      : assert(crossAxisCount > 0);

  @override
  State<AddPictureWidget> createState() => _AddPictureWidgetState();
}

class _AddPictureWidgetState extends State<AddPictureWidget> {
  final List<String> mainPictures = [];

  @override
  void initState() {
    for (int i = 0; i < widget.picturesCount; i++) {
      mainPictures.add('');
    }
    super.initState();

    widget.controller?._reset = () {
      _clear();
    };

    widget.controller?._getPath = () => getPath();
  }

  List<String> getPath() {
    return mainPictures;
  }

  void _clear() {
    for (int i = 0; i < mainPictures.length; i++) {
      mainPictures[i] = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 12),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mainPictures.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: widget.crossAxisCount),
        itemBuilder: (c, i) {
          return mainPictures[i] == ''
              ? GestureDetector(
                  onTap: () {
                    _addPictures(pos: i);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(Res.add_pictures_circle),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          Texts.small('Add pictures')
                        ],
                      )
                    ],
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(File(mainPictures[i]),
                              fit: BoxFit.fill),
                        )),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              mainPictures[i] = '';
                            });
                          },
                          child: Image.asset(Res.file_delete),
                        ))
                  ],
                );
        });
  }

  final double _menuButtonHeight = 54;

  void _addPictures({required int pos}) {
    DialogUtils.showBottomSheet(
        isScrollControlled: true,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                Get.back();
                // 校验相机权限
                bool permissionState = await _checkCameraPermission();
                if (!permissionState) return;
                // 选择图片
                await _handleCameraImage(pos);
              },
              child: Container(
                alignment: Alignment.center,
                height: _menuButtonHeight,
                child: Texts.large('Camera', color: Colours.titleColor),
              ),
            ),
            const Divider(thickness: 0.5, color: Colours.greyF5),
            GestureDetector(
              onTap: () async {
                Get.back();
                // 校验相机权限
                bool permissionState = await _checkAssetsPermission();
                if (!permissionState) return;
                // 选择图片
                await _handleSelectImage(pos);
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: _menuButtonHeight,
                child: Texts.large('Album'),
              ),
            ),
            const Divider(thickness: 0.5, color: Colours.greyF5),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: _menuButtonHeight,
                child: Texts.large('Browse'),
              ),
            ),
            Container(
              height: 12,
              color: Colours.greyF5,
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: _menuButtonHeight,
                child: Texts.large('Cancel', color: Colours.titleColor),
              ),
            )
          ],
        ));
  }

  Future<bool> _checkCameraPermission() async {
    final PermissionStatus status;
    if (Platform.isAndroid) {
      // android
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      // android 12及以下
      await Permission.camera.request();
      status = await Permission.camera.status;
    } else {
      // iOS
      await Permission.camera.request();
      status = await Permission.camera.status;
    }
    if (status.isGranted == false) {
      // 展示跳转设置的弹窗
      DialogUtils.showPrimaryDialog(
        content: 'Please enable camera permissions in setting.',
        positiveText: 'Go to setting',
        negativeText: 'Cancel',
        positiveAction: () {
          openAppSettings();
        },
      );
      return false;
    }
    return true;
  }

  Future _handleSelectImage(int pos) async {
    debugPrint('选择文件');
    try {
      // Pick an image.
      final List<AssetEntity>? resultFiles = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(
          themeColor: Colours.primaryColor,
          maxAssets: 1,
          requestType: RequestType.image,
        ),
      );

      if (resultFiles?.isNotEmpty == true && resultFiles?.length == 1) {
        // 获取选择的文件
        AssetEntity item = resultFiles![0];
        // 获取原始文件
        File imageFile = (await item.originFile)!;

        // 文件路径
        final filePath = imageFile.path;
        mainPictures[pos] = filePath;

        setState(() {});
      } else {
        throw Exception('Select Image Error Or Select Cancel');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future _handleCameraImage(int pos) async {
    debugPrint('选择文件');
    try {
      // Pick an image.
      final AssetEntity? resultFiles =
          await CameraPicker.pickFromCamera(context);
      if (resultFiles == null) return;
      File? imgFile = await resultFiles.file;
      if (imgFile == null) return;
      mainPictures[pos] = imgFile.path;

      setState(() {});
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> _checkAssetsPermission() async {
    final PermissionStatus status;
    if (Platform.isAndroid) {
      // android
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        // android 12及以下
        await Permission.storage.request();
        status = await Permission.storage.status;
      } else {
        // android 12 以上
        await Permission.photos.request();
        status = await Permission.photos.status;
      }
    } else {
      // iOS
      await Permission.photos.request();
      status = await Permission.photos.status;
    }
    if (status.isGranted == false) {
      // 展示跳转设置的弹窗
      DialogUtils.showPrimaryDialog(
        content: 'Please enable photo album permissions in setting.',
        positiveText: 'Go to setting',
        negativeText: 'Cancel',
        positiveAction: () {
          openAppSettings();
        },
      );
      return false;
    }
    return true;
  }
}
