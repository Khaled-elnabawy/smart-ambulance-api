import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/core/widgets/back_button_widget.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import 'package:mobile/core/widgets/generic_text_form_field.dart';

class ScheduledFormView extends StatelessWidget {
  const ScheduledFormView({super.key});

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
              height: 648.h,
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
                    GenericTextFormField(
                      hintText: 'Start point',
                      backgroundColor: Colors.white,
                      enableBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsManager.red,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(
                        Icons.location_on_rounded,
                        color: ColorsManager.red,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text('To', style: TextStyles.font16BlackRegular),
                    SizedBox(height: 4.h),
                    GenericTextFormField(
                      hintText: 'End point',
                      backgroundColor: Colors.white,
                      enableBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsManager.red,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(
                        Icons.location_city_rounded,
                        color: ColorsManager.red,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text('Date', style: TextStyles.font16BlackRegular),
                    SizedBox(height: 4.h),
                    GenericTextFormField(
                      hintText: '22,mar,2026',
                      backgroundColor: Colors.white,
                      enableBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsManager.red,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: ColorsManager.red,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text('Time', style: TextStyles.font16BlackRegular),
                    SizedBox(height: 4.h),
                    GenericTextFormField(
                      hintText: '6 : 10 PM',
                      backgroundColor: Colors.white,
                      enableBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsManager.red,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: Icon(
                        Icons.access_time_rounded,
                        color: ColorsManager.red,
                      ),
                    ),
                    SizedBox(height: 24.h),
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
                              Container(
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
                              SizedBox(width: 20.w),
                              Text('0', style: TextStyles.font24BlackBold),
                              SizedBox(width: 20.w),
                              Container(
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GenericTextButton(
                          buttonText: 'Confirm',
                          textStyle: TextStyles.font16WhiteBold,
                          buttonHeight: 45.h,
                          buttonWidth: 198.w,
                          onPressed: () {},
                        ),
                        GenericTextButton(
                          buttonText: 'Cancel',
                          textStyle: TextStyles.font16RedBold,
                          buttonHeight: 45.h,
                          buttonWidth: 198.w,
                          backgroundColor: Colors.white,
                          isHaveBorder: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
