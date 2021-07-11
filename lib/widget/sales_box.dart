import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/webviewer.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;
  SalesBox({
    Key? key,
    required  this.salesBox
  }) : super(key: key);


  static const BorderSide borderSide = BorderSide(
      width: 1,
      color: Color(0xfff2f2f2),
      style: BorderStyle.solid
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      // 有缺陷不能定列数，只能通过控制最大列宽度来算列数
      child: Column(
        children: [
          _getHead(context),
          Container(
            height: 289,
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: salesBox.list.length,
                itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
                staggeredTileBuilder: _getTile
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final model = salesBox.list[index];
    final Widget child = _getChild(context, index, model);
    return _wrapGesture(context, child, model);
  }

  StaggeredTile _getTile(int index) {
    final double height = index <= 1 ? 129 : 80;
    return StaggeredTile.extent(1, height);
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebViewer(
                url: model.url!,
                statusBarColor: model.statusBarColor!,
                title: model.title!,
                hideAppBar: model.hideAppBar!
            )
        );
      },
      child: widget,
    );
  }

  Widget _getChild(BuildContext context, int index, CommonModel model) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(model.icon!),
          fit: BoxFit.fill,
          alignment: Alignment.center
        ),
        border: Border(
          bottom: borderSide,
          left: index.isOdd ? borderSide : BorderSide.none
        )
      ),
    );
  }

  _getHead(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: borderSide
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
              salesBox.icon,
              height: 15,
              fit: BoxFit.fill
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: GestureDetector(
              onTap: () {
                NavigatorUtil.push(
                    context,
                    WebViewer(
                        url: salesBox.moreUrl,
                        title: '获取更多福利',
                        hideAppBar: false
                    )
                );
              },
              child: Text(
                '获取更多福利 >',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}
