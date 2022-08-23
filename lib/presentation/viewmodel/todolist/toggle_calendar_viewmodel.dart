import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleCalendarControllerProvider =
    StateNotifierProvider<ToggleNotifier, bool>((ref) => ToggleNotifier());

class ToggleNotifier extends StateNotifier<bool> {

  ToggleNotifier() : super(false);

  toggleCalendar(bool value) {
    state = value;
  }
}
