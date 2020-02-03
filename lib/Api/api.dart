
import 'package:http/http.dart' as Http;
import 'dart:convert';

import 'package:mythesis96/Api/apiuse.dart';


// class ApiService {
//   static paymentApi() {
//     var url = "https://api.myjson.com/bins/kabh6";
//     Http.get(url).then((response) {
//       print("Response status: ${response.body}");
//     });
//   }
// }

//  class DogService {
//   static Future<MessageDogsDao> randomDog() async {
//     var url = "https://dog.ceo/api/breeds/image/random";
//     var response = await Http.get(url);
//     Map map = json.decode(response.body);
//     MessageDogsDao msg = MessageDogsDao.fromJson(map);
//     print("URL image = " + msg?.message);
//     return msg;
//   }
// }

 class ApiService {
  static Future<Pay> paymentApi() async {
    var url = "https://api.myjson.com/bins/1968ka";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    Pay msg = Pay.fromJson(map);
    print("สถานะการชำระเงิน " + msg?.message);
    return msg;
  }
}