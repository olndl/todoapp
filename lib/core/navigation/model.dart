import 'dart:convert';
import '../../domain/model/todo.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) =>
      json['runtimeType'] == 'TodoSegment'
          ? BookSegment(todo: json['todo'])
          : HomeSegment();

  JsonMap toJson() => <String, dynamic>{'runtimeType': runtimeType.toString()};
  @override
  String toString() => jsonEncode(toJson());
}

/// Typed variant of whole url path (which consists of [TypedSegment]s)
typedef TypedPath = List<TypedSegment>;

//**** app specific segments

class HomeSegment with TypedSegment {}

class BookSegment with TypedSegment {
  BookSegment({required this.todo});
  final Todo? todo;
  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo;
}