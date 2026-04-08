import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/features/requests/views/widgets/toggle_widget.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/back_button_widget.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              verticalSpacing(12),
              Align(alignment: Alignment.centerLeft, child: BackButtonWidget()),
              verticalSpacing(32),
              Text('Requests', style: TextStyles.font30BlackSemiBold),
              verticalSpacing(24),
              ToggleWidget(),
              verticalSpacing(24),

            ],
          ),
        ),
      ),
    );
  }
}
