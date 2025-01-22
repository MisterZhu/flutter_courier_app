import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'nav_utils.dart';

abstract class DialogUtils {
  static void showLoading([String? message]) => EasyLoading.show(
        status: message,
        maskType: EasyLoadingMaskType.black,
      );

  static void hideLoading() {
    if (isLoadingShowing) {
      EasyLoading.dismiss();
    }
  }

  static bool get isLoadingShowing => EasyLoading.isShow;

  static void showToast(String message, [Duration? duration]) =>
      EasyLoading.showToast(
        message,
        duration: duration ?? const Duration(milliseconds: 2000),
      );

  static void showErrorToast(String message, [Duration? duration]) =>
      EasyLoading.showToast(
        message,
        duration: duration ?? const Duration(milliseconds: 2000),
      );

  static Future<T?> showBottomSheet<T>(
    Widget widget, {
    Color? backgroundColor,
    ShapeBorder shape =
        const RoundedRectangleBorder(borderRadius: Dimens.topBorderRadius24),
    Clip? clipBehavior,
    bool enableDrag = true,
    bool isScrollControlled = false,
  }) =>
      Get.bottomSheet<T>(
        widget,
        backgroundColor: backgroundColor ?? Colours.cardColor,
        shape: shape,
        clipBehavior: clipBehavior,
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
      );

  static Future<T?> showDialog<T>(
      {String? title,
      String? content,
      Widget? contentWidget,
      String? positiveText,
      Function? positiveAction,
      String? negativeText,
      Function? negativeAction,
      bool barrierDismissible = true}) async {
    hideLoading();

    final actions = <Widget>[];

    if (negativeText != null) {
      actions.add(
        Expanded(
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Texts.largeSemiBold(
              negativeText,
              letterSpacing: 0,
            ),
            onPressed: () {
              NavUtils.back();
              negativeAction?.call();
            },
          ),
        ),
      );
    }

    if (positiveText != null) {
      if (actions.isNotEmpty) {
        actions.add(Container(width: 0.5, height: 52, color: Colours.divider));
      }

      actions.add(
        Expanded(
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Texts.largeSemiBold(
              positiveText,
              color: Colours.primaryColor,
              letterSpacing: 0,
            ),
            onPressed: () {
              NavUtils.back();
              positiveAction?.call();
            },
          ),
        ),
      );
    }

    return Get.dialog<T>(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          elevation: 0,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 24.0),
          shape:
              const RoundedRectangleBorder(borderRadius: Dimens.borderRadius8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              title?.isNotEmpty == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 17)),
                    )
                  : const SizedBox(height: 24),
              Padding(
                padding:
                    (content?.isNotEmpty == true) || (contentWidget != null)
                        ? EdgeInsets.only(
                            left: 20,
                            top: title?.isNotEmpty == true ? 15 : 0,
                            right: 20,
                            bottom: 24)
                        : EdgeInsets.zero,
                child: contentWidget ??
                    Texts.largeSemiBold(
                      content ?? '',
                    ),
              ),
              const Divider(),
              Row(children: actions),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }

  static Future<T?> showPrimaryDialog<T>({
    String? title,
    bool showTitleClose = true,
    bool centerTitle = true,
    Widget? titleWidget,
    String? content,
    bool centerContent = true,
    Widget? contentWidget,
    String? negativeText,
    Function? negativeAction,
    Widget? negativeWidget,
    String? positiveText,
    Function? positiveAction,
    Widget? positiveWidget,
    Widget? actionWidget,
    EdgeInsets? padding,
    bool barrierDismissible = true,
  }) async {
    hideLoading();

    // 标题视图
    Widget renderTitleView() {
      if (titleWidget != null) {
        return titleWidget;
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Stack(
            children: [
              title != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Texts.large(
                          title,
                          fontWeight: FontWeight.w600,
                          textAlign:
                              centerTitle ? TextAlign.center : TextAlign.left,
                        ),
                      ),
                    )
                  : const SizedBox(height: 16),
              showTitleClose
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 16, left: 24),
                          child: Image.asset(Res.dialog_close),
                        ),
                        onTap: () => NavUtils.back(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }
    }

    // 内容视图
    Widget renderContentView() {
      if (contentWidget != null) {
        return contentWidget;
      } else {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: content != null
                ? Texts.large(
                    content,
                    fontWeight: FontWeight.w400,
                    textAlign:
                        centerContent ? TextAlign.center : TextAlign.left,
                  )
                : const SizedBox(),
          ),
        );
      }
    }

    // 操作视图
    Widget renderActionView() {
      if (actionWidget != null) {
        return actionWidget;
      } else {
        final actions = <Widget>[];
        Size buttonMinSize = const Size(136.5, 34);
        if (negativeText != null) {
          actions.add(
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: buttonMinSize,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                onPressed: () {
                  NavUtils.back();
                  negativeAction?.call();
                },
                child: Texts.normal(
                  negativeText,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (positiveText != null) {
          actions.add(
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(buttonMinSize),
                ),
                onPressed: () {
                  NavUtils.back();
                  positiveAction?.call();
                },
                child: Texts.normal(
                  positiveText,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (actions.length == 2) {
          actions.insert(
            1,
            const Expanded(
              flex: 0,
              child: SizedBox(
                width: 12,
              ),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions,
        );
      }
    }

    return Get.dialog<T>(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          elevation: 0,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 24.0),
          shape: const RoundedRectangleBorder(
            borderRadius: Dimens.borderRadius8,
          ),
          child: Padding(
            padding: padding ??
                const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 24,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                renderTitleView(),
                renderContentView(),
                renderActionView(),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }

  static Future<T?> showPrimaryGradientDialog<T>({
    String? title,
    bool showTitleClose = false,
    bool centerTitle = true,
    Widget? titleWidget,
    String? content,
    bool centerContent = true,
    Widget? contentWidget,
    String? negativeText,
    Function? negativeAction,
    Widget? negativeWidget,
    String? positiveText,
    Function? positiveAction,
    Widget? positiveWidget,
    Widget? actionWidget,
    EdgeInsets? padding,
    bool barrierDismissible = true,
  }) async {
    hideLoading();

    // 标题视图
    Widget renderTitleView() {
      if (titleWidget != null) {
        return titleWidget;
      } else {
        return Padding(
          padding: EdgeInsets.only(bottom: title != null ? 12 : 0),
          child: Stack(
            children: [
              title != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: Texts.large(
                          title,
                          fontWeight: FontWeight.w600,
                          textAlign:
                              centerTitle ? TextAlign.center : TextAlign.left,
                        ),
                      ),
                    )
                  : const SizedBox(height: 16),
              showTitleClose
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 16, left: 24),
                          child: Image.asset(Res.dialog_close),
                        ),
                        onTap: () => NavUtils.back(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }
    }

    // 内容视图
    Widget renderContentView() {
      if (contentWidget != null) {
        return contentWidget;
      } else {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: content != null ? 16 : 0),
            child: content != null
                ? Texts.large(
                    content,
                    fontWeight: FontWeight.w400,
                    textAlign:
                        centerContent ? TextAlign.center : TextAlign.left,
                  )
                : const SizedBox(),
          ),
        );
      }
    }

    // 操作视图
    Widget renderActionView() {
      if (actionWidget != null) {
        return actionWidget;
      } else {
        final actions = <Widget>[];
        Size buttonMinSize = const Size(136.5, 44);
        if (negativeText != null) {
          actions.add(
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colours.dialogGradientNegativeBgColor),
                  minimumSize: MaterialStateProperty.all(buttonMinSize),
                ),
                onPressed: () {
                  NavUtils.back();
                  negativeAction?.call();
                },
                child: Texts.normal(
                  negativeText,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (positiveText != null) {
          actions.add(
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(buttonMinSize),
                ),
                onPressed: () {
                  NavUtils.back();
                  positiveAction?.call();
                },
                child: Texts.normal(
                  positiveText,
                  letterSpacing: 0,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (actions.length == 2) {
          actions.insert(
            1,
            const Expanded(
              flex: 0,
              child: SizedBox(
                width: 12,
              ),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions,
        );
      }
    }

    return Get.dialog<T>(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          shape: const RoundedRectangleBorder(
            borderRadius: Dimens.borderRadius16,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colours.dialogGradientStartColor,
                        Colours.dialogGradientEndColor,
                      ], // 渐变色
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: padding ??
                    const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 24,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    renderTitleView(),
                    renderContentView(),
                    renderActionView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }

  static Future<T?> showMenuBelowAnchor<T>({
    required BuildContext context,
    required GlobalKey anchorKey,
    required List<PopupMenuEntry<T>> items,
    T? initialValue,
  }) async {
    final RenderBox popupButtonObject =
        anchorKey.currentContext?.findRenderObject() as RenderBox;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(Offset.zero, ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset(0, -popupButtonObject.size.height) & overlay.size,
    );

    return showMenu<T>(
      context: context,
      elevation: 8.0,
      constraints: BoxConstraints(minWidth: popupButtonObject.size.width),
      items: items,
      initialValue: initialValue,
      position: position,
    );
  }
}
