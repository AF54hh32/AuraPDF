import 'package:dio/dio.dart';

class DioClient {

  DioClient._();

  static final Dio instance = _create();


  static Dio _create(){

    final dio = Dio(
      BaseOptions(
          baseUrl: "https://generativelanguage.googleapis.com/v1beta",
          receiveTimeout: Duration(seconds: 120),
          connectTimeout:  Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': const String.fromEnvironment('GEMINI_API_KEY', defaultValue: ''),
          },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        }
      )
    );


    return dio;

  }


}