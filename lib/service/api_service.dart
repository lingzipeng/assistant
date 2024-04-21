import 'package:dio/dio.dart';

class APIService {
  static Dio dio = Dio();

  static Future<Response> fetchData() async {
    try {
      Response response = await dio.get('http://localhost:8080/scores/allScoresCensus');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
