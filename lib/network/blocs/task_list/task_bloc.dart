import 'package:bloc/bloc.dart';
import 'package:todoapp/network/api_repository.dart';
import 'package:todoapp/network/blocs/task_list/task_state.dart';
import 'package:todoapp/network/blocs/task_list/task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetTaskList>((event, emit) async {
      emit(TaskLoading());
      try {
        final mList = await _apiRepository.fetchTaskList();
        emit(TaskLoaded(mList));
      } catch (e) {
        emit(TaskFailedState("Failed to fetch data with error $e"));
      }
    });

  }
}
