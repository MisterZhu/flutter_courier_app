import 'package:courier_app/widgets/app/app_error.dart';
import 'package:courier_app/widgets/app/app_loading.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExt<T> on AsyncValue<T> {
  Widget whenExt({
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = false,
    bool skipError = false,
    required Widget Function(T data) data,
    required VoidCallback errorRetry,
    Widget Function()? loading,
  }) =>
      when(
        skipLoadingOnReload: skipLoadingOnReload,
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipError: skipError,
        data: data,
        error: (error, stackTrace) => AppError(
          error: error,
          stackTrace: stackTrace,
          retry: errorRetry,
        ),
        loading: loading ?? () => const AppLoading(),
      );

  Widget whenSilent({
    required Widget Function(T? data) data,
  }) =>
      when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        skipError: true,
        data: data,
        error: (err, _) => data(null),
        loading: () => data(null),
      );
}
