import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/repository/todos_repository_impl.dart';

import '../domain/repository/todos_repository.dart';
import 'datasource/database/todos_database.dart';
import 'datasource/database/todos_database_impl.dart';
import 'datasource/network_service.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((_) => TodosDatabaseImpl(networkService: NetworkService()));
final todosRepositoryProvider =
    Provider<TodosRepository>((ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));
