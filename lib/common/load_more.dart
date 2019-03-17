import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

class SimpleLoadMoreController extends LoadMoreController {
  SimpleLoadMoreController(LoadMoreCallback callback) : super(callback);

  @override
  Widget indicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}