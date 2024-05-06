import 'package:dio/dio.dart';
import 'package:e_commerce_app/shared/components/constants.dart';

class DioHelper {
  static late Dio dio ;
  static String url ='http://192.168.1.8/commerce/ecommerce.php';

  static init()async{
    dio = Dio();
  }

  static Future<Response> getData({
    required Map<String,dynamic>data
})async {

    return await dio.get(url , data: data ,queryParameters: data);
  }

  static Future<Response> postData({
    required var formData,
  })async{
    return await dio.post(url,data: formData);
  }

}