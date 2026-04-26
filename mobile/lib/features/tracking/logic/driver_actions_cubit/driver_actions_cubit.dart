import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/tracking_repo.dart';
import 'driver_actions_state.dart';

class DriverActionsCubit extends Cubit<DriverActionsState> {
  final TrackingRepo _trackingRepo;

  DriverActionsCubit(this._trackingRepo) : super(const DriverActionsState.initial());

  void arrivedRequest({required String token, required int id}) async {
    emit(const DriverActionsState.actionLoading());
    final response = await _trackingRepo.arrivedRequest(token, id);
    response.when(
      success: (data) {
        emit(DriverActionsState.arrivedSuccess(data));
      },
      failure: (error) {
        emit(DriverActionsState.actionFailure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }

  void completeRequest({required String token, required int id}) async {
    emit(const DriverActionsState.actionLoading());
    final response = await _trackingRepo.completeRequest(token, id);
    response.when(
      success: (data) {
        emit(DriverActionsState.completedSuccess(data));
      },
      failure: (error) {
        emit(DriverActionsState.actionFailure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
