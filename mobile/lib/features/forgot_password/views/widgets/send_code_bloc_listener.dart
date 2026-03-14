import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/forgot_password_cubit.dart';
import '../../logic/forgot_password_state.dart';

class SendCodeBlocListener extends StatelessWidget {
  const SendCodeBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is SendCodeLoading ||
          current is SendCodeSuccess ||
          current is SendCodeFailure,
      listener: (context, state) {
        state.whenOrNull(
          sendCodeLoading: () {
            // show loading
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },
          sendCodeSuccess: (sendCodeResponse) {
            context.pop();
            context.pushNamed(
              Routes.enterCodeView,
              arguments: context
                  .read<ForgotPasswordCubit>()
                  .emailController
                  .text,
            );
          },
          sendCodeFailure: (errMessage) {
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
}
