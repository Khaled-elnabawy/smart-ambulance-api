import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/back_button_widget.dart';

class TrackingHeaderOverlay extends StatelessWidget {
  final bool isDriver;

  const TrackingHeaderOverlay({
    super.key,
    required this.isDriver,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 20.w,
      right: 20.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButtonWidget(),
          verticalSpacing(16),
          if (!isDriver)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You're Not Alone, Help\nIs Coming....",
                    style: TextStyles.font22BlackBold,
                  ),
                  verticalSpacing(8),
                  Text(
                    "Your Ambulance Is En Route And Being\nMonitored Moment By Moment",
                    style: TextStyles.font16LightGrayWithOpacityMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
