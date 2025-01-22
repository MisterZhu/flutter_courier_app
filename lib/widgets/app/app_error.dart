import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/environments.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/app/app_error_detail_view.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final Color? color;
  final VoidCallback? retry;
  final Object? error;
  final StackTrace? stackTrace;

  const AppError({
    super.key,
    this.color,
    this.retry,
    this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    final messageWidget = Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Texts.small(
        'Please check the network and try again later',
        color: Colours.grey99,
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: retry,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Res.app_error_nowifi),
            Texts.largest('Network issues'),
            Environments.debugMode
                ? GestureDetector(
                    child: messageWidget,
                    onDoubleTap: () => NavUtils.to(
                      AppErrorDetailView(
                        error: error,
                        stackTrace: stackTrace,
                      ),
                    ),
                  )
                : messageWidget,
            TextButton(
              onPressed: retry,
              child: Texts.normal(
                'reconnect',
                color: Colours.primaryColor,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
