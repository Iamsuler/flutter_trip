import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool cover;
  const LoadingContainer(
      {Key? key,
      required this.isLoading,
      required this.child,
      this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget widget;
    if(!cover) {
      if(!isLoading) {
        widget = child;
      } else {
        widget = _loadingView();
      }
    } else {
      widget = Stack(
        children: [
          child,
          isLoading ? _loadingView() : null as Widget,
        ],
      );
    }
    return widget;
  }

  _loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
