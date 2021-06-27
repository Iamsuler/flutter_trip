import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {required this.config,
      required this.bannerList,
      required this.localNavList,
      required this.gridNav,
      required this.subNavList,
      required this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final List<CommonModel> bannerList = (json['bannerList'] as List)
        .map((e) => CommonModel.fromJson(e))
        .toList();

    final List<CommonModel> localNavList = (json['localNavList'] as List)
        .map((e) => CommonModel.fromJson(e))
        .toList();

    final List<CommonModel> subNavList = (json['subNavList'] as List)
        .map((e) => CommonModel.fromJson(e))
        .toList();

    return HomeModel(
        config: ConfigModel.fromJson(json['config']),
        bannerList: bannerList,
        localNavList: localNavList,
        gridNav: GridNavModel.fromJson(json['gridNav']),
        subNavList: subNavList,
        salesBox: SalesBoxModel.fromJson(json['salesBox']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'config': config,
    'bannerList': bannerList,
    'localNavList': localNavList,
    'gridNav': gridNav,
    'subNavList': subNavList,
    'salesBox': salesBox,
  };
}
