import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/webviewer.dart';

const List<StaggeredTile> _tiles = <StaggeredTile>[
  StaggeredTile.extent(1, 88),
  StaggeredTile.extent(1, 44),
  StaggeredTile.extent(1, 44),
  StaggeredTile.extent(1, 44),
  StaggeredTile.extent(1, 44),
];

class GridNav extends StatelessWidget {
  final GridNavModel? gridNav;
  GridNav({
    Key? key,
    required this.gridNav
  }) : super(key: key);

  List<Widget> _gridNavList (BuildContext context) {
    List<Widget> list = [];
    if(gridNav?.hotel != null) {
      list.add(_getGridNavWidgets(context, gridNav!.hotel, true));
    }
    if(gridNav?.flight != null) {
      list.add(_getGridNavWidgets(context, gridNav!.flight));
    }
    if(gridNav?.travel != null) {
      list.add(_getGridNavWidgets(context, gridNav!.travel));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 7,
        right: 7
      ),
      margin: EdgeInsets.only(top: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Column(
          children: _gridNavList(context),
        ),
      ),
    );
  }

  Widget _getChild(BuildContext context, int index, GridNavItem gridNavItem) {
    final CommonModel model = gridNavItem.list[index];
    final Widget child = index == 0 ? _getMainChild(context, gridNavItem.list[index]) : _getSubChild(context, index, gridNavItem.list[index]);
    return _wrapGesture(context, child, model);
  }

  StaggeredTile? _getTile(int index) {
    return index >= _tiles.length ? null : _tiles[index];
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

  _getMainChild(BuildContext context, CommonModel model) {
    return Container(
      padding: EdgeInsets.only(top: 11),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
          image: NetworkImage(model.icon!)
        )
      ),
      child: Text(
          model.title ?? '',
          style: TextStyle(fontSize: 14, color: Colors.white)
      ),
    );
  }

  _getSubChild(BuildContext context, int index, CommonModel model) {
    const BorderSide border = BorderSide(
        width: 1,
        color: Colors.white,
        style: BorderStyle.solid
    );
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: border,
          bottom: index <= 2 ? border : BorderSide.none
        )
      ),
      child: Center(
          child: Text(
              model.title ?? '',
              style: TextStyle(fontSize: 14, color: Colors.white)
          )
      ),
    );
  }

  Widget _getGridNavWidgets(BuildContext context, GridNavItem gridNavItem, [bool isFirst = false]) {
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));
    return Container(
      margin: isFirst ? EdgeInsets.zero : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor]
        )
      ),
      child: StaggeredGridView.extentBuilder(
          shrinkWrap: true,
          maxCrossAxisExtent: 150,
          itemCount: _tiles.length,
          itemBuilder: (BuildContext context, int index) => _getChild(context, index, gridNavItem),
          staggeredTileBuilder: _getTile
      ),
    );
  }
}
