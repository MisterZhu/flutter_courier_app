import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavUtils {
  static Future<T?>? to<T>(
    Widget page, {
    String? routeName,
    Transition? transition,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
  }) {
    return Get.to<T>(
      page,
      routeName: routeName,
      transition: transition,
      fullscreenDialog: fullscreenDialog,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?>? toNamed<T>(
    Widget page, {
    String? routeName,
    Transition? transition,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
  }) {
    return Get.to<T>(
      page,
      routeName: routeName,
      transition: transition,
      fullscreenDialog: fullscreenDialog,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?>? off<T>(
    Widget page, {
    String? routeName,
    Transition? transition,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
  }) {
    return Get.off<T>(page,
        routeName: routeName,
        transition: transition,
        fullscreenDialog: fullscreenDialog,
        preventDuplicates: preventDuplicates);
  }

  static Future<T?>? offAll<T>(
    Widget page, {
    String? routeName,
    Transition? transition,
    bool fullscreenDialog = false,
  }) {
    return Get.offAll<T>(
      page,
      routeName: routeName,
      transition: transition,
      fullscreenDialog: fullscreenDialog,
    );
  }

  static void popUtil(RoutePredicate predicate) => Get.until(predicate);

  static void back<T>({T? result}) => Get.back<T>(result: result);
}
