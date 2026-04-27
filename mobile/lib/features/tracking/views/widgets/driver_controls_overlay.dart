import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/generic_text_button.dart';
import '../../data/models/track_request/track_request_response.dart';
import '../../logic/driver_actions_cubit/driver_actions_cubit.dart';

class DriverControlsOverlay extends StatelessWidget {
  final bool isDriver;
  final TrackRequestData? requestData;
  final String token;
  final int requestId;

  const DriverControlsOverlay({
    super.key,
    required this.isDriver,
    this.requestData,
    required this.token,
    required this.requestId,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDriver || requestData == null) return const SizedBox.shrink();

    bool isAccepted = requestData!.status == 'accepted';
    bool isArrived = requestData!.status == 'arrived';

    if (!isAccepted && !isArrived) return const SizedBox.shrink();

    return Positioned(
      bottom: 40.h,
      left: 30.w,
      right: 30.w,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              isAccepted ? "Nearest Ambulance" : "At Location",
              style: TextStyles.font16BlackBold,
            ),
            verticalSpacing(16),
            GenericTextButton(
              buttonText: isAccepted ? 'Arrived' : 'Complete',
              textStyle: TextStyles.font16WhiteBold,
              backgroundColor: ColorsManager.red,
              onPressed: () {
                if (isAccepted) {
                  context.read<DriverActionsCubit>().arrivedRequest(
                        token: token,
                        id: requestId,
                      );
                } else if (isArrived) {
                  context.read<DriverActionsCubit>().completeRequest(
                        token: token,
                        id: requestId,
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
