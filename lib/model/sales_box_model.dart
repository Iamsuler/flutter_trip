import 'package:flutter_trip/model/common_model.dart';

class SalesBoxModel {
  final String icon;
  final String moreUrl;
  final List<CommonModel> list;

  SalesBoxModel(
      {required this.icon,
      required this.moreUrl,
      required this.list});

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) {
    List<CommonModel> list = [];
    json.forEach((key, value) {
      if(value is Map ) {
        if(key.contains('bigCard')) {
          list.insert(0, CommonModel.fromJson((value as Map<String, dynamic>)));
        } else {
          list.add(CommonModel.fromJson(value as Map<String, dynamic>));
        }
      }
    });
    return SalesBoxModel(
        icon: json['icon'],
        moreUrl: json['moreUrl'],
        list: list);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'icon': icon,
    'moreUrl': moreUrl,
    'list': list.map((e) => e.toJson()).toList()
  };
}
