import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/webviewer.dart';

class HomeSwipper extends StatelessWidget {
  const HomeSwipper({Key? key, required this.bannerList}) : super(key: key);

  final List<CommonModel> bannerList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Swiper(
        itemHeight: 200,
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          final model = bannerList[index];
          return GestureDetector(
            onTap: () {
              NavigatorUtil.push(context, WebViewer(
                  url: model.url!
              ));
            },
            child: Image.network(
              model.icon!,
              fit: BoxFit.fill,
            ),
          );
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}
