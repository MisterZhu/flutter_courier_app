import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 主界面Tab索引
final mainTabIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

/// 主界面监听登录
class MainLoginNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void onLoginSuccess() {
    state = ++state;
  }
}

final mainLoginSuccessProvider = NotifierProvider.autoDispose<MainLoginNotifier, int>(() {
  return MainLoginNotifier();
});
