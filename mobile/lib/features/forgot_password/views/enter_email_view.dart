import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import 'package:mobile/core/widgets/generic_text_form_field.dart';
import 'package:mobile/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:mobile/features/forgot_password/views/widgets/back_icon_widget.dart';
import 'package:mobile/features/forgot_password/views/widgets/send_code_bloc_listener.dart';

class EnterEmailView extends StatelessWidget {
  const EnterEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(12),
              BackIconWidget(),
              verticalSpacing(60),
              Text('Forget Password', style: TextStyles.font30BlackSemiBold),
              verticalSpacing(16),
              Text(
                'Enter Your email address and we will send you a code to reset your password.',
                style: TextStyles.font18GreyMedium,
              ),
              verticalSpacing(32),
              Text('Email Address', style: TextStyles.font16BlackMedium),
              verticalSpacing(8),
              Form(
                key: context.read<ForgotPasswordCubit>().formKey,
                child: GenericTextFormField(
                  hintText: 'Enter your email',
                  hintStyle: TextStyles.font16LightGrayRegular,
                  enableBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.lightGrey,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: ColorsManager.red,
                  ),
                  controller: context
                      .read<ForgotPasswordCubit>()
                      .emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                  },
                ),
              ),
              Spacer(),
              GenericTextButton(
                buttonText: 'Send Reset Code',
                textStyle: TextStyles.font24WhiteBold,
                onPressed: () {
                  if (context
                      .read<ForgotPasswordCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context.read<ForgotPasswordCubit>().sendCode();
                  }
                },
              ),
              verticalSpacing(48),
              const SendCodeBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
