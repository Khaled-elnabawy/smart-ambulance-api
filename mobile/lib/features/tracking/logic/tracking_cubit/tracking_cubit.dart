import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/repos/tracking_repo.dart';
import 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingRepo _trackingRepo;
  Timer? _timer;

  TrackingCubit(this._trackingRepo) : super(const TrackingState.initial());

  void getTrackingData({required String token, required int id}) async {
    emit(const TrackingState.loading());
    final response = await _trackingRepo.trackRequest(token, id);
    response.when(
      success: (data) {
        emit(TrackingState.success(data));
      },
      failure: (error) {
        emit(TrackingState.failure(errMessage: error.apiErrorModel.message ?? ''));
      },
    );
  }

  void startPolling({required String token, required int id}) {
    // Poll every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getTrackingData(token: token, id: id);
    });
  }

  void stopPolling() {
    _timer?.cancel();
  }

  void updateDriverLocation({required String token, required double lat, required double lng}) async {
    // Just a fire-and-forget push
    await _trackingRepo.updateLocation(token, lat, lng);
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
