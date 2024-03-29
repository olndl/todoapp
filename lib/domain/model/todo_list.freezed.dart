// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoList _$TodoListFromJson(Map<String, dynamic> json) {
  return _TodoList.fromJson(json);
}

/// @nodoc
mixin _$TodoList {
  @JsonKey(name: 'revision')
  int get revision => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'list')
  List<Todo> get list => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoListCopyWith<TodoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListCopyWith<$Res> {
  factory $TodoListCopyWith(TodoList value, $Res Function(TodoList) then) =
      _$TodoListCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'revision') int revision,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'list') List<Todo> list});
}

/// @nodoc
class _$TodoListCopyWithImpl<$Res> implements $TodoListCopyWith<$Res> {
  _$TodoListCopyWithImpl(this._value, this._then);

  final TodoList _value;
  // ignore: unused_field
  final $Res Function(TodoList) _then;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? list = freezed,
  }) {
    return _then(_value.copyWith(
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
abstract class _$$_TodoListCopyWith<$Res> implements $TodoListCopyWith<$Res> {
  factory _$$_TodoListCopyWith(
          _$_TodoList value, $Res Function(_$_TodoList) then) =
      __$$_TodoListCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'revision') int revision,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'list') List<Todo> list});
}

/// @nodoc
class __$$_TodoListCopyWithImpl<$Res> extends _$TodoListCopyWithImpl<$Res>
    implements _$$_TodoListCopyWith<$Res> {
  __$$_TodoListCopyWithImpl(
      _$_TodoList _value, $Res Function(_$_TodoList) _then)
      : super(_value, (v) => _then(v as _$_TodoList));

  @override
  _$_TodoList get _value => super._value as _$_TodoList;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? list = freezed,
  }) {
    return _then(_$_TodoList(
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      list: list == freezed
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoList extends _TodoList {
  const _$_TodoList(
      {@JsonKey(name: 'revision') required this.revision,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'list') required final List<Todo> list})
      : _list = list,
        super._();

  factory _$_TodoList.fromJson(Map<String, dynamic> json) =>
      _$$_TodoListFromJson(json);

  @override
  @JsonKey(name: 'revision')
  final int revision;
  @override
  @JsonKey(name: 'status')
  final String status;
  final List<Todo> _list;
  @override
  @JsonKey(name: 'list')
  List<Todo> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'TodoList(revision: $revision, status: $status, list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoList &&
            const DeepCollectionEquality().equals(other.revision, revision) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revision),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  _$$_TodoListCopyWith<_$_TodoList> get copyWith =>
      __$$_TodoListCopyWithImpl<_$_TodoList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoListToJson(
      this,
    );
  }
}

abstract class _TodoList extends TodoList {
  const factory _TodoList(
      {@JsonKey(name: 'revision') required final int revision,
      @JsonKey(name: 'status') required final String status,
      @JsonKey(name: 'list') required final List<Todo> list}) = _$_TodoList;
  const _TodoList._() : super._();

  factory _TodoList.fromJson(Map<String, dynamic> json) = _$_TodoList.fromJson;

  @override
  @JsonKey(name: 'revision')
  int get revision;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'list')
  List<Todo> get list;
  @override
  @JsonKey(ignore: true)
  _$$_TodoListCopyWith<_$_TodoList> get copyWith =>
      throw _privateConstructorUsedError;
}
