import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:employees/core/common/result.dart';

import 'http_service.dart';

class DioService implements HttpService {
  final String baseURL;
  late final Dio _dio;

  DioService({required this.baseURL}) {
    _dio = Dio(BaseOptions(baseUrl: baseURL));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(
            'Method: ${options.method}, URL: ${options.uri}',
            name: 'onRequest',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            'Response: ${response.statusCode}, URL: ${response.requestOptions.uri}',
            name: 'onResponse',
          );
          return handler.next(response);
        },
        onError: (e, handler) {
          log(
            'Error: ${e.response?.statusCode}, URL: ${e.requestOptions.uri}',
            name: 'onError',
          );
          return handler.next(e);
        },
      ),
    );
  }

  @override
  AsyncResult<HttpResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Ok(HttpResponse(response.statusCode ?? 500, response.data));
    } on DioException catch (e) {
      return Ok(HttpResponse(e.response?.statusCode ?? 500, e.response?.data));
    } on Exception catch (e) {
      return Error('Failed to load $path. Reason: $e');
    }
  }

  @override
  AsyncResult<HttpResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Ok(HttpResponse(response.statusCode ?? 500, response.data));
    } on DioException catch (e) {
      return Ok(HttpResponse(e.response?.statusCode ?? 500, e.response?.data));
    } on Exception catch (e) {
      return Error('Failed to load $path. Reason: $e');
    }
  }

  @override
  AsyncResult<HttpResponse> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: switch (body != null) {
          true => jsonEncode(body),
          false => null,
        },
      );
      return Ok(HttpResponse(response.statusCode ?? 500, response.data));
    } on DioException catch (e) {
      return Ok(HttpResponse(e.response?.statusCode ?? 500, e.response?.data));
    } on Exception catch (e) {
      return Error('Failed to load $path. Reason: $e');
    }
  }

  @override
  AsyncResult<HttpResponse> put(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: switch (body != null) {
          true => jsonEncode(body),
          false => null,
        },
      );
      return Ok(HttpResponse(response.statusCode ?? 500, response.data));
    } on DioException catch (e) {
      return Ok(HttpResponse(e.response?.statusCode ?? 500, e.response?.data));
    } on Exception catch (e) {
      return Error('Failed to load $path. Reason: $e');
    }
  }
}
