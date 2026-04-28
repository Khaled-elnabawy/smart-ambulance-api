import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/logic/requests_cubits/emergency_requests_cubit.dart';
import 'package:mobile/features/requests/views/widgets/request_widget.dart';
import '../../logic/requests_cubits/requests_state.dart';

class SosRequestWidget extends StatelessWidget {
  final String token;
  final bool isDriver;

  const SosRequestWidget({
    super.key,
    required this.token,
    required this.isDriver,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmergencyRequestsCubit, RequestsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const SizedBox(),
          success: (data) {
            final requests = data.requests ?? [];
            return ListView.builder(
              itemCount: data.requests.length,
              itemBuilder: (context, index) {
                return RequestWidget(
                  request: requests[index],
                  token: token,
                  isDriver: isDriver,
                );
              },
            );
          },
          failure: (_) => const SizedBox(),
        );
      },
    );
  }
}
