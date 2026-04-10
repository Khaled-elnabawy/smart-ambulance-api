import 'package:freezed_annotation/freezed_annotation.dart';

part 'requests_state.freezed.dart';

@freezed
class RequestsState<T> with _$RequestsState<T> {
  const factory RequestsState.initial() = _Initial;

  const factory RequestsState.loading() = Loading;

  const factory RequestsState.success(T data) = Success<T>;

  const factory RequestsState.failure({required String errMessage}) = Failure;
}
