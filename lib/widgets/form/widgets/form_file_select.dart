import 'dart:io';

import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/widgets/form/constants/form_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FormFileSelect extends StatefulWidget {
  // 图文件获取方式(预留字段--------暂未使用)
  // final List<FormFileSourceType>? fileSelectSourceTypes;
  //文件片格式
  final List<FormFileType>? fsFileTypes;
  // 文件个数限制
  final int? fsMaxCount;
  // 文件大小限制 - byte(字节)
  final num? fsMaxFileSize;
  // 文件异常提示
  final String? fsFileExceptionMessage;
  // 选择钩子
  final FormParameterAsyncDynamicCallback? fsOnSelect;
  // 删除钩子
  // 预览回调
  // 列表变更钩子
  final ValueChanged<dynamic>? fsOnSelectedFilesChanged;

  const FormFileSelect({
    super.key,
    // this.uploadSourceTypes = const [
    //   FormFileSourceType.library,
    // ],
    this.fsFileTypes,
    this.fsMaxCount,
    this.fsMaxFileSize,
    this.fsFileExceptionMessage,
    this.fsOnSelect,
    this.fsOnSelectedFilesChanged,
  });

  @override
  State<FormFileSelect> createState() => _FormFileSelectState();
}

class _FormFileSelectState extends State<FormFileSelect> {
  AssetEntity? _selectedFile;
  List<File> _selectedFiles = [];

  // TODO: 目前只处理单张文件的逻辑

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: 84,
          height: 84,
          child: _renderSingleUploadView(),
        ),
      ),
    );
  }

  Widget _renderSingleUploadView() {
    if (_selectedFile != null) {
      return InkWell(
        onTap: () {
          _handleShowImage();
        },
        child: Stack(
          children: [
            Ink.image(
              image:
                  AssetEntityImageProvider(_selectedFile!, isOriginal: false),
              fit: BoxFit.cover,
            ),
            Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    _handleDeleteImage();
                  },
                  child: Image.asset(
                    Res.file_delete,
                    width: 18,
                    height: 18,
                  ),
                )),
          ],
        ),
      );
    }
    return InkWell(
      onTap: () async {
        // 校验相机权限
        bool permissionState = await _checkPermission();
        if (!permissionState) return;
        // 选择图片
        await _handleSelectImage();
      },
      child: Ink.image(image: const AssetImage(Res.file_upload_add)),
    );
  }

  Future _handleSelectImage() async {
    debugPrint('选择文件');
    try {
      // Pick an image.
      final List<AssetEntity>? resultFiles = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          themeColor: Colours.primaryColor,
          maxAssets: widget.fsMaxCount ?? 1,
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
        // 文件大小(byte)
        final fileSize = imageFile.lengthSync();
        // 文件类型
        final fileType = await item.mimeTypeAsync;
        debugPrint('Image File Path: $filePath');
        debugPrint(
            'Image File Size: $fileSize byte, ${fileSize / 1024.0 / 1024.0} mb');
        debugPrint('Image File Type: $fileType');

        // 判断文件大小
        if (widget.fsMaxFileSize! > 0 && widget.fsMaxFileSize! < fileSize) {
          if (widget.fsFileExceptionMessage?.isNotEmpty == true) {
            DialogUtils.showToast(widget.fsFileExceptionMessage ?? '');
          }
          throw Exception('Select Image Size Error');
        }

        // 判断文件格式
        if (widget.fsFileTypes!.isNotEmpty == true &&
            !(widget.fsFileTypes!.any((e) => e.value == fileType))) {
          if (widget.fsFileExceptionMessage?.isNotEmpty == true) {
            DialogUtils.showToast(widget.fsFileExceptionMessage ?? '');
          }
          throw Exception('Select Image Type Error');
        }

        // 设置选择的文件
        _selectedFile = item;
        // 设置回调数组
        _selectedFiles = [imageFile];
        setState(() {});

        // 选择钩子
        if (widget.fsOnSelect != null) {
          bool result = await widget.fsOnSelect?.call(imageFile);
          if (!result) {
            return;
          }
        }

        // 选择完成钩子, 界面展示
        widget.fsOnSelectedFilesChanged?.call(_selectedFiles);
      } else {
        throw Exception('Select Image Error Or Select Cancel');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  void _handleShowImage() {
    // TODO: 设置展示文件的函数钩子
    debugPrint('展示文件');
  }

  void _handleDeleteImage() {
    // TODO: 设置删除文件的函数钩子
    debugPrint('删除文件');
    // 设置选择的文件
    _selectedFile = null;
    // 设置回调数组
    _selectedFiles = [];
    widget.fsOnSelectedFilesChanged?.call([]);
    setState(() {});
  }

  Future<bool> _checkPermission() async {
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
