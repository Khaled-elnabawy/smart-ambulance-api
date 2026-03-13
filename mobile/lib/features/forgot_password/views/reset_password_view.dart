import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:mobile/features/forgot_password/views/widgets/back_icon_widget.dart';
import 'package:mobile/features/forgot_password/views/widgets/icon_with_background.dart';
import 'package:mobile/features/forgot_password/views/widgets/reset_password_bloc_listener.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/generic_text_button.dart';
import '../../../core/widgets/generic_text_form_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                verticalSpacing(12),
                Align(alignment: Alignment.centerLeft, child: BackIconWidget()),
                verticalSpacing(45),
                IconWithBackground(
                  icon: Transform.flip(
                    flipX: true,
                    child: Icon(
                      Icons.lock_reset_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                verticalSpacing(32),
                Text('Set New Password', style: TextStyles.font30BlackSemiBold),
                verticalSpacing(16),
                Text(
                  'Your new password must be different from previously used passwords.',
                  textAlign: TextAlign.center,
                  style: TextStyles.font18GreyMedium,
                ),
                verticalSpacing(24),
                Form(
                  key: context.read<ForgotPasswordCubit>().formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'New password',
                          style: TextStyles.font16BlackMedium,
                        ),
                      ),
                      verticalSpacing(8),
                      GenericTextFormField(
                        hintText: 'Enter new password',
                        hintStyle: TextStyles.font16LightGrayRegular,
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        isObscureText: isObscureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                        enableBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.lightGrey,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.white,
                        // TODO: add controller
                        //controller: ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                        },
                      ),
                      verticalSpacing(16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirm new password',
                          style: TextStyles.font16BlackMedium,
                        ),
                      ),
                      verticalSpacing(8),
                      GenericTextFormField(
                        hintText: 'Enter confirm new password',
                        hintStyle: TextStyles.font16LightGrayRegular,
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        isObscureText: isObscureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                        enableBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.lightGrey,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.white,
                        // TODO: add controller
                        //controller: ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpacing(60),
                GenericTextButton(
                  buttonText: 'Reset Password',
                  textStyle: TextStyles.font24WhiteBold,
                  onPressed: () {
                    if (context
                        .read<ForgotPasswordCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<ForgotPasswordCubit>().resetPassword();
                    }
                  },
                ),
                verticalSpacing(48),
                const ResetPasswordBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
