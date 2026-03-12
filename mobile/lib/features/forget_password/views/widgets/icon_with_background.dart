import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

class IconWithBackground extends StatelessWidget {
  final Widget icon;
  const IconWithBackground({super.key,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136.w,
      height: 136.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsManager.red,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.red.withValues(alpha: 0.5),
            spreadRadius: 17,
          ),
        ],
      ),
      child: icon,
    );
  }
}
