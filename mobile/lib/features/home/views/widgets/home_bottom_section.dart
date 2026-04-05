import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/emergency_models/emergency_request_model.dart';
import '../../logic/emergency_cubit.dart';
import 'emergency_bloc_listener.dart';

class HomeBottomSection extends StatelessWidget {
  final String token;
  final double latitude;
  final double longitude;

  const HomeBottomSection({
    super.key,
    required this.token,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 302.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text('What do you want to do?', style: TextStyles.font24BlackBold),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        width: 390.w,
                        padding: EdgeInsets.symmetric(vertical: 78.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Are you sure you want to proceed with emergency request?',
                              style: TextStyles.font22BlackRegular,
                            ),
                            SizedBox(height: 36.h),
                            GenericTextButton(
                              buttonText: 'Confirm',
                              textStyle: TextStyles.font16WhiteBold,
                              onPressed: () {
                                context
                                    .read<EmergencyCubit>()
                                    .emitEmergencyState(
                                      token,
                                      EmergencyRequestModel(
                                        requestType: 'emergency',
                                        pickupLatitude: latitude,
                                        pickupLongitude: longitude,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(height: 20.h),
                            GenericTextButton(
                              buttonText: 'Cancel',
                              textStyle: TextStyles.font16RedBold,
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 192.w,
                    height: 192.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.red,
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/sos_ emergency.png',
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 4.h),
                        Text('SOS', style: TextStyles.font32WhiteBold),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.scheduledFormView,arguments: token);
                  },
                  child: Container(
                    width: 192.w,
                    height: 192.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      border: Border.all(color: ColorsManager.red, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 4.h),
                        Text('Scheduled', style: TextStyles.font32RedBold),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            EmergencyBlocListener(),
          ],
        ),
      ),
    );
  }
}
