import 'package:flutter_riverpod/flutter_riverpod.dart';

// duty 切换
final dutyProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
