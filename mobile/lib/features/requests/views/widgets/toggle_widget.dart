import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({super.key});

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  bool isSOS = true;

  double sosWidth = 69.w;
  double scheduledWidth = 124.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 208.w,
      height: 47.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(51.r),
        border: Border.all(width: 1.0, color: ColorsManager.red),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: isSOS ? 0 : sosWidth,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: isSOS ? sosWidth : scheduledWidth,
              height: 39.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(51.r),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => isSOS = true),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "SOS",
                    style: isSOS
                        ? TextStyles.font16WhiteSemiBold
                        : TextStyles.font16BlackSemiBold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => isSOS = false),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Center(
                    child: Text(
                      "Scheduled",
                      style: isSOS
                          ? TextStyles.font16BlackSemiBold
                          : TextStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
