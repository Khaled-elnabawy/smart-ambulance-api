import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/data/repo/requests_repo.dart';
import 'package:mobile/features/requests/logic/reject_cubit/reject_state.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/models/cancel/cancel_request_body.dart';

class RejectCubit extends Cubit<RejectState> {
  RequestsRepo _requestsRepo;

  RejectCubit(this._requestsRepo) : super(RejectState.initial());

  void emitRejectState({required String token, required int id}) async {
    emit(RejectState.loading());
    final response = await _requestsRepo.rejectRequest(
      token: token,
      cancelRequestBody: CancelRequestBody(id: id),
    );
    response.when(
      success: (data) {
        emit(RejectState.success(data));
      },
      failure: (error) {
        emit(
          RejectState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
