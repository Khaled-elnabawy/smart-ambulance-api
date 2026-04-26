import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracking_state.freezed.dart';

@freezed
class TrackingState<T> with _$TrackingState<T> {
  const factory TrackingState.initial() = _Initial;
  const factory TrackingState.loading() = Loading;
  const factory TrackingState.success(T data) = Success<T>;
  const factory TrackingState.failure({required String errMessage}) = Failure;
}
