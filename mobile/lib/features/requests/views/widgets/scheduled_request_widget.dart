import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';

import '../../../../core/helpers/spacing.dart';

class ScheduledRequestWidget extends StatelessWidget {
  const ScheduledRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
           verticalSpacing(24),
            RequestWidget(isSOS: false),
            verticalSpacing(24),
            RequestWidget(isSOS: false, isPending: false, isInProgress: true),
            verticalSpacing(24),
            RequestWidget(isSOS: false, isPending: false, isInProgress: false),
          ],
        ),
      ),
    );
  }
}
