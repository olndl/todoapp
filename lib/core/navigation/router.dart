import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/todo_list_page.dart';
import '../../domain/model/todo.dart';
import 'package:todoapp/core/navigation/routes.dart';
import '../../presentation/view/view_todo_screen.dart';
import '../../presentation/view/todo_add_edit_page.dart';
import '../../presentation/viewmodel/unknown_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.LIST_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => TodoListPage(),
        );
      case Routes.EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => TodoFormPage(todo),
        );
      case Routes.ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const TodoFormPage(null),
        );
      case Routes.VIEW_TODO_ROUTE:
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
