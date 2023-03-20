import 'package:dio/dio.dart';

//=========================== For Dealing With API ===========================
class DioHelper {
  static Dio? dio;

/*

baseUrl: https://newsapi.org/
method (url) : v2/everything?
queries: q=tesla&from=2023-02-19&sortBy=publishedAt&apiKey=API_KEY
 
*/

  //================ For Initializing My API ================
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  //================ For Getting Data Using API ================
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> queries,
  }) async {
    return await dio!.get(url, queryParameters: queries);
  }
}
