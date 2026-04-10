import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/logic/requests_state.dart';
import '../data/models/requests_request_model.dart';
import '../data/repo/requests_repo.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsRepo _requestsRepo;

  RequestsCubit(this._requestsRepo) : super(RequestsState.initial());

  void emitEmergencyState({required String token}) async {
    emit(RequestsState.loading());
    final response = await _requestsRepo.getRequests(
        token: token,
        requestsRequestModel: RequestsRequestModel(type: 'emergency'));
  }

}
