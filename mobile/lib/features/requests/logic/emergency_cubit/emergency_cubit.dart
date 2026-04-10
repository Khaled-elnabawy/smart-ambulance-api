import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/logic/emergency_cubit/emergency_state.dart';
import '../../data/models/requests_request_model.dart';
import '../../data/repo/requests_repo.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  RequestsRepo _requestsRepo;

  EmergencyCubit(this._requestsRepo) : super(EmergencyState.initial());

  void emitEmergencyState({required String token}) async {
    emit(EmergencyState.loading());
    final response = await _requestsRepo.getRequests(
        token: token,
        requestsRequestModel: RequestsRequestModel(type: 'emergency'));
  }

}
