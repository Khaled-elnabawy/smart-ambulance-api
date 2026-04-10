import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/logic/requests_state.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/requests_request_model.dart';
import '../data/repo/requests_repo.dart';

class ScheduledRequestsCubit extends Cubit<RequestsState> {
  RequestsRepo _requestsRepo;

  ScheduledRequestsCubit(this._requestsRepo) : super(RequestsState.initial());


  void emitScheduledState({required String token}) async {
    emit(RequestsState.loading());
    final response = await _requestsRepo.getRequests(
      token: token,
      requestsRequestModel: RequestsRequestModel(type: 'scheduled'),
    );
    response.when(success: (data) {
      emit(RequestsState.success(data));
    }, failure: (error) {
      emit(
          RequestsState.failure(errMessage: error.apiErrorModel.message ?? ''));
    },);
  }
}
