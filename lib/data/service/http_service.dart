import 'package:employees/core/common/result.dart';

class HttpResponse {
  final int statusCode;
  final dynamic data;

  const HttpResponse(this.statusCode, this.data);
}

abstract interface class HttpService {
  AsyncResult<HttpResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
  AsyncResult<HttpResponse> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
  });
  AsyncResult<HttpResponse> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
  });
  AsyncResult<HttpResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
