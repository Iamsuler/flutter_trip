import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/webviewer.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;
  SubNav({
    Key? key,
    required this.subNavList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
          ),
          margin: EdgeInsets.only(top: 5),
          // 有缺陷不能定列数，只能通过控制最大列宽度来算列数
          child: StaggeredGridView.extentBuilder(
              shrinkWrap: true,
              maxCrossAxisExtent: 100,
              itemCount: subNavList.length,
              itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
              staggeredTileBuilder: _getTile
          ),
        )
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final model = subNavList[index];
    final Widget child = _getChild(context, model);
    return _wrapGesture(context, child, model);
  }

  StaggeredTile _getTile(int index) {
    return StaggeredTile.extent(1, 60);
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebViewer(
                url: model.url!,
                statusBarColor: model.statusBarColor,
                title: model.title,
                hideAppBar: model.hideAppBar
            )
        );
      },
      child: widget,
    );
  }

  Widget _getChild(BuildContext context, CommonModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          model.icon!,
          width: 20,
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            model.title!,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }


}
