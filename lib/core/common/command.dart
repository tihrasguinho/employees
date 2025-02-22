import 'package:flutter/material.dart';

import 'result.dart';

abstract class Command<T> extends ChangeNotifier {
  bool _running = false;

  bool get running => _running;

  Result<T>? _result;

  Result<T>? get result => _result;

  Future<void> _execute(AsyncResult<T> Function() action) async {
    if (_running) return;

    _running = true;
    notifyListeners();

    _result = await action();
    _running = false;
    notifyListeners();
  }
}

class Command0<T> extends Command<T> {
  final AsyncResult<T> Function() action;

  Command0(this.action);

  Future<void> execute() async {
    await _execute(action);
  }
}

class Command1<A, T> extends Command<T> {
  final AsyncResult<T> Function(A arg) action;

  Command1(this.action);

  Future<void> execute(A arg) async {
    await _execute(() => action(arg));
  }
}
