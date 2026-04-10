import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/requests_cubits/emergency_requests_cubit.dart';
import '../../logic/requests_cubits/requests_state.dart';
import '../../logic/requests_cubits/scheduled_requests_cubit.dart';

class ScheduledRequestsBlocListener extends StatelessWidget {
  const ScheduledRequestsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduledRequestsCubit, RequestsState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },
          success: (_) {
          },
          failure: (errMessage) {
            context.pop();
            setupErrorState(context, errMessage);
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }
  void setupErrorState(BuildContext context, String errMessage) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(errMessage, style: TextStyles.font22BlackRegular),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('OK', style: TextStyles.font16RedBold),
          ),
        ],
      ),
    );
  }
}
