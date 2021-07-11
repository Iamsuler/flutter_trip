import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final bool hideLeft;
  final bool autofocus;
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final ValueChanged<String> onChanged;
  const SearchBar(
      {Key? key,
      this.hintText = '',
      this.hideLeft = false,
      this.autofocus = false,
      this.defaultText = '',
      required this.leftButtonClick,
      required this.rightButtonClick,
      required this.speakClick,
      required this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 10, right: 10),
      height: 85,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getLeftBar(),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 30,
                decoration: BoxDecoration(
                    color: Color(int.parse('0xffEDEDED')),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 5, right: 5, bottom: 12),
                            hintText: widget.hintText,
                            hintStyle: TextStyle(fontSize: 15),
                            border: InputBorder.none,
                          ),
                          autofocus: widget.autofocus,
                          onChanged: _onChanged,
                        )
                    ),
                    _getInputRightBar()
                  ],
                ),
              )),
          _wrapGesture(Text(
            '搜索',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 17,
            ),
          ), widget.rightButtonClick),
        ],
      ),
    );
  }

  Widget _getInputRightBar() {
    return _showClear ? _wrapGesture(Icon(
      Icons.close,
      size: 20,
      color: Colors.grey,
    ), () {
      setState(() {
        _controller.clear();
        _onChanged('');
      });
    }) : _wrapGesture(Icon(
      Icons.mic,
      size: 20,
      color: Colors.blue,
    ), widget.speakClick);
  }

  Widget _getLeftBar() {
    return _wrapGesture(Container(
      child: widget.hideLeft
          ? null
          : Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black54,
            ),
    ), widget.leftButtonClick);
  }

  Widget _wrapGesture(Widget widget, void Function() callback) {
    return GestureDetector(
      onTap: callback,
      child: widget,
    );
  }

  void _onChanged(String text) {
    setState(() {
      _showClear = text.length > 0;
    });

    widget.onChanged(text);
  }
}
