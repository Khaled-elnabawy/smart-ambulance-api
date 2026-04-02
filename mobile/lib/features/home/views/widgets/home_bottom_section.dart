import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class HomeBottomSection extends StatelessWidget {
  const HomeBottomSection({super.key});

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
            Text(
              'What do you want to do?',
              style: TextStyles.font24BlackBold,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 192.w,
                    height: 192.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
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
                    context.pushNamed(Routes.scheduledFormView);
                  },
                  child: Container(
                    width: 192.w,
                    height: 192.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      border: Border.all(
                        color: ColorsManager.red,
                        width: 1,
                      ),
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
                        Text(
                          'Scheduled',
                          style: TextStyles.font32RedBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
