import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';
import '../../logic/requests_cubits/requests_state.dart';
import '../../logic/requests_cubits/scheduled_requests_cubit.dart';

class ScheduledRequestWidget extends StatelessWidget {
  final String token;

  const ScheduledRequestWidget({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRequestsCubit, RequestsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const SizedBox(),
          success: (data) {
            final requests = data.requests ?? [];
            return ListView.builder(
              itemCount: data.requests.length,
              itemBuilder: (context, index) {
                return RequestWidget(request: requests[index], token: token);
              },
            );
          },
          failure: (_) => const SizedBox(),
        );
      },
    );
  }
}
