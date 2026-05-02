import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/repos/tracking_repo.dart';
import 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingRepo _trackingRepo;
  Timer? _timer;
  StreamSubscription<LatLng>? _locationSubscription;

  TrackingCubit(this._trackingRepo) : super(const TrackingState.initial());

  void getTrackingData({required String token, required int id}) async {
    final response = await _trackingRepo.trackRequest(token, id);
    response.when(
      success: (data) {
        emit(TrackingState.success(data));
      },
      failure: (error) {
        emit(
          TrackingState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }

  void initTracking({
    required String token,
    required int id,
    required bool isDriver,
  }) {
    stopTracking(); // Clean up if re-initializing

    if (isDriver) {
      _startDriverTracking(token, id);
    } else {
      _startUserTracking(token, id);
    }
  }

  void _startDriverTracking(String token, int id) {
    emit(const TrackingState.loading());
    getTrackingData(token: token, id: id);


    _locationSubscription = _trackingRepo.getLiveLocation().listen((latLng) {
      emit(TrackingState.locationUpdated(latLng));
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      getTrackingData(token: token, id: id);
      final currentLocation = await _trackingRepo.locationService
          .getCurrentLocationOnce();
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        await _trackingRepo.updateLocation(
          token,
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
      }
    });
  }

  void _startUserTracking(String token, int id) {
    emit(const TrackingState.loading());
    getTrackingData(token: token, id: id);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getTrackingData(token: token, id: id);
    });
  }

  void stopTracking() {
    _timer?.cancel();
    _locationSubscription?.cancel();
    _timer = null;
    _locationSubscription = null;
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}
