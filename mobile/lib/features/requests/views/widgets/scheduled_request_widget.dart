import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';
import '../../logic/requests_cubits/requests_state.dart';
import '../../logic/requests_cubits/scheduled_requests_cubit.dart';

class ScheduledRequestWidget extends StatefulWidget {
  final String token;

  const ScheduledRequestWidget({super.key, required this.token});

  @override
  State<ScheduledRequestWidget> createState() => _ScheduledRequestWidgetState();
}

class _ScheduledRequestWidgetState extends State<ScheduledRequestWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduledRequestsCubit>().emitScheduledState(
      token: widget.token ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRequestsCubit, RequestsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const SizedBox(),
          success: (data) {
            final requests = data.requests ?? [];
            return Padding(
              padding: EdgeInsets.only(top: 24.h, left: 30.w, right: 30.w),
              child: ListView.builder(
                itemCount: data.requests.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.0.h),
                    child: RequestWidget(
                      request: requests[index],
                      token: widget.token,
                    ),
                  );
                },
              ),
            );
          },
          failure: (_) => const SizedBox(),
        );
      },
    );
  }
}
