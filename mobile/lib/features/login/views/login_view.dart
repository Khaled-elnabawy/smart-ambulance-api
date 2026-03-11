import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import 'package:mobile/core/widgets/generic_text_form_field.dart';
import 'package:mobile/features/login/views/widgets/do_not_have_account_text.dart';
import 'package:mobile/features/login/views/widgets/login_form.dart';
import 'package:mobile/features/login/views/widgets/login_bloc_listener.dart';
import '../../../core/theming/styles.dart';
import '../data/models/login_request_body.dart';
import '../logic/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/login_background_vector.png',
                fit: BoxFit.fill,
                width: 440.w,
                height: 482.h,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing(81),
                    SizedBox(
                      width: 324.w,
                      child: Text(
                        "Welcome Back 👋",
                        style: TextStyles.font55WhiteBold.copyWith(
                          height: 1.25.h,
                        ),
                      ),
                    ),
                    verticalSpacing(237),
                    Column(
                      children: [
                        LoginForm(),
                        GenericTextButton(
                          buttonText: 'Login',
                          textStyle: TextStyles.font24WhiteBold,
                          onPressed: () {
                            if (context
                                .read<LoginCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<LoginCubit>().emitLoginState();
                            }
                          },
                        ),
                        verticalSpacing(60),
                        const DoNotHaveAccountText(),
                        const LoginBlocListener(),
                      ],
                    ),
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
