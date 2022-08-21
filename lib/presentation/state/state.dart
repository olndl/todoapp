import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class State<T> with _$State<T> {
  const State._();

  const factory State.init() = _init<T>;
  const factory State.loading() = _loading;
  const factory State.successRemote(final T data) = _successRemote<T>;
  const factory State.successLocal(final T data) = _successLocal<T>;
  const factory State.error(final Exception exception) = _error;

  bool get isInit => maybeWhen(init: () => true, orElse: () => false);

  bool get isLoading =>  maybeWhen(loading: () => true, orElse: () => false);

  bool get isSuccessRemote => maybeMap(successRemote: (_) => true, orElse: () => false);

  bool get isSuccessLocal => maybeMap(successLocal: (_) => true, orElse: () => false);

  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

  T? get dataRemote => maybeWhen(successRemote: (data) => data, orElse: () => null);

  T? get dataLocal => maybeWhen(successLocal: (data) => data, orElse: () => null);

}
