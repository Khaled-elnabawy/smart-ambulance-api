import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_state.freezed.dart';

@freezed
class CancelState<T> with _$CancelState<T> {
  const factory CancelState.initial() = _Initial;

  const factory CancelState.loading() = Loading;

  const factory CancelState.success(T data) = Success<T>;

  const factory CancelState.failure({required String errMessage}) = Failure;
}
