import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/features/requests/views/widgets/emergency_requests_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/scheduled_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/scheduled_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/sos_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/toggle_widget.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/back_button_widget.dart';
import '../data/repo/requests_repo.dart';
import '../logic/requests_cubits/emergency_requests_cubit.dart';
import '../logic/requests_cubits/scheduled_requests_cubit.dart';

class RequestsView extends StatefulWidget {
  final String? token;

  const RequestsView({super.key, required this.token});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  bool isSOS = true;

  @override
  void initState() {
    super.initState();
    context.read<EmergencyRequestsCubit>().emitEmergencyState(
      token: widget.token ?? '',
    );
    context.read<ScheduledRequestsCubit>().emitScheduledState(
      token: widget.token ?? '',
    );
  }

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
            Expanded(
              child: isSOS ? SosRequestWidget() : ScheduledRequestWidget(),
            ),
            EmergencyRequestsBlocListener(),
            ScheduledRequestsBlocListener(),
          ],
        ),
      ),
    );
  }
}
