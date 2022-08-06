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
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @HiveField(2)
  int get createdAt => throw _privateConstructorUsedError;
  @HiveField(3)
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  @HiveField(4)
  String get lastUpdatedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  @HiveField(5)
  int get changedAt => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get deadline => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get color => throw _privateConstructorUsedError;
  @HiveField(8)
  bool get done => throw _privateConstructorUsedError;
  @HiveField(9)
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
      {@HiveField(1) String id,
      @JsonKey(name: 'created_at') @HiveField(2) int createdAt,
      @HiveField(3) String text,
      @JsonKey(name: 'last_updated_by') @HiveField(4) String lastUpdatedBy,
      @JsonKey(name: 'changed_at') @HiveField(5) int changedAt,
      @HiveField(6) int? deadline,
      @HiveField(7) String? color,
      @HiveField(8) bool done,
      @HiveField(9) String importance});
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
    Object? text = freezed,
    Object? lastUpdatedBy = freezed,
    Object? changedAt = freezed,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? done = freezed,
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
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
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
      {@HiveField(1) String id,
      @JsonKey(name: 'created_at') @HiveField(2) int createdAt,
      @HiveField(3) String text,
      @JsonKey(name: 'last_updated_by') @HiveField(4) String lastUpdatedBy,
      @JsonKey(name: 'changed_at') @HiveField(5) int changedAt,
      @HiveField(6) int? deadline,
      @HiveField(7) String? color,
      @HiveField(8) bool done,
      @HiveField(9) String importance});
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
    Object? text = freezed,
    Object? lastUpdatedBy = freezed,
    Object? changedAt = freezed,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? done = freezed,
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
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
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
@HiveType(typeId: 0)
class _$_Todo implements _Todo {
  const _$_Todo(
      {@HiveField(1)
          required this.id,
      @JsonKey(name: 'created_at')
      @HiveField(2)
          required this.createdAt,
      @HiveField(3)
          required this.text,
      @JsonKey(name: 'last_updated_by')
      @HiveField(4)
          required this.lastUpdatedBy,
      @JsonKey(name: 'changed_at')
      @HiveField(5)
          required this.changedAt,
      @HiveField(6)
          required this.deadline,
      @HiveField(7)
          this.color,
      @HiveField(8)
          required this.done,
      @HiveField(9)
          required this.importance});

  factory _$_Todo.fromJson(Map<String, dynamic> json) => _$$_TodoFromJson(json);

  @override
  @HiveField(1)
  final String id;
  @override
  @JsonKey(name: 'created_at')
  @HiveField(2)
  final int createdAt;
  @override
  @HiveField(3)
  final String text;
  @override
  @JsonKey(name: 'last_updated_by')
  @HiveField(4)
  final String lastUpdatedBy;
  @override
  @JsonKey(name: 'changed_at')
  @HiveField(5)
  final int changedAt;
  @override
  @HiveField(6)
  final int? deadline;
  @override
  @HiveField(7)
  final String? color;
  @override
  @HiveField(8)
  final bool done;
  @override
  @HiveField(9)
  final String importance;

  @override
  String toString() {
    return 'Todo(id: $id, createdAt: $createdAt, text: $text, lastUpdatedBy: $lastUpdatedBy, changedAt: $changedAt, deadline: $deadline, color: $color, done: $done, importance: $importance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Todo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdatedBy, lastUpdatedBy) &&
            const DeepCollectionEquality().equals(other.changedAt, changedAt) &&
            const DeepCollectionEquality().equals(other.deadline, deadline) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.done, done) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(lastUpdatedBy),
      const DeepCollectionEquality().hash(changedAt),
      const DeepCollectionEquality().hash(deadline),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(done),
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

abstract class _Todo implements Todo {
  const factory _Todo(
      {@HiveField(1)
          required final String id,
      @JsonKey(name: 'created_at')
      @HiveField(2)
          required final int createdAt,
      @HiveField(3)
          required final String text,
      @JsonKey(name: 'last_updated_by')
      @HiveField(4)
          required final String lastUpdatedBy,
      @JsonKey(name: 'changed_at')
      @HiveField(5)
          required final int changedAt,
      @HiveField(6)
          required final int? deadline,
      @HiveField(7)
          final String? color,
      @HiveField(8)
          required final bool done,
      @HiveField(9)
          required final String importance}) = _$_Todo;

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  @HiveField(1)
  String get id;
  @override
  @JsonKey(name: 'created_at')
  @HiveField(2)
  int get createdAt;
  @override
  @HiveField(3)
  String get text;
  @override
  @JsonKey(name: 'last_updated_by')
  @HiveField(4)
  String get lastUpdatedBy;
  @override
  @JsonKey(name: 'changed_at')
  @HiveField(5)
  int get changedAt;
  @override
  @HiveField(6)
  int? get deadline;
  @override
  @HiveField(7)
  String? get color;
  @override
  @HiveField(8)
  bool get done;
  @override
  @HiveField(9)
  String get importance;
  @override
  @JsonKey(ignore: true)
  _$$_TodoCopyWith<_$_Todo> get copyWith => throw _privateConstructorUsedError;
}
