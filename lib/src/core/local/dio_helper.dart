import 'package:dio/dio.dart';
import 'package:hawihub/src/core/apis/api.dart';

class DioHelper{
  static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: ApiManager.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(
          minutes: 10
        ),
      ),
    );
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
  }) async
  {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      "Connection": "keep-alive",
    };
    return dio.post(
      path,
      queryParameters:query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String? token,

  }) async
  {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Authorization': token??'',

    };
    return dio.put(
      path,
      queryParameters:query,
      data: data,
    );
  }
}
