import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/logic/emergency_requests_cubit.dart';
import 'package:mobile/features/requests/logic/requests_state.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';

class SosRequestWidget extends StatelessWidget {
  const SosRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmergencyRequestsCubit, RequestsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const SizedBox(),
          success: (data) {
            final requests = data.requests ?? [];
            return Padding(
              padding:  EdgeInsets.only(top: 24.h,left: 30.w,right: 30.w),
              child: ListView.builder(
                itemCount: data.requests.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 16.h),
                    child: RequestWidget(request: requests[index]),
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
