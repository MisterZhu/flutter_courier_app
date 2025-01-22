import 'package:courier_app/api/model/dispatch_detail/reason_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// reason 选项
final selectedReturnReasonOptionProvider =
    StateProvider.autoDispose<ReasonOption?>((ref) {
  return null;
});
