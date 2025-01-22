import 'dart:io';

import 'package:courier_app/features/auth/login/login_page.dart';
import 'package:courier_app/features/main/main_page.dart';
import 'package:courier_app/helpers/cache_helper.dart';
import 'package:courier_app/managers/cache_manager.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/environments.dart';
import 'package:courier_app/res/text_styles.dart';
import 'package:courier_app/widgets/app/app_scroll_behavior.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/refresh/refresh_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheManager.instance.init();
  await Environments.init();
  _configUI();

  runApp(const ProviderScope(child: MyApp()));
}

void _configUI() {
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;

  EasyRefresh.defaultHeaderBuilder =
      () => const ClassicHeader(showMessage: false);
  EasyRefresh.defaultFooterBuilder = () => RefreshFooter(
        showMessage: false,
        noMoreIcon: null,
        noMoreText: 'This is already the bottom of the page',
        textBuilder: (context, state, text) {
          if (state.result == IndicatorResult.noMore) {
            return Texts.small(text, color: Colours.grey99);
          } else {
            return null;
          }
        },
        mainAxisAlignment: MainAxisAlignment.center,
      );

  // 调整Android设备样式
  if (Platform.isAndroid) {
    // 设置透明色的状态栏
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetMaterialApp(
      title: 'Buffalo',
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(primary: Colours.primaryColor),
        useMaterial3: false,
        textTheme: theme.textTheme.apply(
          bodyColor: Colours.primaryTextColor,
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          hintStyle: TextStyles.normal.copyWith(color: Colours.grey99),
        ),
        dividerTheme: theme.dividerTheme.copyWith(
          color: Colours.divider,
          space: 1,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(
                width: 0.5,
                color: Colours.primaryColor,
              ),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled) ? Colors.white : null),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.disabled)
                  ? Colours.disabled
                  : null,
            ),
          ),
        ),
        scaffoldBackgroundColor: Colours.scaffoldBackground,
        appBarTheme: theme.appBarTheme.copyWith(
          foregroundColor: Colours.primaryTextColor,
          titleTextStyle: const TextStyle(
            color: Colours.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: ScrollConfiguration(
            behavior: const AppScrollBehavior(),
            child: child!,
          ),
        );
      }),
      home: _renderHome(),
    );
  }

  Widget _renderHome() {
    // 判断没有ticket的时候, 将界面跳转为LoginPage
    // final ticket = CacheHelper.ticket;
    // if (ticket != null) {
    //   return const MainPage();
    // }
    // return const LoginPage();
    return const MainPage();
  }
}
