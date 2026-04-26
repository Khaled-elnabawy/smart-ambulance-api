import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/tracking_repo.dart';
import 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final TrackingRepo _trackingRepo;

  RatingCubit(this._trackingRepo) : super(const RatingState.initial());

  void rateDriver({required String token, required int id, required int rating}) async {
    emit(const RatingState.loading());
    final response = await _trackingRepo.rateDriver(token, id, rating);
    response.when(
      success: (data) {
        emit(RatingState.success(data));
      },
      failure: (error) {
        emit(RatingState.failure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
