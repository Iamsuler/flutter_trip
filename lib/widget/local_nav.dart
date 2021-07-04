import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webviewer.dart';

class LocalNav extends StatelessWidget {
  const LocalNav({Key? key, required this.localNavList}) : super(key: key);

  final List<CommonModel> localNavList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildNavList(context),
        ),
      ),
    );
  }

  List<Widget> _buildNavList(BuildContext context) {
    return localNavList.map((model) => _buildNavItem(context, model)).toList();
  }

  Widget _buildNavItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewer(
                    url: model.url!,
                    statusBarColor: model.statusBarColor!,
                    title: model.title!,
                    hideAppBar: model.hideAppBar!)));
      },
      child: Column(
        children: [
          Image.network(
            model.icon!,
            width: 32,
            height: 32,
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
      ),
    );
  }
}
