import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/todo_list_page.dart';
import '../../domain/model/todo.dart';
import 'package:todoapp/core/navigation/routes.dart';
import '../../presentation/view/view_todo_page.dart';
import '../../presentation/view/todo_add_edit_page.dart';
import '../../presentation/view/unknown_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.listTodoRoute:
        return MaterialPageRoute(
          builder: (_) => const TodoListPage(),
        );
      case Routes.editTodoRoute:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => TodoFormPage(todo),
        );
      case Routes.addTodoRoute:
        return MaterialPageRoute(
          builder: (_) => const TodoFormPage(null),
        );
      case Routes.viewTodoRoute:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => TodoViewScreen(todo: todo),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => UnknownPage(settings.name),
        );
    }
  }
}
