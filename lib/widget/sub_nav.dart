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
  static const int _crossAxisCount = 5;
  static const double _singleRowHeight = 60;

  get _containerHeight => (subNavList.length / _crossAxisCount).ceil() * _singleRowHeight;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: Container(
          height: _containerHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
          ),
          margin: EdgeInsets.only(top: 5),
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
              crossAxisCount: _crossAxisCount,
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
    return StaggeredTile.extent(1, _singleRowHeight);
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebViewer(
                url: model.url!,
                title: model.title!,
                hideAppBar: model.hideAppBar!
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
