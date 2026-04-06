import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/core/widgets/back_button_widget.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import 'package:mobile/features/home/views/widgets/date_time_widget.dart';
import 'package:mobile/core/helpers/extensions.dart';
import 'package:mobile/features/home/views/widgets/scheduled_bloc_listener.dart';

import '../../../core/routing/routes.dart';
import '../logic/scheduled_cubit.dart';

class ScheduledFormView extends StatefulWidget {
  final String? token;
  final LatLng? startLocation;
  final LatLng? endLocation;

  const ScheduledFormView({
    super.key,
    required this.token,
    this.startLocation,
    this.endLocation,
  });

  @override
  State<ScheduledFormView> createState() => _ScheduledFormViewState();
}

class _ScheduledFormViewState extends State<ScheduledFormView> {
  LatLng? startLocation;
  LatLng? endLocation;
  int membersCount = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    startLocation = widget.startLocation;
    endLocation = widget.endLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: BackButtonWidget(),
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/scheduled.png',
              width: 178.w,
              height: 178.h,
            ),
            Container(
              height: 628.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 32.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From', style: TextStyles.font16BlackRegular),
                    SizedBox(height: 4.h),
                    GenericTextButton(
                      buttonText: startLocation == null
                          ? 'Click to pickup your start point'
                          : 'Lat: ${startLocation!.latitude.toStringAsFixed(4)}, Long: ${startLocation!.longitude.toStringAsFixed(4)}',
                      textStyle: TextStyles.font20WhiteBold,
                      onPressed: () async {
                        final result = await context.pushNamed(
                          Routes.clickableGoogleMap,
                        );
                        if (result is LatLng) {
                          setState(() {
                            startLocation = result;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text('To', style: TextStyles.font16BlackRegular),
                    SizedBox(height: 4.h),
                    GenericTextButton(
                      buttonText: endLocation == null
                          ? 'Click to pickup your end point'
                          : 'Lat: ${endLocation!.latitude.toStringAsFixed(4)}, Long: ${endLocation!.longitude.toStringAsFixed(4)}',
                      textStyle: TextStyles.font20WhiteBold,
                      onPressed: () async {
                        final result = await context.pushNamed(
                          Routes.clickableGoogleMap,
                        );
                        if (result is LatLng) {
                          setState(() {
                            endLocation = result;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    DateTimeWidget(
                      onDateTimeChanged: (date, time) {
                        setState(() {
                          selectedDate = date;
                          selectedTime = time;
                        });
                      },
                    ),
                    SizedBox(height: 38.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Text(
                            'Number of members',
                            style: TextStyles.font16BlackRegular,
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (membersCount > 0) membersCount--;
                                  });
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24.w),
                              Text(
                                membersCount.toString(),
                                style: TextStyles.font24BlackBold,
                              ),
                              SizedBox(width: 24.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    membersCount++;
                                  });
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GenericTextButton(
                          buttonText: 'Confirm',
                          textStyle: TextStyles.font16WhiteBold,
                          buttonHeight: 45.h,
                          buttonWidth: 198.w,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Container(
                                width: 390.w,
                                padding: EdgeInsets.symmetric(vertical: 78.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
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
                                            .read<ScheduledCubit>()
                                            .emitScheduledState(
                                              token: widget.token ?? '',
                                              pickupLatitude: widget
                                                  .startLocation!
                                                  .latitude,
                                              pickupLongitude: widget
                                                  .startLocation!
                                                  .longitude,
                                              destinationLatitude:
                                                  widget.endLocation!.latitude,
                                              destinationLongitude:
                                                  widget.endLocation!.longitude,
                                              membersCount: membersCount,
                                              date: DateFormat(
                                                'dd, MMM, yyyy',
                                              ).format(selectedDate!),
                                              time: selectedTime!.format(
                                                context,
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
                        ),
                        GenericTextButton(
                          buttonText: 'Cancel',
                          textStyle: TextStyles.font16RedBold,
                          buttonHeight: 45.h,
                          buttonWidth: 198.w,
                          backgroundColor: Colors.white,
                          isHaveBorder: true,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ScheduledBlocListener(),
          ],
        ),
      ),
    );
  }
}
