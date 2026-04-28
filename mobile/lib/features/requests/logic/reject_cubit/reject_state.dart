import 'package:freezed_annotation/freezed_annotation.dart';

part 'reject_state.freezed.dart';

@freezed
class RejectState<T> with _$RejectState<T> {
  const factory RejectState.initial() = _Initial;

  const factory RejectState.loading() = Loading;

  const factory RejectState.success(T data) = Success<T>;

  const factory RejectState.failure({required String errMessage}) = Failure;
}
