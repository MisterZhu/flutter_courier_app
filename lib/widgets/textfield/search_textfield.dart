import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String hint;
  final ValueChanged<String>? onChanged;
  final Color? backgroundColor;
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    required this.hint,
    this.margin,
    this.onChanged,
    this.backgroundColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      margin: margin ??
          const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: Dimens.borderRadius25,
        color: backgroundColor ?? Colours.greyF5,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 11, 9, 11),
            child: Image.asset(Res.seach_icon, color: Colours.grey83),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 4),
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
