import 'package:flutter/material.dart';
import 'package:junior_test/ui/actions/ActionsWidget.dart';
import './resources/api/mall_api_provider.dart';
import './model/RootResponse.dart';
void main() {
  runApp(MaterialApp(home:  ActionsWidget(page:0, count:10),

  ));
}
