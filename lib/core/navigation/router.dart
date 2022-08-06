import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/presentation/screens/todo_view_screen.dart';

import '../../data/models/todo/todo.dart';
import '../../network/network_service.dart';
import '../../network/repository.dart';
import '../../presentation/bloc/add_todo/add_todo_cubit.dart';
import '../../presentation/bloc/edit_todo/edit_todo_cubit.dart';
import '../../presentation/bloc/list_todo/todos_cubit.dart';
import '../../presentation/screens/add_todo_screen.dart';
import '../../presentation/screens/edit_todo_screen.dart';
import '../../presentation/screens/list_todo_screen.dart';
import 'package:todoapp/core/navigation/routes.dart';


class AppRouter {
  late Repository repository;
  late TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit,
            child: TodosScreen(),
          ),
        );
      case Routes.EDIT_TODO_ROUTE:
        final listArgs = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(todo: listArgs["todo"] as Todo,
              revision: listArgs["revision"] as int,),
          ),
        );
      case Routes.ADD_TODO_ROUTE:
        final revision = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: AddTodoScreen(revision: revision,),
          ),
        );
      case Routes.VIEW_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => TodoViewScreen(todo: todo),
        );
      default:
        return null;
    }
  }
}