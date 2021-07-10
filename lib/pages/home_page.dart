import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/home_swipper.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel? gridNav;
  List<CommonModel> subNavList = [];
  SalesBoxModel? sablesBox;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    // HomeDao.fetch().then((value) {
    //   setState(() {
    //     resultString = jsonEncode(value);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        gridNav = model.gridNav;
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        sablesBox = model.salesBox;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: MediaQuery.removePadding(
        removeTop: true,
          context: context,
          child: ListView(
            shrinkWrap: true,
            children: [
              HomeSwipper(bannerList: bannerList),
              Padding(
                  padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                child: LocalNav(localNavList: localNavList),
              ),
              GridNav(gridNav: gridNav),
              SubNav(subNavList: subNavList),
              SalesBox(salesBox: sablesBox!,)
            ],
          )),
    );
  }
}
