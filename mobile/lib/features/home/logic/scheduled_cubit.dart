import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/home/logic/home_state.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/scheduled_models/scheduled_request_model.dart';
import '../data/repos/home_repo.dart';

class ScheduledCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final int numberOfMembers;
  final formKey = GlobalKey<FormState>();

  ScheduledCubit(this._homeRepo, {required this.numberOfMembers})
    : super(HomeState.initial());

  void emitScheduledState(
    String token,
    ScheduledRequestModel scheduledRequestModel,
  ) async {
    emit(HomeState.loading());
    final response = await _homeRepo.createScheduled(
      token,
      scheduledRequestModel,
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
