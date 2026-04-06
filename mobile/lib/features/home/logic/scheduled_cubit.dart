import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/home/logic/home_state.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/scheduled_models/scheduled_request_model.dart';
import '../data/repos/home_repo.dart';

class ScheduledCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  ScheduledCubit(this._homeRepo) : super(HomeState.initial());

  void emitScheduledState({
    required double pickupLatitude,
    required double pickupLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
    required int membersCount,
    required String token,
  }) async {
    emit(HomeState.loading());
    final response = await _homeRepo.createScheduled(
      token,
      ScheduledRequestModel(
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        destinationLatitude: destinationLatitude,
        destinationLongitude: destinationLongitude,
        membersCount: membersCount,
        requestType: 'scheduled',
        scheduledTime: '${dateController.text} ${timeController.text}',
      ),
    );
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
