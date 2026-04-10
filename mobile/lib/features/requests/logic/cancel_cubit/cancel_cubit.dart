import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/data/repo/requests_repo.dart';
import 'package:mobile/features/requests/logic/cancel_cubit/cancel_state.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/cancel/cancel_request_body.dart';

class CancelCubit extends Cubit<CancelState> {
  RequestsRepo _requestsRepo;

  CancelCubit(this._requestsRepo) : super(CancelState.initial());

  void emitCancelState({required String token, required int id}) async {
    emit(CancelState.loading());
    final response = await _requestsRepo.cancelRequests(
      token: token,
      cancelRequestBody: CancelRequestBody(id: id),
    );
    response.when(
      success: (data) {
        emit(CancelState.success(data));
      },
      failure: (error) {
        emit(
          CancelState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
