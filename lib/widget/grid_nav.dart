import 'package:flutter/material.dart';

class GridNav extends StatelessWidget {
  const GridNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      color: Colors.redAccent,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 88,
                decoration: BoxDecoration(
                    color: Colors.blueAccent
                ),
                child: Text('main'),
              )
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border: Border(
                                    left: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.white
                                    ),
                                  bottom: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.white
                                  )
                                )
                            ),
                            child: Text('sub1'),
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border: Border(
                                    left: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.white
                                    ),
                                    bottom: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.white
                                    )
                                )
                            ),
                            child: Text('sub2'),
                          )
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border: Border(
                                    left: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.white
                                    )
                                )
                            ),
                            child: Text('sub3'),
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                              border: Border(
                                left: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.white
                                )
                              )
                            ),
                            child: Text('sub4'),
                          )
                      )
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
