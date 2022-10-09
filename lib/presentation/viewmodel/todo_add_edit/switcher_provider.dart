import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/todo.dart';

final displayDateStateProvider =
    ChangeNotifierProvider.family<DisplayDateState, Todo?>(
  (_, todo) => DisplayDateState(
    todo != null ? (todo.deadline != null ? true : false) : false,
    todo?.deadline,
  ),
);

class DisplayDateState with ChangeNotifier {
  bool _isSwitch;
  int? _deadline;

  DisplayDateState(this._isSwitch, this._deadline);

  bool get isSwitch => _isSwitch;

  int? get deadline => _deadline;

  isSwitchSet(bool val) {
    _isSwitch = val;
    notifyListeners();
  }

  deadlineSet(int? val) {
    _deadline = val;
    notifyListeners();
  }

  displayDate() {
    if (_isSwitch && _deadline != null) {
      return DateFormat.yMMMMd(Platform.localeName).format(
        DateTime.fromMillisecondsSinceEpoch(
          _deadline!,
        ),
      );
    } else {
      return null;
    }
  }
}
