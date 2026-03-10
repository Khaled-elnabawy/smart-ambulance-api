import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/features/register/views/widgets/register_form.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/generic_text_button.dart';
import '../logic/register_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // TODO: delete this SizeBox
            SizedBox(width: double.infinity),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/register_background_vector.png',
                fit: BoxFit.fill,
                width: 440.w,
                height: 482.h,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    verticalSpacing(60),
                    Image.asset(
                      'assets/images/app_logo.png',
                      fit: BoxFit.fill,
                      width: 80.w,
                      height: 73.h,
                    ),
                    verticalSpacing(16),
                    SizedBox(
                      width: 324.w,
                      child: Text(
                        'Secure Your Profile. Ensure The Fastest Response',
                        style: TextStyles.font24BlackMedium,
                      ),
                    ),
                    verticalSpacing(54),
                    RegisterForm(),
                    verticalSpacing(30),
                    GenericTextButton(
                      buttonText: 'Sign Up',
                      textStyle: TextStyles.font24WhiteBold,
                      onPressed: () {
                        if (context
                            .read<RegisterCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<RegisterCubit>().emitRegisterState();
                        }
                      },
                    ),
                    verticalSpacing(16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
