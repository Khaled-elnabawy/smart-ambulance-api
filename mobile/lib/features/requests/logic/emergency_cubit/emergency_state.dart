import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_state.freezed.dart';

@freezed
class EmergencyState<T> with _$EmergencyState<T> {
  const factory EmergencyState.initial() = _Initial;

  const factory EmergencyState.loading() = Loading;

  const factory EmergencyState.success(T data) = Success<T>;

  const factory EmergencyState.failure({required String errMessage}) = Failure;
}
