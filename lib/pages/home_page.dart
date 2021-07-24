import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/home_search_bar.dart';
import 'package:flutter_trip/widget/home_swipper.dart';
import 'package:flutter_trip/widget/loading_container.dart';
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
  SalesBoxModel sablesBox = SalesBoxModel.fromJson({});
  bool isLoading = true;
  double appBarAlpha = 0;

  static const int APPBAR_SCROLL_OFFSET = 100;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
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
      print('loaded data.');
      setState(() {
        gridNav = model.gridNav;
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        sablesBox = model.salesBox;
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: isLoading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if(scrollNotification is ScrollNotification
                        && scrollNotification.depth == 0
                      ) {
                        _onScroll(scrollNotification.metrics.pixels);
                      }

                      return false;
                    },
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
                        SalesBox(
                          salesBox: sablesBox,
                        ),
                      ],
                    ),
                  ),
                )),
            HomeSearchBar(
              inputBoxClick: _inputBoxClick,
              appBarAlpha: appBarAlpha,
            )
          ],
        ),
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  void _inputBoxClick() {
    NavigatorUtil.push(context, SearchPage());
  }
}
