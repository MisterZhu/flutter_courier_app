import 'base_api_exception.dart';
import 'base_api_resp.dart';

const ssoRespStatusSuccess = '200';
const apiRespCodeSuccess = '0';
const adminRespCodeSuccess = '0';
const uploadFileRespCodeSuccess = '0';

class SsoRespMap<T> {
  final SsoResp<T> resp;

  SsoRespMap(this.resp);

  T map() {
    if (resp.status == ssoRespStatusSuccess) {
      if (resp.data != null) {
        return resp.data!;
      } else {
        return (resp.message ?? '') as T;
      }
    } else {
      throw SsoException(
          status: resp.status, message: resp.message ?? 'Unknown Error');
    }
  }
}

class ApiRespMap<T> {
  final ApiResp<T> resp;

  ApiRespMap(this.resp);

  T map() {
    if (resp.code == apiRespCodeSuccess) {
      if (resp.data != null) {
        return resp.data!;
      } else {
        return (resp.message ?? '') as T;
      }
    } else {
      throw ApiException(
          code: resp.code, message: resp.message ?? 'Unknown Error');
    }
  }
}

class AdminRespMap<T> {
  final AdminResp<T> resp;

  AdminRespMap(this.resp);

  T map() {
    if (resp.code == adminRespCodeSuccess) {
      if (resp.data != null) {
        return resp.data!;
      } else {
        return (resp.message ?? '') as T;
      }
    } else {
      throw AdminException(
          code: resp.code, message: resp.message ?? 'Unknown Error');
    }
  }
}

class UploadFileRespMap<T> {
  final UploadFileResp<T> resp;

  UploadFileRespMap(this.resp);

  T map() {
    if (resp.code == uploadFileRespCodeSuccess) {
      if (resp.data != null) {
        return resp.data!;
      } else {
        return (resp.message ?? '') as T;
      }
    } else {
      throw UploadFileException(
          code: resp.code, message: resp.message ?? 'Unknown Error');
    }
  }
}
