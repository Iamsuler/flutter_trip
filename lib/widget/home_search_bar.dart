import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final double appBarAlpha;
  final void Function() inputBoxClick;
  const HomeSearchBar({Key? key, required this.inputBoxClick, this.appBarAlpha = 0}) : super(key: key);

  int get _alpha => (appBarAlpha * 255).toInt();
  Color get _fontColor => appBarAlpha > 0.2 ? Colors.black54 : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x66000000), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Container(
        padding: EdgeInsets.only(top: 25, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(_alpha, 255, 255, 255)
        ),
        height: 85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Text(
                    '长沙',
                    style: TextStyle(
                        fontSize: 14,
                        color: _fontColor
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 22,
                    color: _fontColor,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(
                      left: 10,
                      right: 10
                  ),
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(int.parse('0xffEDEDED')),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _wrapGesture(Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            '网红打卡地',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ), inputBoxClick),
                      Icon(
                        Icons.mic,
                        size: 20,
                        color: Colors.grey,
                      )
                    ],
                  ),
                )
            ),
            Icon(
              Icons.comment,
              size: 26,
              color: _fontColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _wrapGesture(Widget widget, void Function() callback) {
    return GestureDetector(
      onTap: callback,
      child: widget,
    );
  }
}
