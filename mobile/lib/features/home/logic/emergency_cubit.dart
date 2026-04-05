import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/networking/api_result.dart';
import 'package:mobile/features/home/data/models/emergency_models/emergency_request_model.dart';

import '../data/models/scheduled_models/scheduled_request_model.dart';
import '../data/repos/home_repo.dart';
import 'home_state.dart';

class EmergencyCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  EmergencyCubit(this._homeRepo) : super(HomeState.initial());

  void emitEmergencyState(EmergencyRequestModel emergencyRequestModel) async {
    emit(HomeState.loading());
    final response = await _homeRepo.createEmergency(emergencyRequestModel);
    response.when(
      success: (emergencyResponseModel) {
        emit(HomeState.success(emergencyResponseModel));
      },
      failure: (error) {
        emit(HomeState.failure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }

  void emitScheduledState(ScheduledRequestModel scheduledRequestModel) async {
    emit(HomeState.loading());
    final response = await _homeRepo.createScheduled(scheduledRequestModel);
    response.when(
      success: (scheduledResponseModel) {
        emit(HomeState.success(scheduledResponseModel));
      },
      failure: (error) {
        emit(HomeState.failure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
