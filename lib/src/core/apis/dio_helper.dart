import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/api.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiManager.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': token,
          "Connection": "keep-alive",
        };
      }
      dio.options.headers = {
        'Content-Type': 'application/json',
        "Connection": "keep-alive",
      };
      return await dio.post(
        path,
        queryParameters: query,
        data: data,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error posting data: $e');
      }
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      };
      return await dio.put(
        path,
        queryParameters: query,
        data: data,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error putting data: $e');
      }
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }
}