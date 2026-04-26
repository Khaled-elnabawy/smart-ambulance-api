import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/requests/logic/confirm_cubit/confirm_cubit.dart';
import '../../../../core/helpers/extensions.dart';
<<<<<<< HEAD
=======
import '../../../../core/routing/routes.dart';
>>>>>>> 8abbe58 (add confim request logic)
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/confirm_cubit/confirm_state.dart';


class ConfirmBlocListener extends StatelessWidget {
  final VoidCallback? onSuccess;
  const ConfirmBlocListener({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmCubit, ConfirmState>(
      listenWhen: (previous, current) =>
      current is Loading || current is Success || current is Failure,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            // show loading
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },
          success: (response) {
            setupSuccessState(context, response.message ?? '');
            onSuccess?.call();
          },
          failure: (errMessage) {
            // show error message
            setupErrorState(context, errMessage);
          },
        );
      },
      child: const SizedBox.shrink(),
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
  void setupSuccessState(BuildContext context, String successMessage) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.done, color: Colors.green, size: 32),
        content: Text(successMessage, style: TextStyles.font22BlackRegular),
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
