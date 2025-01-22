import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final TextStyle normalStyle;
  final TextStyle highlightStyle;
  final String content;
  final String keyword;

  const HighlightText({
    super.key,
    required this.normalStyle,
    required this.highlightStyle,
    required this.content,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    if (keyword.isEmpty) {
      return Text(
        content,
        style: normalStyle,
      );
    }

    List<TextSpan> spans = [];
    int start = 0;
    int end;
    while ((end = content.indexOf(keyword, start)) != -1) {
      spans.add(
          TextSpan(text: content.substring(start, end), style: normalStyle));
      spans.add(TextSpan(text: keyword, style: highlightStyle));
      start = end + keyword.length;
    }

    spans.add(
      TextSpan(
        text: content.substring(start, content.length),
        style: normalStyle,
      ),
    );

    return RichText(text: TextSpan(children: spans));
  }
}
