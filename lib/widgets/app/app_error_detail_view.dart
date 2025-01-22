import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/widgets/base/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// For Testing
class AppErrorDetailView extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;

  const AppErrorDetailView({
    super.key,
    this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    final text = '${error?.toString() ?? ''}\n${stackTrace?.toString() ?? ''}';
    return Scaffold(
      appBar: AppBars.white(
        title: 'Error Detail',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SelectableText(
          text,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.copy_all),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: text));

          DialogUtils.showToast('Copy Success');
        },
      ),
    );
  }
}
