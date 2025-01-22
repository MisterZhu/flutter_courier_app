import 'package:easy_refresh/easy_paging.dart';
import 'package:flutter/material.dart';

abstract class ErrorHandlePagingState<DataType, ItemType>
    extends EasyPagingState<DataType, ItemType> {
  Widget? _errorWidget;

  void handleError({required Widget errorWidget}) {
    if (mounted) {
      setState(() {
        _errorWidget = errorWidget;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Offstage(
          offstage: _errorWidget != null,
          child: super.build(context),
        ),
        if (_errorWidget != null) Positioned.fill(child: _errorWidget!),
      ],
    );
  }
}
