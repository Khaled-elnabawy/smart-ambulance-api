import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/features/requests/views/widgets/scheduled_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/sos_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/toggle_widget.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/back_button_widget.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  bool isSOS = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpacing(12),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BackButtonWidget(),
              ),
            ),
            verticalSpacing(32),
            Text('Requests', style: TextStyles.font30BlackSemiBold),
            verticalSpacing(24),
            ToggleWidget(
              onChange: (value) {
                setState(() {
                  isSOS = value;
                });
              },
            ),
            Expanded(child: isSOS ? SosRequestWidget() : ScheduledRequestWidget()),
          ],
        ),
      ),
    );
  }
}
