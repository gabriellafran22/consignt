import 'package:consignt/common/async.dart';
import 'package:flutter/material.dart';

import 'exception/api_exception.dart';

abstract class CustomChangeNotifier extends ChangeNotifier {
  Future customApi<R, T>(
      {required Future<R> service,
      required Async<T> object,
      required Function(R data) execute,
      Function(ApiException error)? onError}) async {
    try {
      object.loading();
      notifyListeners();
      var response = await service;
      await execute.call(response);
      notifyListeners();
    } on ApiException catch (e) {
      object.fail(e);
      if (onError != null) onError.call(e);
      notifyListeners();
    }
  }

  void copyState(Function function) {
    function.call();
    notifyListeners();
  }
}
