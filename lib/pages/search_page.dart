import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class SearchPage extends StatefulWidget {
  final String keywords;
  const SearchPage({Key? key, this.keywords = ''}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keywords = '';

  @override
  void initState() {
    super.initState();
    if(widget.keywords.isNotEmpty) {
      _onTextChange(widget.keywords);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
            hideLeft: true,
            hintText: SEARCH_BAR_DEFAULT_TEXT,
            defaultText: widget.keywords,
            speakClick: _jumpToSpeak,
            onChanged: _onTextChange,
            rightButtonClick: () {},
            leftButtonClick: () {
              _goBack(context);
            },
          ),
          Text(keywords)
        ],
      ),
      backgroundColor: Colors.grey,
    );
  }

  void _jumpToSpeak() {
    print('_jumpToSpeak');
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTextChange(String text) {
    setState(() {
      keywords = text;
    });

    if(text.isEmpty) {
      return;
    }
  }
}
