import 'package:dio/dio.dart';

class UserNetwork{
  late Dio dio;
  UserNetwork(){
    BaseOptions options = BaseOptions(
      // baseUrl: "https://randomuser.me/api/",
      headers: {
        "authentication":"",
        "x-api-key":""
      },
    );
    dio = Dio(options);
  }
}
Dio network = UserNetwork().dio;