import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/widgets/generic_text_form_field.dart';
import 'package:mobile/features/forgot_password/views/widgets/back_icon_widget.dart';
import 'package:mobile/features/forgot_password/views/widgets/icon_with_background.dart';
import 'package:mobile/features/forgot_password/views/widgets/verify_code_bloc_listener.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/generic_text_button.dart';
import '../logic/forgot_password_cubit.dart';

class EnterCodeView extends StatelessWidget {
  const EnterCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacing(12),
                Align(alignment: Alignment.centerLeft, child: BackIconWidget()),
                verticalSpacing(45),
                IconWithBackground(
                  icon: Icon(
                    Icons.mark_email_read_outlined,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                verticalSpacing(32),
                Text('Check Your Email', style: TextStyles.font30BlackSemiBold),
                verticalSpacing(16),
                Text(
                  'We have sent a code to your registered email address. Please check your inbox.',
                  textAlign: TextAlign.center,
                  style: TextStyles.font18GreyMedium,
                ),
                verticalSpacing(24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Code',
                    style: TextStyles.font16BlackMedium,
                  ),
                ),
                verticalSpacing(8),
                Form(
                  key: context.read<ForgotPasswordCubit>().formKey,
                  child: GenericTextFormField(
                    hintText: 'Enter code',
                    hintStyle: TextStyles.font16LightGrayRegular,
                    enableBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorsManager.lightGrey,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    controller: context
                        .read<ForgotPasswordCubit>()
                        .codeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid code';
                      }
                    },
                  ),
                ),
                verticalSpacing(60),
                GenericTextButton(
                  buttonText: 'Verify Code',
                  textStyle: TextStyles.font24WhiteBold,
                  onPressed: () {
                    if (context
                        .read<ForgotPasswordCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<ForgotPasswordCubit>().verifyCode();
                    }
                  },
                ),
                verticalSpacing(48),
                const VerifyCodeBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
