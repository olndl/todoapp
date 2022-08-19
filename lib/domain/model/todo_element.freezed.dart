// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoElement _$TodoElementFromJson(Map<String, dynamic> json) {
  return _TodoElement.fromJson(json);
}

/// @nodoc
mixin _$TodoElement {
  int get revision => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Todo get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoElementCopyWith<TodoElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoElementCopyWith<$Res> {
  factory $TodoElementCopyWith(
          TodoElement value, $Res Function(TodoElement) then) =
      _$TodoElementCopyWithImpl<$Res>;
  $Res call({int revision, String status, Todo element});

  $TodoCopyWith<$Res> get element;
}

/// @nodoc
class _$TodoElementCopyWithImpl<$Res> implements $TodoElementCopyWith<$Res> {
  _$TodoElementCopyWithImpl(this._value, this._then);

  final TodoElement _value;
  // ignore: unused_field
  final $Res Function(TodoElement) _then;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? element = freezed,
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
abstract class _$$_TodoElementCopyWith<$Res>
    implements $TodoElementCopyWith<$Res> {
  factory _$$_TodoElementCopyWith(
          _$_TodoElement value, $Res Function(_$_TodoElement) then) =
      __$$_TodoElementCopyWithImpl<$Res>;
  @override
  $Res call({int revision, String status, Todo element});

  @override
  $TodoCopyWith<$Res> get element;
}

/// @nodoc
class __$$_TodoElementCopyWithImpl<$Res> extends _$TodoElementCopyWithImpl<$Res>
    implements _$$_TodoElementCopyWith<$Res> {
  __$$_TodoElementCopyWithImpl(
      _$_TodoElement _value, $Res Function(_$_TodoElement) _then)
      : super(_value, (v) => _then(v as _$_TodoElement));

  @override
  _$_TodoElement get _value => super._value as _$_TodoElement;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? element = freezed,
  }) {
    return _then(_$_TodoElement(
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoElement extends _TodoElement {
  const _$_TodoElement(
      {required this.revision, required this.status, required this.element})
      : super._();

  factory _$_TodoElement.fromJson(Map<String, dynamic> json) =>
      _$$_TodoElementFromJson(json);

  @override
  final int revision;
  @override
  final String status;
  @override
  final Todo element;

  @override
  String toString() {
    return 'TodoElement(revision: $revision, status: $status, element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoElement &&
            const DeepCollectionEquality().equals(other.revision, revision) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revision),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(element));

  @JsonKey(ignore: true)
  @override
  _$$_TodoElementCopyWith<_$_TodoElement> get copyWith =>
      __$$_TodoElementCopyWithImpl<_$_TodoElement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoElementToJson(
      this,
    );
  }
}

abstract class _TodoElement extends TodoElement {
  const factory _TodoElement(
      {required final int revision,
      required final String status,
      required final Todo element}) = _$_TodoElement;
  const _TodoElement._() : super._();

  factory _TodoElement.fromJson(Map<String, dynamic> json) =
      _$_TodoElement.fromJson;

  @override
  int get revision;
  @override
  String get status;
  @override
  Todo get element;
  @override
  @JsonKey(ignore: true)
  _$$_TodoElementCopyWith<_$_TodoElement> get copyWith =>
      throw _privateConstructorUsedError;
}
