import 'package:courier_app/api/model/base/base_api_exception.dart';
import 'package:courier_app/api/model/base/base_api_parse_exception.dart';
import 'package:dio/dio.dart';

import 'dialog_utils.dart';

abstract class ApiUtils {
  static Future<void> handleSubmit({
    required Future<void> Function() apiCall,
    String? loadingTitle,
  }) async {
    if (DialogUtils.isLoadingShowing) return;

    DialogUtils.showLoading(loadingTitle);

    try {
      await apiCall();

      DialogUtils.hideLoading();
    } catch (error) {
      handleApiError(error);
    }
  }

  static void handleApiError(dynamic error) {
    DialogUtils.hideLoading();

    if (error is SsoException ||
        error is ApiException ||
        error is AdminException ||
        error is UploadFileException) {
      DialogUtils.showErrorToast(error.message);
    } else if (error is BaseApiException) {
      DialogUtils.showErrorToast(error.message);
    } else if (error is BaseApiParseException) {
      DialogUtils.showErrorToast('Parse error: ${error.toString()}');
    } else {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            // 忽略掉主动Cancel的错误
            return;
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
            DialogUtils.showErrorToast('Timeout');
            return;
          case DioExceptionType.badCertificate:
            DialogUtils.showErrorToast('Bad certificate');
            return;
          case DioExceptionType.badResponse:
            DialogUtils.showErrorToast('Bad response');
            return;
          case DioExceptionType.connectionError:
            DialogUtils.showErrorToast('Connection error');
            return;
          default:
            DialogUtils.showErrorToast('Network unknown error');
            return;
        }
      } else {
        DialogUtils.showErrorToast('Network unknown error');
      }
    }
  }
}
