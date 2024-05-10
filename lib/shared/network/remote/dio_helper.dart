import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio ;
  static String url ='http://192.168.43.250/commerce/ecommerce.php';

  static init()async{
    dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required Map<String,dynamic>data ,
  })async {
    return await dio.get(url ,queryParameters: data);
  }

  static Future<Response> postData({
    required var formData,
  })async{
    return await dio.post(url,data: formData);
  }
}