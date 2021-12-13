import 'dart:async';

import 'package:junior_test/blocs/base/BaseBloc.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/repository.dart';
import 'package:rxdart/rxdart.dart';

class ActionsWidgetQueryBloc extends BaseBloc {
  final _controller = BehaviorSubject<RootResponse>();
  final _client = Repository();

  Stream<RootResponse> get shopItemsContentStream => _controller.stream;

  void loadActionsWidgetContent(int page, int count) async {
    // 1
    final results = await _client.fetchActions(page,count);
    addResultToController(_controller, results);
  }

  @override
  void dispose() {
    _controller.close();
  }

  BehaviorSubject<Object> getController() {
    return _controller;
  }
}
