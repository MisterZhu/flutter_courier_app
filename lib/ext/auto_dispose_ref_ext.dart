import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AutoDisposeRefExt<State> on AutoDisposeRef<State> {

  CancelToken getDisposeCancelToken() {
    final CancelToken cancelToken = CancelToken();

    onDispose(() => cancelToken.cancel());

    return cancelToken;
  }

}
