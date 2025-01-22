import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class AppSimpleEmpty extends StatelessWidget {
  final String message;

  const AppSimpleEmpty({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Texts.small(message, color: Colours.grey99),
    );
  }
}
