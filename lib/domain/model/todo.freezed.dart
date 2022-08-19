// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  int get changedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deadline')
  int? get dueDate => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'done')
  bool get isCompleted => throw _privateConstructorUsedError;
  String get importance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') int createdAt,
      @JsonKey(name: 'text') String title,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @JsonKey(name: 'changed_at') int changedAt,
      @JsonKey(name: 'deadline') int? dueDate,
      String? color,
      @JsonKey(name: 'done') bool isCompleted,
      String importance});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  final Todo _value;
  // ignore: unused_field
  final $Res Function(Todo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? lastUpdatedBy = freezed,
    Object? changedAt = freezed,
    Object? dueDate = freezed,
    Object? color = freezed,
    Object? isCompleted = freezed,
    Object? importance = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$_TodoCopyWith(_$_Todo value, $Res Function(_$_Todo) then) =
      __$$_TodoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') int createdAt,
      @JsonKey(name: 'text') String title,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @JsonKey(name: 'changed_at') int changedAt,
      @JsonKey(name: 'deadline') int? dueDate,
      String? color,
      @JsonKey(name: 'done') bool isCompleted,
      String importance});
}

/// @nodoc
class __$$_TodoCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res>
    implements _$$_TodoCopyWith<$Res> {
  __$$_TodoCopyWithImpl(_$_Todo _value, $Res Function(_$_Todo) _then)
      : super(_value, (v) => _then(v as _$_Todo));

  @override
  _$_Todo get _value => super._value as _$_Todo;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? lastUpdatedBy = freezed,
    Object? changedAt = freezed,
    Object? dueDate = freezed,
    Object? color = freezed,
    Object? isCompleted = freezed,
    Object? importance = freezed,
  }) {
    return _then(_$_Todo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Todo extends _Todo {
  const _$_Todo(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'text') required this.title,
      @JsonKey(name: 'last_updated_by') required this.lastUpdatedBy,
      @JsonKey(name: 'changed_at') required this.changedAt,
      @JsonKey(name: 'deadline') required this.dueDate,
      required this.color,
      @JsonKey(name: 'done') required this.isCompleted,
      required this.importance})
      : super._();

  factory _$_Todo.fromJson(Map<String, dynamic> json) => _$$_TodoFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'created_at')
  final int createdAt;
  @override
  @JsonKey(name: 'text')
  final String title;
  @override
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;
  @override
  @JsonKey(name: 'changed_at')
  final int changedAt;
  @override
  @JsonKey(name: 'deadline')
  final int? dueDate;
  @override
  final String? color;
  @override
  @JsonKey(name: 'done')
  final bool isCompleted;
  @override
  final String importance;

  @override
  String toString() {
    return 'Todo(id: $id, createdAt: $createdAt, title: $title, lastUpdatedBy: $lastUpdatedBy, changedAt: $changedAt, dueDate: $dueDate, color: $color, isCompleted: $isCompleted, importance: $importance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Todo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdatedBy, lastUpdatedBy) &&
            const DeepCollectionEquality().equals(other.changedAt, changedAt) &&
            const DeepCollectionEquality().equals(other.dueDate, dueDate) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(lastUpdatedBy),
      const DeepCollectionEquality().hash(changedAt),
      const DeepCollectionEquality().hash(dueDate),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(isCompleted),
      const DeepCollectionEquality().hash(importance));

  @JsonKey(ignore: true)
  @override
  _$$_TodoCopyWith<_$_Todo> get copyWith =>
      __$$_TodoCopyWithImpl<_$_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoToJson(
      this,
    );
  }
}

abstract class _Todo extends Todo {
  const factory _Todo(
      {required final String id,
      @JsonKey(name: 'created_at') required final int createdAt,
      @JsonKey(name: 'text') required final String title,
      @JsonKey(name: 'last_updated_by') required final String lastUpdatedBy,
      @JsonKey(name: 'changed_at') required final int changedAt,
      @JsonKey(name: 'deadline') required final int? dueDate,
      required final String? color,
      @JsonKey(name: 'done') required final bool isCompleted,
      required final String importance}) = _$_Todo;
  const _Todo._() : super._();

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'created_at')
  int get createdAt;
  @override
  @JsonKey(name: 'text')
  String get title;
  @override
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy;
  @override
  @JsonKey(name: 'changed_at')
  int get changedAt;
  @override
  @JsonKey(name: 'deadline')
  int? get dueDate;
  @override
  String? get color;
  @override
  @JsonKey(name: 'done')
  bool get isCompleted;
  @override
  String get importance;
  @override
  @JsonKey(ignore: true)
  _$$_TodoCopyWith<_$_Todo> get copyWith => throw _privateConstructorUsedError;
}
