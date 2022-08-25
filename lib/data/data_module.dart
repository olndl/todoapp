import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/repository/todos_repository_impl.dart';
import '../domain/repository/todos_repository.dart';
import 'datasource/remote_database/network_service.dart';
import 'datasource/remote_database/remote_todos_database_impl.dart';
import 'datasource/todos_database.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((_) => RemoteTodosDatabaseImpl(networkService: NetworkService()));
final todosRepositoryProvider = Provider<TodosRepository>((ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));
