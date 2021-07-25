import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/utils/navigator_util.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webviewer.dart';

const TYPES = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class SearchPage extends StatefulWidget {
  final String keyword;
  final bool hideLeft;
  const SearchPage({Key? key, this.keyword = '', this.hideLeft = false}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = '';
  SearchModel searchModel = SearchModel.fromJson({'data': []});

  @override
  void initState() {
    super.initState();
    if (widget.keyword.isNotEmpty) {
      _onTextChange(widget.keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
            hideLeft: widget.hideLeft,
            hintText: SEARCH_BAR_DEFAULT_TEXT,
            defaultText: widget.keyword,
            speakClick: _jumpToSpeak,
            onChanged: _onTextChange,
            rightButtonClick: () {
              _fetchData();
            },
            leftButtonClick: () {
              _goBack(context);
            },
          ),
          MediaQuery.removePadding(
            removeTop: true,
              context: context,
              child: Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: searchModel.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  })))
        ],
      ),
    );
  }

  void _jumpToSpeak() {
    print('_jumpToSpeak');
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTextChange(String text) async {
    setState(() {
      keyword = text;
    });

    if (text.isEmpty) {
      setState(() {
        searchModel = SearchModel.fromJson({'data': []});
      });
      return;
    }

    _fetchData();
  }

  void _fetchData() async {
    try {
      SearchModel model = await SearchDao.fetch(keyword: keyword);
      // TODO: 应该改用防抖解决输入引起多次请求
      if(model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _item(int position) {
    SearchModelItem item = searchModel.data[position];

    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebViewer(
              url: item.url.replaceAll('http', 'https'),
              title: '详情',
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1, style: BorderStyle.solid))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                width: 26,
                height: 26,
                image: AssetImage(
                  _typeImage(item.type),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _typeImage(String? type) {
    if (type == null) {
      return 'assets/images/type_travelgroup.png';
    }

    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }

    return 'assets/images/type_$path.png';
  }

  Widget _title(SearchModelItem item) {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpan(item.word, keyword));
    spans.add(TextSpan(
        text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}',
        style: TextStyle(fontSize: 12, color: Colors.grey)));

    return RichText(text: TextSpan(children: spans));
  }

  Widget _subTitle(SearchModelItem item) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: item.price ?? '',
          style: TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
          text: ' ${item.type ?? ''}',
          style: TextStyle(fontSize: 16, color: Colors.grey)),
    ]));
  }

  List<TextSpan> _keywordTextSpan(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) {
      return spans;
    }

    String wordLower = word.toLowerCase();
    String keywordLower = keyword.toLowerCase();
    List<String> wordList = wordLower.split(keywordLower);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle highlightStyle = TextStyle(fontSize: 16, color: Colors.orange);
    final TextSpan keywordSpan = TextSpan(
        text: keyword,
        style: highlightStyle
    );

    for (int i = 0; i < wordList.length; i++) {
      if (i != 0) {
        spans.add(keywordSpan);
      }

      String str = wordList[i];
      if (str.length > 0) {
        spans.add(TextSpan(text: str, style: normalStyle));
      }
    }

    return spans;
  }
}
