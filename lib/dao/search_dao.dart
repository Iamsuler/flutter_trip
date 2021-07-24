import 'dart:convert';

import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;
// https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=


class SearchDao {
  static Future<SearchModel> fetch({keyword = ''}) async {
    final Uri _uri = Uri(
        scheme: 'https',
        host: 'm.ctrip.com',
        path: '/restapi/h5api/searchapp/search',
        queryParameters: {
          'source': 'mobileweb',
          'action': 'autocomplete',
          'contentType': 'json',
          'keyword': keyword
        }
    );
    final response = await http.get(_uri);
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      final result = json.decode(utf8decoder.convert(response.bodyBytes));

      return SearchModel.fromJson(result);
    } else {
      throw Exception('Fail to load home_page');
    }
  }
}