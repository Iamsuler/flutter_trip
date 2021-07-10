import 'dart:convert';

import 'common_model.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel(
      {required this.hotel, required this.flight, required this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
        hotel: GridNavItem.fromJson(json['hotel']),
        flight: GridNavItem.fromJson(json['flight']),
        travel: GridNavItem.fromJson(json['travel']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hotel': hotel.toJson(),
        'flight': flight.toJson(),
        'travel': travel.toJson()
      };
  
  @override
  String toString() {
    return jsonEncode(this);
  }
}

class GridNavItem {
  final String startColor;
  final String endColor;
  final List<CommonModel> list;

  GridNavItem(
      {required this.startColor, required this.endColor, required this.list});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    List<CommonModel> list = [];
    if(json['mainItem'] != null) {
      list.add(new CommonModel.fromJson(json['mainItem']));
    }
    if(json['item1'] != null) {
      list.add(new CommonModel.fromJson(json['item1']));
    }
    if(json['item2'] != null) {
      list.add(new CommonModel.fromJson(json['item2']));
    }
    if(json['item3'] != null) {
      list.add(new CommonModel.fromJson(json['item3']));
    }
    if(json['item4'] != null) {
      list.add(new CommonModel.fromJson(json['item4']));
    }
    return GridNavItem(
        startColor: json['startColor'], endColor: json['endColor'], list: list);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'startColor': startColor,
      'endColor': endColor,
      'list': list
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
