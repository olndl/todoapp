abstract class S {
  static final appIcons = AppIcons();
  static final api = Api();
  static final firebase = Firebase();
  static final sqflite = Sqflite();
}

class AppIcons {
  final String iconVisibilityOff = 'assets/icons/visibility_off.svg';
  final String iconVisibility = 'assets/icons/visibility.svg';
  final String iconCheck = 'assets/icons/check.svg';
  final String iconDelete = 'assets/icons/delete.svg';
  final String iconInfoOutline = 'assets/icons/info_outline.svg';
  final String iconAdd = 'assets/icons/add.svg';
  final String iconArrow = 'assets/icons/arrow.svg';
  final String iconPriority = 'assets/icons/priority.svg';
  final String iconCheckedTile = 'assets/icons/checked.svg';
  final String iconUncheckedNormTile = 'assets/icons/unchecked-normal.svg';
  final String iconUncheckedHighTile = 'assets/icons/unchecked-high.svg';
  final String iconSwitchOn = 'assets/icons/switch-on.svg';
  final String iconSwitchOff = 'assets/icons/switch-off.svg';
  final String iconClose = 'assets/icons/close.svg';
}

class Api {
  static const token = 'Anehull';
  final String baseUrl = 'https://beta.mrdekk.ru/todobackend';
  final String revisionHeader = 'X-Last-Known-Revision';
  final String authHeader = 'Authorization';
  final String authValue = 'Bearer $token';
  final String contentType = 'application/json';
  final String host = 'example.com';
  final String low = 'low';
  final String basic = 'basic';
  final String important = 'important';
  final String dateFormat = 'dd MMMM yyy';
}

class Firebase {
  final String deleteLog = 'delete_todo';
  final String addLog = 'add_todo';
  final String completeLog = 'complete_todo';
}

class Sqflite {
  final String databaseName = 'data';
  final String host = 'example.com';
}
