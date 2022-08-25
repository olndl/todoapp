import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/datasource/local_database/local_todos_database_impl.dart';
import 'package:todoapp/data/repository/todos_repository_impl.dart';
import '../domain/repository/todos_repository.dart';
import 'datasource/remote_database/dio/dio_client.dart';
import 'datasource/remote_database/remote_todos_database_impl.dart';
import 'datasource/todos_database.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((_) => LocalTodosDatabaseImpl());
    //RemoteTodosDatabaseImpl(dioClient: DioClient()));
final todosRepositoryProvider = Provider<TodosRepository>(
    (ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));
