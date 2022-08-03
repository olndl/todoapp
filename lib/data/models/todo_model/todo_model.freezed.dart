// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return _TodoModel.fromJson(json);
}

/// @nodoc
mixin _$TodoModel {
  String get status => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;
  Todo get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoModelCopyWith<TodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoModelCopyWith<$Res> {
  factory $TodoModelCopyWith(TodoModel value, $Res Function(TodoModel) then) =
      _$TodoModelCopyWithImpl<$Res>;
  $Res call({String status, int revision, Todo element});

  $TodoCopyWith<$Res> get element;
}

/// @nodoc
class _$TodoModelCopyWithImpl<$Res> implements $TodoModelCopyWith<$Res> {
  _$TodoModelCopyWithImpl(this._value, this._then);

  final TodoModel _value;
  // ignore: unused_field
  final $Res Function(TodoModel) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? revision = freezed,
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }

  @override
  $TodoCopyWith<$Res> get element {
    return $TodoCopyWith<$Res>(_value.element, (value) {
      return _then(_value.copyWith(element: value));
    });
  }
}

/// @nodoc
abstract class _$$_TodoModelCopyWith<$Res> implements $TodoModelCopyWith<$Res> {
  factory _$$_TodoModelCopyWith(
          _$_TodoModel value, $Res Function(_$_TodoModel) then) =
      __$$_TodoModelCopyWithImpl<$Res>;
  @override
  $Res call({String status, int revision, Todo element});

  @override
  $TodoCopyWith<$Res> get element;
}

/// @nodoc
class __$$_TodoModelCopyWithImpl<$Res> extends _$TodoModelCopyWithImpl<$Res>
    implements _$$_TodoModelCopyWith<$Res> {
  __$$_TodoModelCopyWithImpl(
      _$_TodoModel _value, $Res Function(_$_TodoModel) _then)
      : super(_value, (v) => _then(v as _$_TodoModel));

  @override
  _$_TodoModel get _value => super._value as _$_TodoModel;

  @override
  $Res call({
    Object? status = freezed,
    Object? revision = freezed,
    Object? element = freezed,
  }) {
    return _then(_$_TodoModel(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoModel implements _TodoModel {
  _$_TodoModel(
      {required this.status, required this.revision, required this.element});

  factory _$_TodoModel.fromJson(Map<String, dynamic> json) =>
      _$$_TodoModelFromJson(json);

  @override
  final String status;
  @override
  final int revision;
  @override
  final Todo element;

  @override
  String toString() {
    return 'TodoModel(status: $status, revision: $revision, element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoModel &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.revision, revision) &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(revision),
      const DeepCollectionEquality().hash(element));

  @JsonKey(ignore: true)
  @override
  _$$_TodoModelCopyWith<_$_TodoModel> get copyWith =>
      __$$_TodoModelCopyWithImpl<_$_TodoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoModelToJson(
      this,
    );
  }
}

abstract class _TodoModel implements TodoModel {
  factory _TodoModel(
      {required final String status,
      required final int revision,
      required final Todo element}) = _$_TodoModel;

  factory _TodoModel.fromJson(Map<String, dynamic> json) =
      _$_TodoModel.fromJson;

  @override
  String get status;
  @override
  int get revision;
  @override
  Todo get element;
  @override
  @JsonKey(ignore: true)
  _$$_TodoModelCopyWith<_$_TodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
