import 'package:freezed_annotation/freezed_annotation.dart';
import '../todo/todo.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {

  factory TodoModel({
    required String status,
    required int revision,
    required Todo element,
}) = _TodoModel;


  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

}
