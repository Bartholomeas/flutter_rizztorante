import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio _dio = Dio();

  static final DioClient _singleton = DioClient._internal();
  DioClient._internal();
  factory DioClient() => _singleton;

  //  Get
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (err) {
      if (kDebugMode) print(err.toString());

      rethrow;
    }
  }

  // Post
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response;

    try {
      response = await _dio.post(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      response = _returnResponse(response);
    } catch (err) {
      if (kDebugMode) print(err.toString());
      rethrow;
    }
    return response;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        if (kDebugMode) {
          print(responseJson);
        }
        return responseJson;
      case 400:
        throw Exception('Bad request: ${response.data}');
      case 401:
      case 403:
        throw Exception('Unauthorized: ${response.data}');
      case 500:
        throw Exception('Server error: ${response.data}');
      default:
        throw Exception(
            'Error occurred while communicating with server with StatusCode: ${response.statusCode}');
    }
  }
}
