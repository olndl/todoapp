import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/todo.dart';

final switcherProvider =
    StateNotifierProvider.autoDispose.family<SwitcherProvider, bool, Todo?>(
  (_, todo) => SwitcherProvider(todo?.deadline != null ? true : false),
);

class SwitcherProvider extends StateNotifier<bool> {
  SwitcherProvider(state) : super(state);

  toggleCalendar(bool value) {
    state = value;
  }
}
