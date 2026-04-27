import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/helpers/extensions.dart';
import '../../../../core/theming/colors.dart';
import '../../data/models/track_request/track_request_response.dart';
import '../../logic/driver_actions_cubit/driver_actions_cubit.dart';
import '../../logic/driver_actions_cubit/driver_actions_state.dart' as driverState;
import '../../logic/tracking_cubit/tracking_cubit.dart';
import '../../logic/tracking_cubit/tracking_state.dart';
import 'rating_dialog.dart';
class TrackingListeners extends StatelessWidget {
  final Widget child;
  final int requestId;
  final String token;
  final bool isDriver;
  final Function(TrackRequestData) onTrackingDataUpdated;
  final Function(LatLng)? onLocalLocationUpdated;
  const TrackingListeners({
    super.key,
    required this.child,
    required this.requestId,
    required this.token,
    required this.isDriver,
    required this.onTrackingDataUpdated,
    this.onLocalLocationUpdated,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TrackingCubit, TrackingState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (response) {
                if (response is TrackRequestResponse && response.data != null) {
                  onTrackingDataUpdated(response.data!);
                  if (!isDriver && (response.data!.status?.toLowerCase() == 'completed' || response.data!.status?.toLowerCase() == 'complete')) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => RatingDialog(
                        requestId: requestId,
                        token: token,
                      ),
                    );
                  }
                }
              },
              locationUpdated: (latLng) {
                if (latLng is LatLng) {
                  onLocalLocationUpdated?.call(latLng);
                }
              },
            );
          },
        ),
        BlocListener<DriverActionsCubit, driverState.DriverActionsState>(
          listener: (context, state) {
            state.whenOrNull(
              actionLoading: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(color: ColorsManager.red),
                  ),
                );
              },
              arrivedSuccess: (data) {
                context.pop();
                context.read<TrackingCubit>().getTrackingData(
                  token: token,
                  id: requestId,
                );
              },
              completedSuccess: (data) {
                context.pop();
                context.pop();
              },
              actionFailure: (err) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(err)),
                );
              },
            );
          },
        ),
      ],
      child: child,
    );
  }
}
