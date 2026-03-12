import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/forgot_password_cubit.dart';
import '../../logic/forgot_password_state.dart';


class VerifyCodeBlocListener extends StatelessWidget {
  const VerifyCodeBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
      current is VerifyCodeLoading || current is VerifyCodeSuccess || current is VerifyCodeFailure,
      listener: (context, state) {
        state.whenOrNull(
          verifyCodeLoading: () {
            // show loading
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },
          verifyCodeSuccess: (verifyCodeResponse) {
            context.pop();
            context.pushNamed(Routes.resetPasswordView);
          },
          verifyCodeFailure: (errMessage) {
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
