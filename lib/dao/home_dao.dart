import 'package:flutter_trip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final Uri homeUrl = Uri(scheme: 'https', host: 'apk-1256738511.cos.ap-chengdu.myqcloud.com', path: 'FlutterTrip/data/home_page.json');

class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(homeUrl);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      final result = json.decode(utf8decoder.convert(response.bodyBytes));

      return HomeModel.fromJson(result);
    } else {
      throw Exception('Fail to load home_page');
    }
  }
}