import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_state.freezed.dart';

@freezed
class ConfirmState<T> with _$ConfirmState<T> {
  const factory ConfirmState.initial() = _Initial;

  const factory ConfirmState.loading() = Loading;

  const factory ConfirmState.success(T data) = Success<T>;

  const factory ConfirmState.failure({required String errMessage}) = Failure;
}
