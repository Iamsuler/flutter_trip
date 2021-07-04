import 'package:flutter_trip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final Uri homeUrl = Uri(scheme: 'https', host: 'www.devio.org', path: '/io/flutter_app/json/home_page.json');

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