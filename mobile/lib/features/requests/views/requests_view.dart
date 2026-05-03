import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/features/requests/views/widgets/emergency_requests_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/scheduled_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/scheduled_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/cancel_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/confirm_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/reject_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/sos_request_widget.dart';
import 'package:mobile/features/requests/views/widgets/toggle_widget.dart';
import '../../../core/theming/styles.dart';
import '../../../layouts/main/cubit/bottom_nav_cubit.dart';
import '../logic/requests_cubits/emergency_requests_cubit.dart';
import '../logic/requests_cubits/scheduled_requests_cubit.dart';

class RequestsView extends StatefulWidget {
  final String? token;
  final bool isDriver;

  const RequestsView({super.key, required this.token, required this.isDriver});

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
    return BlocListener<BottomNavCubit, int>(
      listener: (context, state) {
        if (state == 1) {
          _refreshActiveList();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              verticalSpacing(82),
              Text('Requests', style: TextStyles.font30BlackSemiBold),
              verticalSpacing(24),
              ToggleWidget(
                onChange: (value) {
                  setState(() {
                    isSOS = value;
                  });
                },
              ),
              verticalSpacing(20),
              Expanded(
                child: isSOS
                    ? SosRequestWidget(
                        token: widget.token ?? '',
                        isDriver: widget.isDriver,
                      )
                    : ScheduledRequestWidget(
                        token: widget.token ?? '',
                        isDriver: widget.isDriver,
                      ),
              ),
              EmergencyRequestsBlocListener(),
              ScheduledRequestsBlocListener(),
              CancelBlocListener(onSuccess: _refreshActiveList),
              if (widget.isDriver) ...[
                ConfirmBlocListener(onSuccess: _refreshActiveList),
                RejectBlocListener(onSuccess: _refreshActiveList),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _refreshActiveList() {
    if (isSOS) {
      context.read<EmergencyRequestsCubit>().emitEmergencyState(
        token: widget.token ?? '',
      );
    } else {
      context.read<ScheduledRequestsCubit>().emitScheduledState(
        token: widget.token ?? '',
      );
    }
  }
}
