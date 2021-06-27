import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultString = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    // HomeDao.fetch().then((value) {
    //   setState(() {
    //     resultString = jsonEncode(value);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });
    // try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.toJson());
      });
    // } catch(e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
        body: Container(
          child: Text(resultString),
        ),
    );
  }
}
