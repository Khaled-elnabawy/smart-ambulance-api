import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/theming/colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font55WhiteBold = TextStyle(
    fontSize: 55.sp,
    color: Colors.white,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font30BlackSemiBold = TextStyle(
    fontSize: 30.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16LightGrayWithOpacityRegular = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.lightGrey.withValues(alpha: 0.6),
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16LightGrayRegular = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.lightGrey,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font22BlackRegular = TextStyle(
    fontSize: 22.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16BlackMedium = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font16BlackRegular = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font24WhiteBold = TextStyle(
    fontSize: 24.sp,
    color: Colors.white,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font24BlackMedium = TextStyle(
    fontSize: 24.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font13GrayMedium = TextStyle(
    fontSize: 13.sp,
    color: ColorsManager.grey,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font18GreyMedium = TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.grey,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font14RedBold = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.red,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font16RedBold = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.red,
    fontWeight: FontWeightHelper.bold,
  );
}
