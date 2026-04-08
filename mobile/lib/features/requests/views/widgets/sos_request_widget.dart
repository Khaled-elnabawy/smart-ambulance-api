import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';

import '../../../../core/helpers/spacing.dart';

class SosRequestWidget extends StatelessWidget {
  const SosRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            verticalSpacing(24),
            RequestWidget(),
            verticalSpacing(24),
            RequestWidget(isPending: false, isInProgress: true),
            verticalSpacing(24),
            RequestWidget(isPending: false, isInProgress: false),
            verticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
