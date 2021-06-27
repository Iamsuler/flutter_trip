import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  final MaterialColor _defaultColor = Colors.grey;
  final MaterialColor _activeColor = Colors.blue;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), SearchPage(), TravelPage(), MyPage()],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          _controller.jumpToPage(value);
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search),
              label: '搜索'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              activeIcon: Icon(Icons.camera),
              label: '旅拍'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              activeIcon: Icon(Icons.people),
              label: '我的'),
        ],
        selectedItemColor: _activeColor,
        unselectedItemColor: _defaultColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
