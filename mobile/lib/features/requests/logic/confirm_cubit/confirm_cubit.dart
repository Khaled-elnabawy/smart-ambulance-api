import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/data/repo/requests_repo.dart';
import 'package:mobile/features/requests/logic/confirm_cubit/confirm_state.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/confirm/confirm_request_body.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  RequestsRepo _requestsRepo;

  ConfirmCubit(this._requestsRepo) : super(ConfirmState.initial());

  void emitConfirmState({required String token, required int id}) async {
    emit(ConfirmState.loading());
    final response = await _requestsRepo.confirmRequest(
      token: token,
      confirmRequestBody: ConfirmRequestBody(id: id),
    );
    response.when(
      success: (data) {
        emit(ConfirmState.success(data));
      },
      failure: (error) {
        emit(
          ConfirmState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
