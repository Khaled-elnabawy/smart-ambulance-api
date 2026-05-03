import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_actions_state.freezed.dart';

@freezed
class DriverActionsState<T> with _$DriverActionsState<T> {
  const factory DriverActionsState.initial() = _Initial;
  const factory DriverActionsState.actionLoading() = ActionLoading;
  const factory DriverActionsState.arrivedSuccess(T data) = ArrivedSuccess<T>;
  const factory DriverActionsState.completedSuccess(T data) = CompletedSuccess<T>;
  const factory DriverActionsState.actionFailure({required String errMessage}) = ActionFailure;
}
