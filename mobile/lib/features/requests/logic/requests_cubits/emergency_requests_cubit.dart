import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/logic/requests_cubits/requests_state.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/requests/requests_request_model.dart';
import '../../data/repo/requests_repo.dart';

class EmergencyRequestsCubit extends Cubit<RequestsState> {
  RequestsRepo _requestsRepo;

  EmergencyRequestsCubit(this._requestsRepo) : super(RequestsState.initial());

  void emitEmergencyState({required String token}) async {
    emit(RequestsState.loading());
    final response = await _requestsRepo.getRequests(
      token: token,
      requestsRequestModel: RequestsRequestModel(type: 'emergency'),
    );
    if (isClosed) return;
    response.when(
      success: (data) {
        emit(RequestsState.success(data));
      },
      failure: (error) {
        emit(
          RequestsState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
