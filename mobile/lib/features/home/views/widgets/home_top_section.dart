import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154.h,
      decoration: BoxDecoration(
        color: ColorsManager.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Text('Hello Amr', style: TextStyles.font24WhiteBold),
            SizedBox(height: 4.h),
            Text('Are you okay?', style: TextStyles.font20WhiteBold),
          ],
        ),
      ),
    );
  }
}
